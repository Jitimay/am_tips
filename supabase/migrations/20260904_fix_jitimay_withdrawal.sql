-- ============================================================================
-- amTips — Fix: restore_withdrawal_balance function + Jitimay manual restore
-- Run in Supabase Dashboard → SQL Editor
-- ============================================================================

-- 1. Ensure the restore function exists (idempotent)
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

REVOKE ALL ON FUNCTION public.restore_withdrawal_balance(UUID, BIGINT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.restore_withdrawal_balance(UUID, BIGINT) TO service_role;

-- ============================================================================
-- 2. Find Jitimay's stuck withdrawal(s) and restore balance
--    This finds all withdrawals in 'requested' or 'processing' or 'failed'
--    status that were NOT completed, and restores the wallet balance.
-- ============================================================================

DO $$
DECLARE
  v_waiter_id UUID;
  v_row       RECORD;
  v_total     BIGINT := 0;
BEGIN
  -- Get Jitimay's profile id (firebase_uid lookup by full_name as fallback)
  SELECT id INTO v_waiter_id
  FROM public.profiles
  WHERE lower(full_name) LIKE '%jitimay%'
  LIMIT 1;

  IF v_waiter_id IS NULL THEN
    RAISE NOTICE 'Profile not found for Jitimay — check the name spelling in profiles table';
    RETURN;
  END IF;

  RAISE NOTICE 'Found waiter_id: %', v_waiter_id;

  -- Find all non-completed withdrawals (stuck/failed without balance restore)
  FOR v_row IN
    SELECT id, amount, status, created_at
    FROM public.withdrawals
    WHERE waiter_id = v_waiter_id
      AND status IN ('requested', 'processing', 'failed')
    ORDER BY created_at DESC
  LOOP
    RAISE NOTICE 'Restoring withdrawal id=% amount=% status=%',
      v_row.id, v_row.amount, v_row.status;

    -- Restore the balance
    UPDATE public.wallets
    SET balance    = balance + v_row.amount,
        updated_at = timezone('utc', now())
    WHERE waiter_id = v_waiter_id;

    -- Mark the withdrawal as cancelled so it won't be retried
    UPDATE public.withdrawals
    SET status         = 'cancelled',
        failure_reason = 'Manually cancelled and balance restored — disbursement did not complete',
        updated_at     = timezone('utc', now())
    WHERE id = v_row.id;

    v_total := v_total + v_row.amount;
  END LOOP;

  RAISE NOTICE 'Done. Total restored to wallet: % BIF', v_total;
END;
$$;

-- 3. Verify the result
SELECT
  p.full_name,
  w.balance,
  w.currency,
  w.updated_at AS wallet_updated
FROM public.wallets w
JOIN public.profiles p ON p.id = w.waiter_id
WHERE lower(p.full_name) LIKE '%jitimay%';

-- Also show the withdrawal history
SELECT
  wd.id,
  wd.amount,
  wd.status,
  wd.failure_reason,
  wd.created_at
FROM public.withdrawals wd
JOIN public.profiles p ON p.id = wd.waiter_id
WHERE lower(p.full_name) LIKE '%jitimay%'
ORDER BY wd.created_at DESC;
