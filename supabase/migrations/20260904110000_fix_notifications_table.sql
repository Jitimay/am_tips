-- ============================================================================
-- amTips — Fix notifications table to match the Flutter NotificationModel
-- Run in Supabase Dashboard → SQL Editor
-- ============================================================================

-- Add missing columns (safe — uses IF NOT EXISTS)
ALTER TABLE public.notifications
  ADD COLUMN IF NOT EXISTS type      TEXT        NOT NULL DEFAULT 'system',
  ADD COLUMN IF NOT EXISTS is_read   BOOLEAN     NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS metadata  JSONB;

-- Rename old `read` column data into `is_read` if `read` column still exists
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name   = 'notifications'
      AND column_name  = 'read'
  ) THEN
    UPDATE public.notifications SET is_read = read;
    ALTER TABLE public.notifications DROP COLUMN read;
  END IF;
END;
$$;

-- Make title and body NOT NULL with defaults (they were nullable before)
ALTER TABLE public.notifications
  ALTER COLUMN title SET DEFAULT '',
  ALTER COLUMN body  SET DEFAULT '';

UPDATE public.notifications SET title = '' WHERE title IS NULL;
UPDATE public.notifications SET body  = '' WHERE body  IS NULL;

ALTER TABLE public.notifications
  ALTER COLUMN title SET NOT NULL,
  ALTER COLUMN body  SET NOT NULL;

-- Index for fast unread-count queries
CREATE INDEX IF NOT EXISTS idx_notifications_user_id_is_read
  ON public.notifications (user_id, is_read);

-- ── RLS ───────────────────────────────────────────────────────────────────────
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Manage own notifications" ON public.notifications;
CREATE POLICY "Manage own notifications"
  ON public.notifications FOR ALL
  TO authenticated, anon
  USING (
    user_id = (
      SELECT id FROM public.profiles
      WHERE firebase_uid =
        (current_setting('request.headers', true)::json->>'x-firebase-uid')
      LIMIT 1
    )
  )
  WITH CHECK (
    user_id = (
      SELECT id FROM public.profiles
      WHERE firebase_uid =
        (current_setting('request.headers', true)::json->>'x-firebase-uid')
      LIMIT 1
    )
  );

-- Service role (Edge Functions) can insert notifications for any user
DROP POLICY IF EXISTS "Service role manages notifications" ON public.notifications;
CREATE POLICY "Service role manages notifications"
  ON public.notifications FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);
