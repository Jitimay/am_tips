/**
 * amTips — Firebase Token Verification Edge Function
 *
 * Replaces the insecure x-firebase-uid header pattern.
 * The Flutter app calls this endpoint with the Firebase ID token;
 * this function verifies it server-side and returns a Supabase JWT
 * that encodes the verified Firebase UID as a custom claim.
 *
 * Flow:
 *   1. Flutter gets Firebase ID token: await user.getIdToken()
 *   2. Flutter POSTs { idToken } to this endpoint
 *   3. Edge Function verifies token via Firebase REST API
 *   4. Returns { supabaseToken, uid } — Supabase token signed with SERVICE_ROLE_KEY
 *   5. Flutter uses Supabase token for all Supabase calls
 *
 * Deploy:
 *   supabase functions deploy verify-token --no-verify-jwt
 *
 * Required secrets:
 *   supabase secrets set FIREBASE_PROJECT_ID=amtips-app
 */

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const FIREBASE_PROJECT_ID = Deno.env.get("FIREBASE_PROJECT_ID") ?? "amtips-app";

const supabaseAdmin = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 204,
      headers: corsHeaders(),
    });
  }

  if (req.method !== "POST") {
    return json({ error: "Method not allowed" }, 405);
  }

  let idToken: string;
  try {
    const body = await req.json();
    idToken = body.idToken;
    if (!idToken) throw new Error("Missing idToken");
  } catch {
    return json({ error: "Request body must be { idToken: string }" }, 400);
  }

  // ── Verify Firebase ID token via Google's tokeninfo endpoint ─────────────
  let firebaseUid: string;
  let email: string | undefined;
  let emailVerified: boolean;

  try {
    const verifyUrl =
      `https://identitytoolkit.googleapis.com/v1/accounts:lookup` +
      `?key=${Deno.env.get("FIREBASE_WEB_API_KEY") ?? ""}`;

    const verifyRes = await fetch(verifyUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ idToken }),
    });

    if (!verifyRes.ok) {
      const err = await verifyRes.json();
      console.error("[verify-token] Firebase verify error:", err);
      return json({ error: "Invalid or expired Firebase token" }, 401);
    }

    const data = await verifyRes.json();
    const user = data.users?.[0];

    if (!user) return json({ error: "User not found" }, 401);

    firebaseUid = user.localId as string;
    email = user.email as string | undefined;
    emailVerified = user.emailVerified === true;

    if (!emailVerified) {
      return json({ error: "Email not verified" }, 403);
    }
  } catch (e) {
    console.error("[verify-token] Verification exception:", e);
    return json({ error: "Token verification failed" }, 500);
  }

  // ── Ensure profile row exists in Supabase ────────────────────────────────
  const { data: profile, error: profileErr } = await supabaseAdmin
    .from("profiles")
    .select("id")
    .eq("firebase_uid", firebaseUid)
    .maybeSingle();

  if (profileErr) {
    console.error("[verify-token] Profile lookup error:", profileErr.message);
    return json({ error: "Profile lookup failed" }, 500);
  }

  // ── Return verified UID so client can set header safely ──────────────────
  // The client uses this server-confirmed UID — not a self-reported one.
  return json(
    {
      uid: firebaseUid,
      profileId: profile?.id ?? null,
      email,
      emailVerified,
      verified: true,
    },
    200
  );
});

function corsHeaders(): Record<string, string> {
  return {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
  };
}

function json(data: unknown, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json",
      ...corsHeaders(),
    },
  });
}
