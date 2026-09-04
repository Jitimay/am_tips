-- ============================================================================
-- amTips — Campaigns Table
-- Run in Supabase Dashboard → SQL Editor
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.campaigns (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id        UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,

  -- Content
  title            TEXT        NOT NULL DEFAULT '',
  category         TEXT        NOT NULL DEFAULT 'other',
  description      TEXT        NOT NULL DEFAULT '',
  emoji            TEXT        NOT NULL DEFAULT '🎉',

  -- Goal tracking (optional)
  target_amount    BIGINT,
  current_amount   BIGINT      NOT NULL DEFAULT 0,
  tips_count       INTEGER     NOT NULL DEFAULT 0,
  currency         TEXT        NOT NULL DEFAULT 'BIF',

  -- Status
  is_active        BOOLEAN     NOT NULL DEFAULT true,
  start_date       TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  end_date         TIMESTAMPTZ,

  -- Timestamps
  created_at       TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now())
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_campaigns_waiter_id
  ON public.campaigns (waiter_id);

CREATE INDEX IF NOT EXISTS idx_campaigns_is_active
  ON public.campaigns (is_active);

-- Auto-update updated_at
DROP TRIGGER IF EXISTS trg_campaigns_updated_at ON public.campaigns;
CREATE TRIGGER trg_campaigns_updated_at
  BEFORE UPDATE ON public.campaigns
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- ── RLS ───────────────────────────────────────────────────────────────────────
ALTER TABLE public.campaigns ENABLE ROW LEVEL SECURITY;

-- Anyone can read active campaigns (customers see them on the tip page)
DROP POLICY IF EXISTS "Anyone can read active campaigns" ON public.campaigns;
CREATE POLICY "Anyone can read active campaigns"
  ON public.campaigns FOR SELECT
  TO anon, authenticated
  USING (true);

-- Only the owning waiter can insert
DROP POLICY IF EXISTS "Waiter can insert own campaigns" ON public.campaigns;
CREATE POLICY "Waiter can insert own campaigns"
  ON public.campaigns FOR INSERT
  TO anon, authenticated
  WITH CHECK (
    waiter_id = (
      SELECT id FROM public.profiles
      WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
      LIMIT 1
    )
    AND (current_setting('request.headers', true)::json->>'x-firebase-uid') IS NOT NULL
  );

-- Only the owning waiter can update
DROP POLICY IF EXISTS "Waiter can update own campaigns" ON public.campaigns;
CREATE POLICY "Waiter can update own campaigns"
  ON public.campaigns FOR UPDATE
  TO anon, authenticated
  USING (
    waiter_id = (
      SELECT id FROM public.profiles
      WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
      LIMIT 1
    )
    AND (current_setting('request.headers', true)::json->>'x-firebase-uid') IS NOT NULL
  );

-- Only the owning waiter can delete
DROP POLICY IF EXISTS "Waiter can delete own campaigns" ON public.campaigns;
CREATE POLICY "Waiter can delete own campaigns"
  ON public.campaigns FOR DELETE
  TO anon, authenticated
  USING (
    waiter_id = (
      SELECT id FROM public.profiles
      WHERE firebase_uid = (current_setting('request.headers', true)::json->>'x-firebase-uid')
      LIMIT 1
    )
    AND (current_setting('request.headers', true)::json->>'x-firebase-uid') IS NOT NULL
  );

-- ── Trigger: update campaign stats when a tip is received ────────────────────
-- When a tip is completed, if the waiter has an active campaign,
-- increment current_amount and tips_count on the most recent active campaign.

CREATE OR REPLACE FUNCTION public.update_campaign_on_tip()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  -- Only act when tip transitions to completed
  IF NEW.status <> 'completed' OR OLD.status = 'completed' THEN
    RETURN NEW;
  END IF;

  -- Find the most recent active campaign for this waiter
  UPDATE public.campaigns
  SET
    current_amount = current_amount + NEW.amount,
    tips_count     = tips_count + 1,
    updated_at     = timezone('utc', now())
  WHERE
    waiter_id = NEW.waiter_id
    AND is_active = true
  AND id = (
    SELECT id FROM public.campaigns
    WHERE waiter_id = NEW.waiter_id AND is_active = true
    ORDER BY created_at DESC
    LIMIT 1
  );

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_update_campaign_on_tip ON public.tips;
CREATE TRIGGER trg_update_campaign_on_tip
  AFTER UPDATE OF status ON public.tips
  FOR EACH ROW
  EXECUTE FUNCTION public.update_campaign_on_tip();

-- ============================================================================
-- END campaigns_table.sql
-- ============================================================================
