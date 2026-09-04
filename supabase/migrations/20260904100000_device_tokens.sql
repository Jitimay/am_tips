-- ============================================================================
-- amTips — Device Tokens Table
-- Stores FCM push tokens so the afripay-callback Edge Function can notify
-- waiters when they receive a tip.
-- Run in Supabase Dashboard → SQL Editor.
-- ============================================================================

-- ── Table ─────────────────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.device_tokens (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  waiter_id  UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  token      TEXT        NOT NULL,
  platform   TEXT        NOT NULL DEFAULT 'android' CHECK (platform IN ('android', 'ios', 'web')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc', now()),

  -- One row per (waiter, token) — prevents duplicates on re-install.
  CONSTRAINT uq_device_tokens_waiter_token UNIQUE (waiter_id, token)
);

CREATE INDEX IF NOT EXISTS idx_device_tokens_waiter_id ON public.device_tokens (waiter_id);

DROP TRIGGER IF EXISTS trg_device_tokens_updated_at ON public.device_tokens;
CREATE TRIGGER trg_device_tokens_updated_at
  BEFORE UPDATE ON public.device_tokens
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- ── RLS ───────────────────────────────────────────────────────────────────────
ALTER TABLE public.device_tokens ENABLE ROW LEVEL SECURITY;

-- Authenticated users can insert/update/delete their own tokens.
DROP POLICY IF EXISTS "Waiter manages own device tokens" ON public.device_tokens;
CREATE POLICY "Waiter manages own device tokens"
  ON public.device_tokens FOR ALL
  TO authenticated, anon
  USING (
    waiter_id = (
      SELECT id FROM public.profiles
      WHERE firebase_uid =
        (current_setting('request.headers', true)::json->>'x-firebase-uid')
      LIMIT 1
    )
  )
  WITH CHECK (
    waiter_id = (
      SELECT id FROM public.profiles
      WHERE firebase_uid =
        (current_setting('request.headers', true)::json->>'x-firebase-uid')
      LIMIT 1
    )
  );

-- The Edge Function (service_role) can read tokens to send notifications.
DROP POLICY IF EXISTS "Service role can select device tokens" ON public.device_tokens;
CREATE POLICY "Service role can select device tokens"
  ON public.device_tokens FOR SELECT
  TO service_role
  USING (true);

-- ── upsert_device_token RPC ────────────────────────────────────────────────────
-- Called from Flutter. Inserts the token or updates updated_at if it already
-- exists for this waiter. Returns the waiter_id so the caller can confirm.
CREATE OR REPLACE FUNCTION public.upsert_device_token(
  p_firebase_uid TEXT,
  p_token        TEXT,
  p_platform     TEXT DEFAULT 'android'
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_waiter_id UUID;
BEGIN
  -- Resolve waiter
  SELECT id INTO v_waiter_id
  FROM public.profiles
  WHERE firebase_uid = p_firebase_uid
  LIMIT 1;

  IF v_waiter_id IS NULL THEN
    RAISE EXCEPTION 'Profile not found for uid %', p_firebase_uid
      USING ERRCODE = 'P0001';
  END IF;

  INSERT INTO public.device_tokens (waiter_id, token, platform)
  VALUES (v_waiter_id, p_token, p_platform)
  ON CONFLICT (waiter_id, token)
    DO UPDATE SET
      updated_at = timezone('utc', now()),
      platform   = EXCLUDED.platform;

  RETURN v_waiter_id;
END;
$$;

GRANT EXECUTE ON FUNCTION public.upsert_device_token(TEXT, TEXT, TEXT)
  TO anon, authenticated;

-- ── delete_device_token RPC ────────────────────────────────────────────────────
-- Called on logout to remove stale tokens.
CREATE OR REPLACE FUNCTION public.delete_device_token(
  p_firebase_uid TEXT,
  p_token        TEXT
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_waiter_id UUID;
BEGIN
  SELECT id INTO v_waiter_id
  FROM public.profiles
  WHERE firebase_uid = p_firebase_uid
  LIMIT 1;

  IF v_waiter_id IS NULL THEN RETURN; END IF;

  DELETE FROM public.device_tokens
  WHERE waiter_id = v_waiter_id AND token = p_token;
END;
$$;

GRANT EXECUTE ON FUNCTION public.delete_device_token(TEXT, TEXT)
  TO anon, authenticated;
