-- ============================================================================
-- amTips — Restore Withdrawal Balance Function
-- Run in Supabase Dashboard → SQL Editor BEFORE redeploying the Edge Function.
-- ============================================================================
--
-- Called by the afripay-disbursement Edge Function when a disbursement fails.
-- Adds the deducted amount back to the waiter's wallet so the user does not
-- permanently lose money when a withdrawal attempt fails.

CREATE OR REPLACE FUNCTION public.restore_withdrawal_balance(
  p_waiter_id UUID,
  p_amount    BIGINT
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  UPDATE public.wallets
  SET balance    = balance + p_amount,
      updated_at = timezone('utc', now())
  WHERE waiter_id = p_waiter_id;

  IF NOT FOUND THEN
    RAISE WARNING 'restore_withdrawal_balance: no wallet row found for waiter %', p_waiter_id;
  END IF;
END;
$$;

-- Only the Edge Function (service_role) may call this.
-- Regular users cannot restore their own balance.
REVOKE ALL ON FUNCTION public.restore_withdrawal_balance(UUID, BIGINT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.restore_withdrawal_balance(UUID, BIGINT) TO service_role;
