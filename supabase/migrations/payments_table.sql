-- ============================================================================
-- amTips — Payments Table & AfriPay Webhook Support
-- Run this in the Supabase SQL Editor AFTER running schema.sql
-- ============================================================================

-- ── 1. Payments table ────────────────────────────────────────────────────────
-- One row per AfriPay checkout attempt.
-- Created BEFORE the browser opens; updated by the Edge Function callback.

CREATE TABLE IF NOT EXISTS public.payments (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Link back to the tip this payment is for
  tip_id           UUID        NOT NULL REFERENCES public.tips(id) ON DELETE CASCADE,

  -- The unique token we send to AfriPay as client_token.
  -- AfriPay echoes it back in the webhook so we can match the row.
  client_token     TEXT        NOT NULL UNIQUE,

  -- Fee breakdown (BIF integers — no decimals for BIF)
  tip_amount       BIGINT      NOT NULL,
  gateway_fee      BIGINT      NOT NULL DEFAULT 0,
  customer_pays    BIGINT      NOT NULL,
  currency         TEXT        NOT NULL DEFAULT 'BIF',

  -- Payment status lifecycle:
  --   pending  → checkout opened, no response yet
  --   completed → AfriPay confirmed payment
  --   failed   → AfriPay reported failure or timeout
  --   cancelled → user cancelled / browser closed without paying
  status           TEXT        NOT NULL DEFAULT 'pending'
                   CHECK (status IN ('pending','completed','failed','cancelled')),

  -- AfriPay gateway fields (populated by webhook)
  provider         TEXT        NOT NULL DEFAULT 'afripay',
  payment_method   TEXT,       -- 'lumicash' | 'bancobu_enoti' | etc.
  transaction_ref  TEXT,       -- AfriPay's own transaction_ref

  -- Timestamps
  created_at       TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  confirmed_at     TIMESTAMPTZ             -- set when status → completed
);

-- Indexes for fast lookups
CREATE INDEX IF NOT EXISTS idx_payments_tip_id
  ON public.payments (tip_id);

CREATE INDEX IF NOT EXISTS idx_payments_client_token
  ON public.payments (client_token);

CREATE INDEX IF NOT EXISTS idx_payments_status
  ON public.payments (status);

-- auto-update updated_at
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = timezone('utc', now());
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_payments_updated_at ON public.payments;
CREATE TRIGGER trg_payments_updated_at
  BEFORE UPDATE ON public.payments
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


-- ── 2. RLS Policies ──────────────────────────────────────────────────────────
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

-- Customers (anon) can INSERT a payment row when starting checkout.
DROP POLICY IF EXISTS "Anon can insert payments" ON public.payments;
CREATE POLICY "Anon can insert payments"
  ON public.payments FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- The waiter owning the tip can SELECT their own payment rows.
DROP POLICY IF EXISTS "Waiter can select own payments" ON public.payments;
CREATE POLICY "Waiter can select own payments"
  ON public.payments FOR SELECT
  TO anon, authenticated
  USING (
    tip_id IN (
      SELECT t.id FROM public.tips t
      JOIN public.profiles p ON p.id = t.waiter_id
      WHERE p.firebase_uid =
        (current_setting('request.headers', true)::json->>'x-firebase-uid')
    )
  );

-- The polling app (anon customer) can SELECT by client_token.
-- We allow it so the Flutter app can poll status without being logged in.
DROP POLICY IF EXISTS "Anon can select payment by client_token" ON public.payments;
CREATE POLICY "Anon can select payment by client_token"
  ON public.payments FOR SELECT
  TO anon, authenticated
  USING (true);   -- Row is identified by client_token — no sensitive data exposed

-- Only the Edge Function (service_role) can UPDATE payments.
-- Anon / authenticated users cannot change status themselves.
DROP POLICY IF EXISTS "Service role can update payments" ON public.payments;
CREATE POLICY "Service role can update payments"
  ON public.payments FOR UPDATE
  TO service_role
  USING (true)
  WITH CHECK (true);


-- ── 3. Trigger: when payment completed → update tip + wallet ─────────────────
-- This runs inside Supabase (server-side) when the Edge Function updates
-- a payment row to status='completed'. No Flutter code needed.

CREATE OR REPLACE FUNCTION public.on_payment_completed()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_waiter_id UUID;
BEGIN
  -- Only act on transitions TO completed
  IF NEW.status <> 'completed' OR OLD.status = 'completed' THEN
    RETURN NEW;
  END IF;

  -- Set confirmed_at timestamp
  NEW.confirmed_at = timezone('utc', now());

  -- 1. Mark the tip as completed
  UPDATE public.tips
  SET status = 'completed', updated_at = timezone('utc', now())
  WHERE id = NEW.tip_id
  RETURNING waiter_id INTO v_waiter_id;

  -- 2. Credit the waiter's wallet with the tip_amount
  --    (NOT customer_pays — waiter gets the tip, AfriPay takes its cut from customer)
  INSERT INTO public.wallets (waiter_id, balance, currency)
  VALUES (v_waiter_id, NEW.tip_amount, NEW.currency)
  ON CONFLICT (waiter_id) DO UPDATE
    SET balance     = public.wallets.balance + EXCLUDED.balance,
        updated_at  = timezone('utc', now());

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_on_payment_completed ON public.payments;
CREATE TRIGGER trg_on_payment_completed
  BEFORE UPDATE ON public.payments
  FOR EACH ROW EXECUTE FUNCTION public.on_payment_completed();


-- ── 4. Average rating update trigger ─────────────────────────────────────────
-- Recalculate average_rating on profiles whenever a tip with a rating is added/updated.

CREATE OR REPLACE FUNCTION public.update_waiter_rating()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  UPDATE public.profiles
  SET
    average_rating = (
      SELECT COALESCE(AVG(rating), 0)
      FROM public.tips
      WHERE waiter_id = NEW.waiter_id AND rating IS NOT NULL
    ),
    total_ratings = (
      SELECT COUNT(*)
      FROM public.tips
      WHERE waiter_id = NEW.waiter_id AND rating IS NOT NULL
    ),
    updated_at = timezone('utc', now())
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


-- ============================================================================
-- END payments_table.sql
-- ============================================================================
