-- ============================================================================
-- amTips — Withdrawals Table & Policies
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.withdrawals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount BIGINT NOT NULL,
  currency TEXT NOT NULL DEFAULT 'BIF',
  status TEXT NOT NULL DEFAULT 'requested' CHECK (status IN ('requested', 'completed', 'failed', 'cancelled')),
  payment_account_id TEXT NOT NULL,
  provider_reference TEXT,
  failure_reason TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

CREATE INDEX IF NOT EXISTS idx_withdrawals_waiter_id ON public.withdrawals (waiter_id);
CREATE INDEX IF NOT EXISTS idx_withdrawals_status ON public.withdrawals (status);

-- RLS Policies
ALTER TABLE public.withdrawals ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Waiters can select own withdrawals" ON public.withdrawals;
CREATE POLICY "Waiters can select own withdrawals"
ON public.withdrawals FOR SELECT
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

DROP POLICY IF EXISTS "Waiters can insert own withdrawals" ON public.withdrawals;
CREATE POLICY "Waiters can insert own withdrawals"
ON public.withdrawals FOR INSERT
TO anon, authenticated
WITH CHECK (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);

DROP POLICY IF EXISTS "Waiters can update own withdrawals" ON public.withdrawals;
CREATE POLICY "Waiters can update own withdrawals"
ON public.withdrawals FOR UPDATE
TO anon, authenticated
USING (
  waiter_id = (
    SELECT id FROM public.profiles
    WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
    LIMIT 1
  )
);
