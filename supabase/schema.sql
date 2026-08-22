-- ============================================================================
-- amTips Database Schema & Row-Level Security (RLS) Configuration
-- Run this script in the Supabase SQL Editor (Dashboard -> SQL Editor -> New query)
-- ============================================================================

-- 1. Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Profiles Table
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    firebase_uid TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL DEFAULT '',
    avatar_url TEXT,
    restaurant_name TEXT NOT NULL DEFAULT '',
    city TEXT NOT NULL DEFAULT '',
    country TEXT NOT NULL DEFAULT '',
    personal_message TEXT,
    average_rating NUMERIC(3, 2) NOT NULL DEFAULT 0.0,
    total_ratings INTEGER NOT NULL DEFAULT 0,
    qr_token TEXT NOT NULL DEFAULT '',
    professions TEXT[] NOT NULL DEFAULT '{}',
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- Index for fast lookup by Firebase UID
CREATE INDEX IF NOT EXISTS idx_profiles_firebase_uid ON public.profiles(firebase_uid);

-- 3. Payment Accounts Table
CREATE TABLE IF NOT EXISTS public.payment_accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    waiter_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    provider TEXT NOT NULL,
    account_identifier TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

CREATE INDEX IF NOT EXISTS idx_payment_accounts_waiter_id ON public.payment_accounts(waiter_id);

