-- ============================================================================
-- amTips — Hardened Row-Level Security
--
-- Replaces the x-firebase-uid header pattern with a more robust approach:
-- We keep the header mechanism for backward compat (it works for dev) but add
-- a helper function that validates the header is present and non-empty,
-- making it marginally harder to exploit.
--
-- For full server-side verification, use the verify-token Edge Function:
--   supabase functions deploy verify-token
-- Then update the Flutter client to call it and receive a verified UID.
--
-- Run in Supabase Dashboard → SQL Editor
-- ============================================================================

-- ── Helper: extract and validate the firebase_uid from request headers ──────
CREATE OR REPLACE FUNCTION auth.firebase_uid()
RETURNS TEXT
LANGUAGE sql STABLE
AS $$
  SELECT NULLIF(
    TRIM(
      COALESCE(
        current_setting('request.headers', true)::json->>'x-firebase-uid',
        ''
      )
    ),
    ''
  );
$$;

-- ── Helper: get the profiles.id for the current user ─────────────────────────
CREATE OR REPLACE FUNCTION auth.my_profile_id()
RETURNS UUID
LANGUAGE sql STABLE SECURITY DEFINER
AS $$
  SELECT id FROM public.profiles
  WHERE firebase_uid = auth.firebase_uid()
  LIMIT 1;
$$;

-- ============================================================================
-- Recreate all RLS policies using the helper functions
-- ============================================================================

-- ── PROFILES ─────────────────────────────────────────────────────────────────
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow select profiles" ON public.profiles;
CREATE POLICY "Allow select profiles"
  ON public.profiles FOR SELECT
  TO anon, authenticated
  USING (true); -- public — customers need to see waiter profiles

DROP POLICY IF EXISTS "Allow insert profiles" ON public.profiles;
CREATE POLICY "Allow insert profiles"
  ON public.profiles FOR INSERT
  TO anon, authenticated
  WITH CHECK (
    firebase_uid = auth.firebase_uid()
    AND auth.firebase_uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Allow update profiles" ON public.profiles;
CREATE POLICY "Allow update profiles"
  ON public.profiles FOR UPDATE
  TO anon, authenticated
  USING (
    firebase_uid = auth.firebase_uid()
    AND auth.firebase_uid() IS NOT NULL
  )
  WITH CHECK (
    firebase_uid = auth.firebase_uid()
    AND auth.firebase_uid() IS NOT NULL
  );

-- ── PAYMENT ACCOUNTS ─────────────────────────────────────────────────────────
ALTER TABLE public.payment_accounts ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Select own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Select own payment_accounts"
  ON public.payment_accounts FOR SELECT
  TO anon, authenticated
  USING (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Insert own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Insert own payment_accounts"
  ON public.payment_accounts FOR INSERT
  TO anon, authenticated
  WITH CHECK (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Update own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Update own payment_accounts"
  ON public.payment_accounts FOR UPDATE
  TO anon, authenticated
  USING (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Delete own payment_accounts" ON public.payment_accounts;
CREATE POLICY "Delete own payment_accounts"
  ON public.payment_accounts FOR DELETE
  TO anon, authenticated
  USING (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

-- ── TIPS ─────────────────────────────────────────────────────────────────────
ALTER TABLE public.tips ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can insert tips" ON public.tips;
CREATE POLICY "Anyone can insert tips"
  ON public.tips FOR INSERT
  TO anon, authenticated
  WITH CHECK (true); -- customers tip without accounts

DROP POLICY IF EXISTS "Waiter can select own tips" ON public.tips;
CREATE POLICY "Waiter can select own tips"
  ON public.tips FOR SELECT
  TO anon, authenticated
  USING (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Waiter can update own tips" ON public.tips;
CREATE POLICY "Waiter can update own tips"
  ON public.tips FOR UPDATE
  TO anon, authenticated
  USING (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

-- ── WALLETS ───────────────────────────────────────────────────────────────────
ALTER TABLE public.wallets ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Waiter can select own wallet" ON public.wallets;
CREATE POLICY "Waiter can select own wallet"
  ON public.wallets FOR SELECT
  TO anon, authenticated
  USING (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Waiter can update own wallet" ON public.wallets;
CREATE POLICY "Waiter can update own wallet"
  ON public.wallets FOR UPDATE
  TO anon, authenticated
  USING (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Waiter can insert own wallet" ON public.wallets;
CREATE POLICY "Waiter can insert own wallet"
  ON public.wallets FOR INSERT
  TO anon, authenticated
  WITH CHECK (
    waiter_id = auth.my_profile_id()
    AND auth.firebase_uid() IS NOT NULL
  );

-- ── PAYMENTS ──────────────────────────────────────────────────────────────────
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anon can insert payments" ON public.payments;
CREATE POLICY "Anon can insert payments"
  ON public.payments FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

DROP POLICY IF EXISTS "Anon can select payment by client_token" ON public.payments;
CREATE POLICY "Anon can select payment by client_token"
  ON public.payments FOR SELECT
  TO anon, authenticated
  USING (true);

DROP POLICY IF EXISTS "Service role can update payments" ON public.payments;
CREATE POLICY "Service role can update payments"
  ON public.payments FOR UPDATE
  TO service_role
  USING (true)
  WITH CHECK (true);

-- ============================================================================
-- END hardened_rls.sql
-- ============================================================================
