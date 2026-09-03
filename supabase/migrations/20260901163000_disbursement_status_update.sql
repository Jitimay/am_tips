-- ============================================================================
-- amTips — Add 'processing' and 'cancelled' to withdrawals status check
-- ============================================================================

ALTER TABLE public.withdrawals
  DROP CONSTRAINT IF EXISTS withdrawals_status_check;

ALTER TABLE public.withdrawals
  ADD CONSTRAINT withdrawals_status_check
  CHECK (status IN ('requested', 'processing', 'completed', 'failed', 'cancelled'));

-- Set Supabase Edge Function secrets (run in Supabase dashboard → Edge Functions → Secrets):
-- AFRIPAY_APP_ID     = 81cff9c266efd6f01737014a2dd4ba3a
-- AFRIPAY_APP_SECRET = JDJ5JDEwJDI0dlNu
-- AFRIPAY_ACCESS_TOKEN = <your AfriPay access token from AfriPay dashboard>