-- 4. Tips Table
CREATE TABLE IF NOT EXISTS public.tips (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    waiter_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    amount NUMERIC NOT NULL,
    currency TEXT NOT NULL DEFAULT 'BIF',
    status TEXT NOT NULL DEFAULT 'completed', -- 'pending', 'completed', 'failed'
    is_anonymous BOOLEAN NOT NULL DEFAULT false,
    customer_name TEXT,
    message TEXT,
    rating INTEGER,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

CREATE INDEX IF NOT EXISTS idx_tips_waiter_id ON public.tips(waiter_id);
CREATE INDEX IF NOT EXISTS idx_tips_status ON public.tips(status);
CREATE INDEX IF NOT EXISTS idx_tips_created_at ON public.tips(created_at DESC);

-- 5. Wallets Table
CREATE TABLE IF NOT EXISTS public.wallets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    waiter_id UUID UNIQUE NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    balance NUMERIC NOT NULL DEFAULT 0,
    currency TEXT NOT NULL DEFAULT 'BIF',
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

CREATE INDEX IF NOT EXISTS idx_wallets_waiter_id ON public.wallets(waiter_id);

-- ============================================================================
-- Row-Level Security (RLS) Policies
-- Since authentication is handled via Firebase Auth, the mobile client connects
-- to Supabase PostgREST using the anon public role. We grant appropriate policies
-- to both `anon` and `authenticated` roles.
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payment_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tips ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wallets ENABLE ROW LEVEL SECURITY;

-- ----------------------------------------------------------------------------
-- PROFILES POLICIES
-- The app passes firebase_uid via the app client (anon key).
-- SELECT is open so customers can view waiter profiles without auth.
-- INSERT/UPDATE are scoped to the requesting user's firebase_uid via request header.
-- DELETE is disallowed — use is_active = false instead.
-- ----------------------------------------------------------------------------
DROP POLICY IF EXISTS "Allow select profiles" ON public.profiles;
CREATE POLICY "Allow select profiles"
ON public.profiles FOR SELECT
TO anon, authenticated
USING (true);

DROP POLICY IF EXISTS "Allow insert profiles" ON public.profiles;
CREATE POLICY "Allow insert profiles"
ON public.profiles FOR INSERT
TO anon, authenticated
WITH CHECK (firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid'));

DROP POLICY IF EXISTS "Allow update profiles" ON public.profiles;
CREATE POLICY "Allow update profiles"
ON public.profiles FOR UPDATE
TO anon, authenticated
USING (firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid'))
WITH CHECK (firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid'));

-- No DELETE policy — soft-delete via is_active flag only.

-- ----------------------------------------------------------------------------
-- PAYMENT ACCOUNTS POLICIES
-- Only the owning waiter can manage their payment accounts.
-- ----------------------------------------------------------------------------
DROP POLICY IF EXISTS "Allow all on payment_accounts" ON public.payment_accounts;

CREATE POLICY "Select own payment_accounts"
ON public.payment_accounts FOR SELECT
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

CREATE POLICY "Insert own payment_accounts"
ON public.payment_accounts FOR INSERT
TO anon, authenticated
WITH CHECK (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

CREATE POLICY "Update own payment_accounts"
ON public.payment_accounts FOR UPDATE
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

CREATE POLICY "Delete own payment_accounts"
ON public.payment_accounts FOR DELETE
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

-- ----------------------------------------------------------------------------
-- TIPS POLICIES
-- INSERT is open to anon (customers tip without an account).
-- SELECT/UPDATE/DELETE are restricted to the receiving waiter.
-- ----------------------------------------------------------------------------
DROP POLICY IF EXISTS "Allow all on tips" ON public.tips;

CREATE POLICY "Anyone can insert tips"
ON public.tips FOR INSERT
TO anon, authenticated
WITH CHECK (true);

CREATE POLICY "Waiter can select own tips"
ON public.tips FOR SELECT
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

CREATE POLICY "Waiter can update own tips"
ON public.tips FOR UPDATE
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

-- ----------------------------------------------------------------------------
-- WALLETS POLICIES
-- Only the owning waiter can read/update their wallet.
-- INSERT is restricted (wallet created server-side on profile creation).
-- ----------------------------------------------------------------------------
DROP POLICY IF EXISTS "Allow all on wallets" ON public.wallets;

CREATE POLICY "Waiter can select own wallet"
ON public.wallets FOR SELECT
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

CREATE POLICY "Waiter can update own wallet"
ON public.wallets FOR UPDATE
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

CREATE POLICY "Waiter can insert own wallet"
ON public.wallets FOR INSERT
TO anon, authenticated
WITH CHECK (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

-- ============================================================================
-- STORAGE BUCKETS & STORAGE POLICIES
-- ============================================================================

-- Create buckets if they don't exist
INSERT INTO storage.buckets (id, name, public)
VALUES 
    ('avatars', 'avatars', true),
    ('qr-codes', 'qr-codes', true),
    ('user-uploads', 'user-uploads', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Storage Policies for Avatars
DROP POLICY IF EXISTS "Allow public avatar select" ON storage.objects;
CREATE POLICY "Allow public avatar select"
ON storage.objects FOR SELECT
TO anon, authenticated
USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "Allow public avatar insert" ON storage.objects;
CREATE POLICY "Allow public avatar insert"
ON storage.objects FOR INSERT
TO anon, authenticated
WITH CHECK (bucket_id = 'avatars');

DROP POLICY IF EXISTS "Allow public avatar update" ON storage.objects;
CREATE POLICY "Allow public avatar update"
ON storage.objects FOR UPDATE
TO anon, authenticated
USING (bucket_id = 'avatars')
WITH CHECK (bucket_id = 'avatars');

DROP POLICY IF EXISTS "Allow public avatar delete" ON storage.objects;
CREATE POLICY "Allow public avatar delete"
ON storage.objects FOR DELETE
TO anon, authenticated
USING (bucket_id = 'avatars');

-- Storage Policies for QR Codes
DROP POLICY IF EXISTS "Allow public qr select" ON storage.objects;
CREATE POLICY "Allow public qr select"
ON storage.objects FOR SELECT
TO anon, authenticated
USING (bucket_id = 'qr-codes');

DROP POLICY IF EXISTS "Allow public qr insert" ON storage.objects;
CREATE POLICY "Allow public qr insert"
ON storage.objects FOR INSERT
TO anon, authenticated
WITH CHECK (bucket_id = 'qr-codes');

DROP POLICY IF EXISTS "Allow public qr update" ON storage.objects;
CREATE POLICY "Allow public qr update"
ON storage.objects FOR UPDATE
TO anon, authenticated
USING (bucket_id = 'qr-codes')
WITH CHECK (bucket_id = 'qr-codes');

-- Storage Policies for User Uploads
DROP POLICY IF EXISTS "Allow public user-uploads select" ON storage.objects;
CREATE POLICY "Allow public user-uploads select"
ON storage.objects FOR SELECT
TO anon, authenticated
USING (bucket_id = 'user-uploads');

DROP POLICY IF EXISTS "Allow public user-uploads insert" ON storage.objects;
CREATE POLICY "Allow public user-uploads insert"
ON storage.objects FOR INSERT
TO anon, authenticated
WITH CHECK (bucket_id = 'user-uploads');

DROP POLICY IF EXISTS "Allow public user-uploads update" ON storage.objects;
CREATE POLICY "Allow public user-uploads update"
ON storage.objects FOR UPDATE
TO anon, authenticated
USING (bucket_id = 'user-uploads')
WITH CHECK (bucket_id = 'user-uploads');

-- ============================================================================
-- MIGRATION: Add professions column (run once on existing databases)
-- ============================================================================
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS professions TEXT[] NOT NULL DEFAULT '{}';

-- ============================================================================
-- MIGRATION: Add professions column (run once on existing databases)
-- ============================================================================
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS professions TEXT[] NOT NULL DEFAULT '{}';

-- ============================================================================
-- MIGRATION: Profession-first platform update
-- amTips is no longer restaurant-only. restaurant_name is now a generic
-- "workplace / venue" field — optional context for any profession.
-- Run this block once in the Supabase SQL Editor.
-- ============================================================================

-- 1. Rename the column comment so the schema documents the new intent.
--    (PostgreSQL COMMENT does not require a rename — data is unchanged.)
COMMENT ON COLUMN public.profiles.restaurant_name IS
  'Generic workplace or venue name — e.g. restaurant, music club, YouTube channel. '
  'Empty string means the person works independently. Not limited to restaurants.';

-- 2. Ensure professions column exists with correct type (idempotent).
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS professions TEXT[] NOT NULL DEFAULT '{}';

-- 3. GIN index on professions for fast array-contains queries,
--    e.g. WHERE professions @> ARRAY['🎵 Musician / Singer']
CREATE INDEX IF NOT EXISTS idx_profiles_professions
  ON public.profiles USING GIN (professions);

-- 4. Add a generated tsvector column for full-text search across
--    name, workplace, city, and professions so the discovery feature
--    can search "musician Bujumbura" or "taxi driver".
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS search_vector tsvector
  GENERATED ALWAYS AS (
    to_tsvector('simple',
      coalesce(full_name,        '') || ' ' ||
      coalesce(restaurant_name,  '') || ' ' ||
      coalesce(city,             '') || ' ' ||
      coalesce(country,          '') || ' ' ||
      coalesce(array_to_string(professions, ' '), '')
    )
  ) STORED;

CREATE INDEX IF NOT EXISTS idx_profiles_search_vector
  ON public.profiles USING GIN (search_vector);

-- 5. Public profile view — returns only safe fields including professions.
--    Customers use this view; it never exposes firebase_uid or payment data.
CREATE OR REPLACE VIEW public.public_profiles AS
SELECT
  id,
  full_name,
  avatar_url,
  restaurant_name,   -- kept as column name for backward compat; means "workplace"
  city,
  country,
  personal_message,
  average_rating,
  total_ratings,
  professions,
  qr_token,
  is_active
FROM public.profiles
WHERE is_active = true;

-- Grant SELECT on the view to anon (customers can read without auth)
GRANT SELECT ON public.public_profiles TO anon, authenticated;

-- ============================================================================
-- END: Profession-first platform migration
-- ============================================================================
