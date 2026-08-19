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
WITH CHECK (true);

DROP POLICY IF EXISTS "Allow update profiles" ON public.profiles;
CREATE POLICY "Allow update profiles"
ON public.profiles FOR UPDATE
TO anon, authenticated
USING (true)
WITH CHECK (true);

DROP POLICY IF EXISTS "Allow delete profiles" ON public.profiles;
CREATE POLICY "Allow delete profiles"
ON public.profiles FOR DELETE
TO anon, authenticated
USING (true);

-- ----------------------------------------------------------------------------
-- PAYMENT ACCOUNTS POLICIES
-- ----------------------------------------------------------------------------
DROP POLICY IF EXISTS "Allow all on payment_accounts" ON public.payment_accounts;
CREATE POLICY "Allow all on payment_accounts"
ON public.payment_accounts FOR ALL
TO anon, authenticated
USING (true)
WITH CHECK (true);

-- ----------------------------------------------------------------------------
-- TIPS POLICIES
-- ----------------------------------------------------------------------------
DROP POLICY IF EXISTS "Allow all on tips" ON public.tips;
CREATE POLICY "Allow all on tips"
ON public.tips FOR ALL
TO anon, authenticated
USING (true)
WITH CHECK (true);

-- ----------------------------------------------------------------------------
-- WALLETS POLICIES
-- ----------------------------------------------------------------------------
DROP POLICY IF EXISTS "Allow all on wallets" ON public.wallets;
CREATE POLICY "Allow all on wallets"
ON public.wallets FOR ALL
TO anon, authenticated
USING (true)
WITH CHECK (true);

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
