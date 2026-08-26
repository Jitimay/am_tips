-- ============================================================================
-- amTips — Tighten Storage Bucket Policies
-- Prevents any anon user from overwriting other users' avatars/files.
-- Run in Supabase Dashboard → SQL Editor
-- ============================================================================

-- AVATARS: only the owning user can upload/update their own avatar.
-- File path convention: avatars/{firebase_uid}/{filename}
-- The firebase_uid in the path must match the request header.

DROP POLICY IF EXISTS "Allow public avatar insert" ON storage.objects;
DROP POLICY IF EXISTS "Allow public avatar update" ON storage.objects;
DROP POLICY IF EXISTS "Allow public avatar delete" ON storage.objects;

CREATE POLICY "Owner can insert avatar"
ON storage.objects FOR INSERT
TO anon, authenticated
WITH CHECK (
  bucket_id = 'avatars' AND
  (storage.foldername(name))[1] = (
    current_setting('request.headers', true)::json->>'x-firebase-uid'
  )
);

CREATE POLICY "Owner can update avatar"
ON storage.objects FOR UPDATE
TO anon, authenticated
USING (
  bucket_id = 'avatars' AND
  (storage.foldername(name))[1] = (
    current_setting('request.headers', true)::json->>'x-firebase-uid'
  )
);

CREATE POLICY "Owner can delete avatar"
ON storage.objects FOR DELETE
TO anon, authenticated
USING (
  bucket_id = 'avatars' AND
  (storage.foldername(name))[1] = (
    current_setting('request.headers', true)::json->>'x-firebase-uid'
  )
);

-- Public SELECT stays open (avatars are public)
-- (existing "Allow public avatar select" policy unchanged)

-- QR codes: same pattern — only owner can write
DROP POLICY IF EXISTS "Allow public qr insert" ON storage.objects;
DROP POLICY IF EXISTS "Allow public qr update" ON storage.objects;

CREATE POLICY "Owner can insert qr"
ON storage.objects FOR INSERT
TO anon, authenticated
WITH CHECK (
  bucket_id = 'qr-codes' AND
  (storage.foldername(name))[1] = (
    current_setting('request.headers', true)::json->>'x-firebase-uid'
  )
);

CREATE POLICY "Owner can update qr"
ON storage.objects FOR UPDATE
TO anon, authenticated
USING (
  bucket_id = 'qr-codes' AND
  (storage.foldername(name))[1] = (
    current_setting('request.headers', true)::json->>'x-firebase-uid'
  )
);
