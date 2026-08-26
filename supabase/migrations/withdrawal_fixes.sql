-- ============================================================================
-- amTips — Withdrawal Fixes
-- 1. Atomic withdrawal RPC (prevents race condition / double-spend)
-- 2. updated_at trigger on withdrawals
-- 3. Restrict withdrawal UPDATE to service_role only
-- ============================================================================

-- ── 1. Atomic withdrawal function ────────────────────────────────────────────
-- Replaces the Flutter client-side balance check + deduct + insert pattern.
-- Called via: supabase.rpc('request_withdrawal', { ... })
-- Returns the new withdrawal row as JSON.

CREATE OR REPLACE FUNCTION public.request_withdrawal(
  p_firebase_uid     TEXT,
  p_amount           BIGINT,
  p_currency         TEXT,
  p_payment_account_id TEXT
)
RETURNS SETOF public.withdrawals
LANGUAGE plpgsql SECURITY DEFINER
AS $$
DECLARE
  v_waiter_id UUID;
  v_balance   BIGINT;
  v_row       public.withdrawals;
BEGIN
  -- Resolve waiter id
  SELECT id INTO v_waiter_id
  FROM public.profiles
  WHERE firebase_uid = p_firebase_uid
  LIMIT 1;

  IF v_waiter_id IS NULL THEN
    RAISE EXCEPTION 'Profile not found for uid %', p_firebase_uid
      USING ERRCODE = 'P0001';
  END IF;

  -- Lock the wallet row to prevent concurrent withdrawals
  SELECT balance INTO v_balance
  FROM public.wallets
  WHERE waiter_id = v_waiter_id
  FOR UPDATE;

  IF v_balance IS NULL THEN
    RAISE EXCEPTION 'Wallet not found'
      USING ERRCODE = 'P0002';
  END IF;

  IF v_balance < p_amount THEN
    RAISE EXCEPTION 'Insufficient balance: have %, need %', v_balance, p_amount
      USING ERRCODE = 'P0003';
  END IF;

  -- Deduct balance atomically
  UPDATE public.wallets
  SET balance    = balance - p_amount,
      updated_at = timezone('utc', now())
  WHERE waiter_id = v_waiter_id;

  -- Insert withdrawal record
  INSERT INTO public.withdrawals
    (waiter_id, amount, currency, status, payment_account_id)
  VALUES
    (v_waiter_id, p_amount, p_currency, 'requested', p_payment_account_id)
  RETURNING * INTO v_row;

  RETURN NEXT v_row;
END;
$$;

-- Grant execute to anon/authenticated (RLS on the function itself via firebase_uid param)
GRANT EXECUTE ON FUNCTION public.request_withdrawal(TEXT, BIGINT, TEXT, TEXT)
  TO anon, authenticated;


-- ── 2. updated_at trigger on withdrawals ─────────────────────────────────────
-- reuse the set_updated_at() function already created in payments_table.sql

DROP TRIGGER IF EXISTS trg_withdrawals_updated_at ON public.withdrawals;
CREATE TRIGGER trg_withdrawals_updated_at
  BEFORE UPDATE ON public.withdrawals
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


-- ── 3. Restrict withdrawal UPDATE to service_role only ───────────────────────
-- Waiters should never be able to change their own withdrawal status.

DROP POLICY IF EXISTS "Waiters can update own withdrawals" ON public.withdrawals;

CREATE POLICY "Service role can update withdrawals"
  ON public.withdrawals FOR UPDATE
  TO service_role
  USING (true)
  WITH CHECK (true);

-- ============================================================================
-- END withdrawal_fixes.sql
-- ============================================================================
