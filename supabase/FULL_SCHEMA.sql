-- ============================================================================
-- amTips — FULL DATABASE SCHEMA (consolidated, ordered, idempotent)
-- Run this in Supabase Dashboard → SQL Editor on a fresh database.
-- All statements use IF NOT EXISTS / CREATE OR REPLACE — safe to re-run.
-- ============================================================================

-- ── Extensions ────────────────────────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================================
-- TABLES
-- ============================================================================

-- ── 1. profiles ───────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.profiles (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  firebase_uid     TEXT        UNIQUE NOT NULL,
  full_name        TEXT        NOT NULL DEFAULT '',
  avatar_url       TEXT,
  restaurant_name  TEXT        NOT NULL DEFAULT '',  -- generic "workplace/venue"
  city             TEXT        NOT NULL DEFAULT '',
  country          TEXT        NOT NULL DEFAULT '',
  personal_message TEXT,
  average_rating   NUMERIC(3,2) NOT NULL DEFAULT 0.0,
  total_ratings    INTEGER     NOT NULL DEFAULT 0,
  qr_token         TEXT        NOT NULL DEFAULT '',
  professions      TEXT[]      NOT NULL DEFAULT '{}',
  is_active        BOOLEAN     NOT NULL DEFAULT true,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

CREATE INDEX IF NOT EXISTS idx_profiles_firebase_uid  ON public.profiles (firebase_uid);
CREATE INDEX IF NOT EXISTS idx_profiles_professions   ON public.profiles USING GIN (professions);

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS search_vector tsvector
  GENERATED ALWAYS AS (
    to_tsvector('simple',
      coalesce(full_name,       '') || ' ' ||
      coalesce(restaurant_name, '') || ' ' ||
      coalesce(city,            '') || ' ' ||
      coalesce(country,         '') || ' ' ||
      coalesce(array_to_string(professions, ' '), '')
    )
  ) STORED;

CREATE INDEX IF NOT EXISTS idx_profiles_search_vector ON public.profiles USING GIN (search_vector);

COMMENT ON COLUMN public.profiles.restaurant_name IS
  'Generic workplace or venue — e.g. restaurant, music club, YouTube channel. Empty = independent.';

-- ── 2. payment_accounts ───────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.payment_accounts (
  id                 UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id          UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  type               TEXT        NOT NULL,
  provider           TEXT        NOT NULL,
  account_identifier TEXT        NOT NULL,
  is_active          BOOLEAN     NOT NULL DEFAULT true,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

CREATE INDEX IF NOT EXISTS idx_payment_accounts_waiter_id ON public.payment_accounts (waiter_id);

-- ── 3. tips ───────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.tips (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id    UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount       NUMERIC     NOT NULL,
  currency     TEXT        NOT NULL DEFAULT 'BIF',
  status       TEXT        NOT NULL DEFAULT 'completed'
               CHECK (status IN ('pending', 'completed', 'failed')),
  is_anonymous BOOLEAN     NOT NULL DEFAULT false,
  customer_name TEXT,
  message      TEXT,
  rating       INTEGER,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

CREATE INDEX IF NOT EXISTS idx_tips_waiter_id  ON public.tips (waiter_id);
CREATE INDEX IF NOT EXISTS idx_tips_status     ON public.tips (status);
CREATE INDEX IF NOT EXISTS idx_tips_created_at ON public.tips (created_at DESC);

-- ── 4. wallets ────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.wallets (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id  UUID        UNIQUE NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  balance    NUMERIC     NOT NULL DEFAULT 0,
  currency   TEXT        NOT NULL DEFAULT 'BIF',
  created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

CREATE INDEX IF NOT EXISTS idx_wallets_waiter_id ON public.wallets (waiter_id);

-- ── 5. payments ───────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.payments (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  tip_id          UUID        NOT NULL REFERENCES public.tips(id) ON DELETE CASCADE,
  client_token    TEXT        NOT NULL UNIQUE,
  tip_amount      BIGINT      NOT NULL,
  gateway_fee     BIGINT      NOT NULL DEFAULT 0,
  platform_fee    BIGINT      NOT NULL DEFAULT 0,
  customer_pays   BIGINT      NOT NULL,
  currency        TEXT        NOT NULL DEFAULT 'BIF',
  status          TEXT        NOT NULL DEFAULT 'pending'
                  CHECK (status IN ('pending', 'completed', 'failed', 'cancelled')),
  provider        TEXT        NOT NULL DEFAULT 'afripay',
  payment_method  TEXT,
  transaction_ref TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  confirmed_at    TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_payments_tip_id       ON public.payments (tip_id);
CREATE INDEX IF NOT EXISTS idx_payments_client_token ON public.payments (client_token);
CREATE INDEX IF NOT EXISTS idx_payments_status       ON public.payments (status);

-- ── 6. withdrawals ────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.withdrawals (
  id                 UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id          UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount             BIGINT      NOT NULL,
  currency           TEXT        NOT NULL DEFAULT 'BIF',
  status             TEXT        NOT NULL DEFAULT 'requested'
                     CHECK (status IN ('requested', 'processing', 'completed', 'failed', 'cancelled')),
  payment_account_id TEXT        NOT NULL,
  provider_reference TEXT,
  failure_reason     TEXT,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

CREATE INDEX IF NOT EXISTS idx_withdrawals_waiter_id ON public.withdrawals (waiter_id);
CREATE INDEX IF NOT EXISTS idx_withdrawals_status    ON public.withdrawals (status);

-- ── 7. notifications ──────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.notifications (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID        REFERENCES public.profiles(id) ON DELETE CASCADE,
  title      TEXT,
  body       TEXT,
  read       BOOLEAN     DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON public.notifications (user_id);

-- ── 8. qr_codes ───────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.qr_codes (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id  UUID        REFERENCES public.profiles(id) ON DELETE CASCADE,
  qr_data    TEXT        NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_qr_codes_waiter_id ON public.qr_codes (waiter_id);

-- ── 9. campaigns ──────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.campaigns (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id      UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title          TEXT        NOT NULL DEFAULT '',
  category       TEXT        NOT NULL DEFAULT 'other',
  description    TEXT        NOT NULL DEFAULT '',
  emoji          TEXT        NOT NULL DEFAULT '🎉',
  target_amount  BIGINT,
  current_amount BIGINT      NOT NULL DEFAULT 0,
  tips_count     INTEGER     NOT NULL DEFAULT 0,
  currency       TEXT        NOT NULL DEFAULT 'BIF',
  is_active      BOOLEAN     NOT NULL DEFAULT true,
  start_date     TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  end_date       TIMESTAMPTZ,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

CREATE INDEX IF NOT EXISTS idx_campaigns_waiter_id ON public.campaigns (waiter_id);
CREATE INDEX IF NOT EXISTS idx_campaigns_is_active ON public.campaigns (is_active);

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Auto-update updated_at on any table
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = timezone('utc', now());
  RETURN NEW;
END;
$$;

-- Extract firebase_uid from request header (null if missing/empty)
CREATE OR REPLACE FUNCTION auth.firebase_uid()
RETURNS TEXT LANGUAGE sql STABLE AS $$
  SELECT NULLIF(TRIM(COALESCE(
    current_setting('request.headers', true)::json->>'x-firebase-uid', ''
  )), '');
$$;

-- Get profiles.id for the current firebase user
CREATE OR REPLACE FUNCTION auth.my_profile_id()
RETURNS UUID LANGUAGE sql STABLE SECURITY DEFINER AS $$
  SELECT id FROM public.profiles
  WHERE firebase_uid = auth.firebase_uid()
  LIMIT 1;
$$;

-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- updated_at triggers
DROP TRIGGER IF EXISTS trg_payments_updated_at    ON public.payments;
CREATE TRIGGER trg_payments_updated_at
  BEFORE UPDATE ON public.payments
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

DROP TRIGGER IF EXISTS trg_withdrawals_updated_at ON public.withdrawals;
CREATE TRIGGER trg_withdrawals_updated_at
  BEFORE UPDATE ON public.withdrawals
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

DROP TRIGGER IF EXISTS trg_campaigns_updated_at   ON public.campaigns;
CREATE TRIGGER trg_campaigns_updated_at
  BEFORE UPDATE ON public.campaigns
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- When payment → completed: mark tip completed + credit wallet
CREATE OR REPLACE FUNCTION public.on_payment_completed()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_waiter_id UUID;
BEGIN
  IF NEW.status <> 'completed' OR OLD.status = 'completed' THEN
    RETURN NEW;
  END IF;

  NEW.confirmed_at = timezone('utc', now());

  UPDATE public.tips
  SET status = 'completed', updated_at = timezone('utc', now())
  WHERE id = NEW.tip_id
  RETURNING waiter_id INTO v_waiter_id;

  INSERT INTO public.wallets (waiter_id, balance, currency)
  VALUES (v_waiter_id, NEW.tip_amount, NEW.currency)
  ON CONFLICT (waiter_id) DO UPDATE
    SET balance    = public.wallets.balance + EXCLUDED.balance,
        updated_at = timezone('utc', now());

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_on_payment_completed ON public.payments;
CREATE TRIGGER trg_on_payment_completed
  BEFORE UPDATE ON public.payments
  FOR EACH ROW EXECUTE FUNCTION public.on_payment_completed();

-- When tip rating added/updated: recalculate waiter average_rating
CREATE OR REPLACE FUNCTION public.update_waiter_rating()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE public.profiles
  SET
    average_rating = (SELECT COALESCE(AVG(rating), 0) FROM public.tips
                      WHERE waiter_id = NEW.waiter_id AND rating IS NOT NULL),
    total_ratings  = (SELECT COUNT(*) FROM public.tips
                      WHERE waiter_id = NEW.waiter_id AND rating IS NOT NULL),
    updated_at     = timezone('utc', now())
  WHERE id = NEW.waiter_id;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_update_rating ON public.tips;
CREATE TRIGGER trg_update_rating
  AFTER INSERT OR UPDATE OF rating ON public.tips
  FOR EACH ROW
  WHEN (NEW.rating IS NOT NULL)
  EXECUTE FUNCTION public.update_waiter_rating();

-- When tip → completed: update active campaign stats
CREATE OR REPLACE FUNCTION public.update_campaign_on_tip()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NEW.status <> 'completed' OR OLD.status = 'completed' THEN
    RETURN NEW;
  END IF;

  UPDATE public.campaigns
  SET
    current_amount = current_amount + NEW.amount,
    tips_count     = tips_count + 1,
    updated_at     = timezone('utc', now())
  WHERE waiter_id = NEW.waiter_id
    AND is_active  = true
    AND id = (
      SELECT id FROM public.campaigns
      WHERE waiter_id = NEW.waiter_id AND is_active = true
      ORDER BY created_at DESC LIMIT 1
    );

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_update_campaign_on_tip ON public.tips;
CREATE TRIGGER trg_update_campaign_on_tip
  AFTER UPDATE OF status ON public.tips
  FOR EACH ROW EXECUTE FUNCTION public.update_campaign_on_tip();

-- Auto-generate qr_token on profile insert
CREATE OR REPLACE FUNCTION public.set_qr_token()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.qr_token = '' OR NEW.qr_token IS NULL THEN
    NEW.qr_token = gen_random_uuid()::text;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_set_qr_token ON public.profiles;
CREATE TRIGGER trg_set_qr_token
  BEFORE INSERT ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.set_qr_token();

-- Auto-create wallet on profile insert
CREATE OR REPLACE FUNCTION public.create_wallet_for_profile()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO public.wallets (waiter_id, balance, currency)
  VALUES (NEW.id, 0, 'BIF')
  ON CONFLICT (waiter_id) DO NOTHING;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_create_wallet ON public.profiles;
CREATE TRIGGER trg_create_wallet
  AFTER INSERT ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.create_wallet_for_profile();

-- ============================================================================
-- RPC FUNCTIONS
-- ============================================================================

-- Atomic withdrawal: balance check + deduct + insert in one transaction
CREATE OR REPLACE FUNCTION public.request_withdrawal(
  p_firebase_uid       TEXT,
  p_amount             BIGINT,
  p_currency           TEXT,
  p_payment_account_id TEXT
)
RETURNS SETOF public.withdrawals
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_waiter_id UUID;
  v_balance   BIGINT;
  v_row       public.withdrawals;
BEGIN
  SELECT id INTO v_waiter_id FROM public.profiles
  WHERE firebase_uid = p_firebase_uid LIMIT 1;

  IF v_waiter_id IS NULL THEN
    RAISE EXCEPTION 'Profile not found' USING ERRCODE = 'P0001';
  END IF;

  SELECT balance INTO v_balance FROM public.wallets
  WHERE waiter_id = v_waiter_id FOR UPDATE;

  IF v_balance IS NULL THEN
    RAISE EXCEPTION 'Wallet not found' USING ERRCODE = 'P0002';
  END IF;

  IF v_balance < p_amount THEN
    RAISE EXCEPTION 'Insufficient balance: have %, need %', v_balance, p_amount
      USING ERRCODE = 'P0003';
  END IF;

  UPDATE public.wallets
  SET balance = balance - p_amount, updated_at = timezone('utc', now())
  WHERE waiter_id = v_waiter_id;

  INSERT INTO public.withdrawals (waiter_id, amount, currency, status, payment_account_id)
  VALUES (v_waiter_id, p_amount, p_currency, 'requested', p_payment_account_id)
  RETURNING * INTO v_row;

  RETURN NEXT v_row;
END;
$$;

GRANT EXECUTE ON FUNCTION public.request_withdrawal(TEXT, BIGINT, TEXT, TEXT)
  TO anon, authenticated;

-- Restore balance when a withdrawal fails (called by edge function only)
CREATE OR REPLACE FUNCTION public.restore_withdrawal_balance(
  p_waiter_id UUID,
  p_amount    BIGINT
)
RETURNS void LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE public.wallets
  SET balance = balance + p_amount, updated_at = timezone('utc', now())
  WHERE waiter_id = p_waiter_id;

  IF NOT FOUND THEN
    RAISE WARNING 'restore_withdrawal_balance: no wallet for waiter %', p_waiter_id;
  END IF;
END;
$$;

REVOKE ALL ON FUNCTION public.restore_withdrawal_balance(UUID, BIGINT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.restore_withdrawal_balance(UUID, BIGINT) TO service_role;

-- ============================================================================
-- VIEWS
-- ============================================================================

-- Public profile view — safe for customers (no firebase_uid, no payment data)
CREATE OR REPLACE VIEW public.public_profiles AS
SELECT
  id, full_name, avatar_url, restaurant_name,
  city, country, personal_message,
  average_rating, total_ratings,
  professions, qr_token, is_active
FROM public.profiles
WHERE is_active = true;

GRANT SELECT ON public.public_profiles TO anon, authenticated;

-- ============================================================================
-- ROW-LEVEL SECURITY
-- ============================================================================

ALTER TABLE public.profiles         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payment_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tips             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wallets          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.withdrawals      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.campaigns        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.qr_codes         ENABLE ROW LEVEL SECURITY;

-- ── profiles ──────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Allow select profiles" ON public.profiles;
CREATE POLICY "Allow select profiles" ON public.profiles FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "Allow insert profiles" ON public.profiles;
CREATE POLICY "Allow insert profiles" ON public.profiles FOR INSERT
  TO anon, authenticated
  WITH CHECK (firebase_uid = auth.firebase_uid() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Allow update profiles" ON public.profiles;
CREATE POLICY "Allow update profiles" ON public.profiles FOR UPDATE
  TO anon, authenticated
  USING  (firebase_uid = auth.firebase_uid() AND auth.firebase_uid() IS NOT NULL)
  WITH CHECK (firebase_uid = auth.firebase_uid() AND auth.firebase_uid() IS NOT NULL);

-- ── payment_accounts ──────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Select own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Select own payment_accounts" ON public.payment_accounts FOR SELECT
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Insert own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Insert own payment_accounts" ON public.payment_accounts FOR INSERT
  TO anon, authenticated
  WITH CHECK (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Update own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Update own payment_accounts" ON public.payment_accounts FOR UPDATE
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Delete own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Delete own payment_accounts" ON public.payment_accounts FOR DELETE
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

-- ── tips ──────────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Anyone can insert tips" ON public.tips;
CREATE POLICY "Anyone can insert tips" ON public.tips FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "Waiter can select own tips" ON public.tips;
CREATE POLICY "Waiter can select own tips" ON public.tips FOR SELECT
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Waiter can update own tips" ON public.tips;
CREATE POLICY "Waiter can update own tips" ON public.tips FOR UPDATE
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

-- ── wallets ───────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Waiter can select own wallet" ON public.wallets;
CREATE POLICY "Waiter can select own wallet" ON public.wallets FOR SELECT
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Waiter can insert own wallet" ON public.wallets;
CREATE POLICY "Waiter can insert own wallet" ON public.wallets FOR INSERT
  TO anon, authenticated
  WITH CHECK (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Waiter can update own wallet" ON public.wallets;
CREATE POLICY "Waiter can update own wallet" ON public.wallets FOR UPDATE
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

-- ── payments ──────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Anon can insert payments" ON public.payments;
CREATE POLICY "Anon can insert payments" ON public.payments FOR INSERT
  TO anon, authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "Anon can select payment by client_token" ON public.payments;
CREATE POLICY "Anon can select payment by client_token" ON public.payments FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "Service role can update payments" ON public.payments;
CREATE POLICY "Service role can update payments" ON public.payments FOR UPDATE
  TO service_role USING (true) WITH CHECK (true);

-- ── withdrawals ───────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Waiters can select own withdrawals" ON public.withdrawals;
CREATE POLICY "Waiters can select own withdrawals" ON public.withdrawals FOR SELECT
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Waiters can insert own withdrawals" ON public.withdrawals;
CREATE POLICY "Waiters can insert own withdrawals" ON public.withdrawals FOR INSERT
  TO anon, authenticated
  WITH CHECK (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Waiters can update own withdrawals" ON public.withdrawals;
DROP POLICY IF EXISTS "Service role can update withdrawals" ON public.withdrawals;
CREATE POLICY "Service role can update withdrawals" ON public.withdrawals FOR UPDATE
  TO service_role USING (true) WITH CHECK (true);

-- ── campaigns ─────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Anyone can read active campaigns" ON public.campaigns;
CREATE POLICY "Anyone can read active campaigns" ON public.campaigns FOR SELECT
  TO anon, authenticated USING (true);

DROP POLICY IF EXISTS "Waiter can insert own campaigns" ON public.campaigns;
CREATE POLICY "Waiter can insert own campaigns" ON public.campaigns FOR INSERT
  TO anon, authenticated
  WITH CHECK (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Waiter can update own campaigns" ON public.campaigns;
CREATE POLICY "Waiter can update own campaigns" ON public.campaigns FOR UPDATE
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

DROP POLICY IF EXISTS "Waiter can delete own campaigns" ON public.campaigns;
CREATE POLICY "Waiter can delete own campaigns" ON public.campaigns FOR DELETE
  TO anon, authenticated
  USING (waiter_id = auth.my_profile_id() AND auth.firebase_uid() IS NOT NULL);

-- ============================================================================
-- STORAGE BUCKETS & POLICIES
-- ============================================================================

INSERT INTO storage.buckets (id, name, public)
VALUES
  ('avatars',      'avatars',      true),
  ('qr-codes',     'qr-codes',     true),
  ('user-uploads', 'user-uploads', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- avatars: public read, owner-only write
DROP POLICY IF EXISTS "Allow public avatar select" ON storage.objects;
CREATE POLICY "Allow public avatar select" ON storage.objects FOR SELECT
  TO anon, authenticated USING (bucket_id = 'avatars');

DROP POLICY IF EXISTS "Owner can insert avatar" ON storage.objects;
CREATE POLICY "Owner can insert avatar" ON storage.objects FOR INSERT
  TO anon, authenticated
  WITH CHECK (bucket_id = 'avatars' AND
    (storage.foldername(name))[1] = auth.firebase_uid());

DROP POLICY IF EXISTS "Owner can update avatar" ON storage.objects;
CREATE POLICY "Owner can update avatar" ON storage.objects FOR UPDATE
  TO anon, authenticated
  USING (bucket_id = 'avatars' AND
    (storage.foldername(name))[1] = auth.firebase_uid());

DROP POLICY IF EXISTS "Owner can delete avatar" ON storage.objects;
CREATE POLICY "Owner can delete avatar" ON storage.objects FOR DELETE
  TO anon, authenticated
  USING (bucket_id = 'avatars' AND
    (storage.foldername(name))[1] = auth.firebase_uid());

-- qr-codes: public read, owner-only write
DROP POLICY IF EXISTS "Allow public qr select" ON storage.objects;
CREATE POLICY "Allow public qr select" ON storage.objects FOR SELECT
  TO anon, authenticated USING (bucket_id = 'qr-codes');

DROP POLICY IF EXISTS "Owner can insert qr" ON storage.objects;
CREATE POLICY "Owner can insert qr" ON storage.objects FOR INSERT
  TO anon, authenticated
  WITH CHECK (bucket_id = 'qr-codes' AND
    (storage.foldername(name))[1] = auth.firebase_uid());

DROP POLICY IF EXISTS "Owner can update qr" ON storage.objects;
CREATE POLICY "Owner can update qr" ON storage.objects FOR UPDATE
  TO anon, authenticated
  USING (bucket_id = 'qr-codes' AND
    (storage.foldername(name))[1] = auth.firebase_uid());

-- user-uploads: public read + write (open)
DROP POLICY IF EXISTS "Allow public user-uploads select" ON storage.objects;
CREATE POLICY "Allow public user-uploads select" ON storage.objects FOR SELECT
  TO anon, authenticated USING (bucket_id = 'user-uploads');

DROP POLICY IF EXISTS "Allow public user-uploads insert" ON storage.objects;
CREATE POLICY "Allow public user-uploads insert" ON storage.objects FOR INSERT
  TO anon, authenticated WITH CHECK (bucket_id = 'user-uploads');

DROP POLICY IF EXISTS "Allow public user-uploads update" ON storage.objects;
CREATE POLICY "Allow public user-uploads update" ON storage.objects FOR UPDATE
  TO anon, authenticated USING (bucket_id = 'user-uploads');

-- ── notifications ─────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Manage own notifications" ON public.notifications;
CREATE POLICY "Manage own notifications" ON public.notifications FOR ALL
  TO public
  USING (true);

-- ── qr_codes ──────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "Manage own qr" ON public.qr_codes;
CREATE POLICY "Manage own qr" ON public.qr_codes FOR ALL
  TO public
  USING (true);

-- ============================================================================
-- MISSING COLUMNS (live DB has these — add if not present)
-- ============================================================================

-- profiles: bio column
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS bio TEXT;

-- wallets: pending_balance + last_updated_at
ALTER TABLE public.wallets ADD COLUMN IF NOT EXISTS pending_balance NUMERIC DEFAULT 0;
ALTER TABLE public.wallets ADD COLUMN IF NOT EXISTS last_updated_at TIMESTAMPTZ;

-- tips: transaction_reference + payment_provider
ALTER TABLE public.tips ADD COLUMN IF NOT EXISTS transaction_reference TEXT;
ALTER TABLE public.tips ADD COLUMN IF NOT EXISTS payment_provider TEXT;

-- payment_accounts: timestamps
ALTER TABLE public.payment_accounts ADD COLUMN IF NOT EXISTS created_at TIMESTAMPTZ DEFAULT timezone('utc', now());
ALTER TABLE public.payment_accounts ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ DEFAULT timezone('utc', now());

-- ============================================================================
-- END FULL_SCHEMA.sql
-- ============================================================================
