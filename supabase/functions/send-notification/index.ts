/**
 * amTips — Send Notification Edge Function
 *
 * Sends an FCM push notification to one or all FCM tokens for a given waiter.
 * Called internally by other Edge Functions (afripay-callback, afripay-disbursement).
 * NOT exposed to the public — requires the Supabase service role key in the
 * Authorization header, OR called from another Edge Function directly.
 *
 * Body (JSON):
 * {
 *   waiter_id: string,          // UUID of the waiter to notify
 *   title: string,              // Notification title
 *   body: string,               // Notification body
 *   data?: Record<string,string> // Optional payload for routing (type, tip_id, etc.)
 * }
 *
 * Required Supabase secrets:
 *   FIREBASE_PROJECT_ID       — from Firebase console → Project Settings
 *   FIREBASE_SERVICE_ACCOUNT  — full JSON string of the Firebase service account key
 *                               (Firebase console → Service Accounts → Generate new private key)
 *
 * Deploy: supabase functions deploy send-notification --no-verify-jwt
 */

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL             = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const FIREBASE_PROJECT_ID      = Deno.env.get("FIREBASE_PROJECT_ID")!;
const FIREBASE_SERVICE_ACCOUNT = Deno.env.get("FIREBASE_SERVICE_ACCOUNT")!;

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 204,
      headers: { "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Methods": "POST, OPTIONS", "Access-Control-Allow-Headers": "Content-Type, Authorization" },
    });
  }

  if (req.method !== "POST") return jsonRes({ error: "Method not allowed" }, 405);

  let body: { waiter_id?: string; title?: string; body?: string; data?: Record<string, string> };
  try {
    body = await req.json();
  } catch {
    return jsonRes({ error: "Invalid JSON" }, 400);
  }

  const { waiter_id, title, body: msgBody, data } = body;
  if (!waiter_id || !title || !msgBody) {
    return jsonRes({ error: "waiter_id, title, and body are required" }, 400);
  }

  // ── 1. Fetch all FCM tokens for this waiter ──────────────────────────────
  const { data: tokens, error: tokenErr } = await supabase
    .from("device_tokens")
    .select("token")
    .eq("waiter_id", waiter_id);

  if (tokenErr) {
    console.error("[send-notification] Failed to fetch tokens:", tokenErr.message);
    return jsonRes({ error: "Failed to fetch device tokens" }, 500);
  }

  if (!tokens || tokens.length === 0) {
    console.log(`[send-notification] No tokens found for waiter ${waiter_id} — skipping`);
    return jsonRes({ ok: true, sent: 0, message: "No tokens registered" });
  }

  // ── 2. Get a Firebase access token via service account ──────────────────
  let accessToken: string;
  try {
    accessToken = await getFirebaseAccessToken();
  } catch (e) {
    console.error("[send-notification] Failed to get Firebase access token:", e);
    return jsonRes({ error: "Firebase auth failed" }, 500);
  }

  // ── 3. Send to each token via FCM HTTP v1 API ────────────────────────────
  const fcmUrl = `https://fcm.googleapis.com/v1/projects/${FIREBASE_PROJECT_ID}/messages:send`;

  let sentCount = 0;
  const staleTokens: string[] = [];

  for (const row of tokens) {
    const token = row.token as string;
    const message = {
      message: {
        token,
        notification: { title, body: msgBody },
        // data payload for routing in the app (all values must be strings)
        data: {
          type: data?.type ?? "system",
          ...(data ?? {}),
        },
        android: {
          priority: "high",
          notification: {
            channel_id: "amtips_notifications_channel",
            click_action: "FLUTTER_NOTIFICATION_CLICK",
          },
        },
        apns: {
          payload: {
            aps: { sound: "default", badge: 1 },
          },
        },
      },
    };

    try {
      const res = await fetch(fcmUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${accessToken}`,
        },
        body: JSON.stringify(message),
      });

      const resJson = await res.json() as Record<string, unknown>;

      if (res.ok) {
        sentCount++;
        console.log(`[send-notification] ✅ Sent to token ...${token.slice(-8)}`);
      } else {
        // FCM error codes for stale/invalid tokens
        const errCode = (resJson?.error as Record<string, unknown>)?.status as string;
        if (errCode === "UNREGISTERED" || errCode === "INVALID_ARGUMENT") {
          staleTokens.push(token);
          console.warn(`[send-notification] Stale token removed: ...${token.slice(-8)}`);
        } else {
          console.error(`[send-notification] FCM error for token ...${token.slice(-8)}:`, JSON.stringify(resJson));
        }
      }
    } catch (e) {
      console.error(`[send-notification] Network error sending to token:`, e);
    }
  }

  // ── 4. Clean up stale tokens ─────────────────────────────────────────────
  if (staleTokens.length > 0) {
    await supabase
      .from("device_tokens")
      .delete()
      .eq("waiter_id", waiter_id)
      .in("token", staleTokens);
  }

  return jsonRes({ ok: true, sent: sentCount, total: tokens.length });
});

// ── Firebase Service Account JWT helpers ─────────────────────────────────────

async function getFirebaseAccessToken(): Promise<string> {
  const sa = JSON.parse(FIREBASE_SERVICE_ACCOUNT) as {
    client_email: string;
    private_key: string;
  };

  const now = Math.floor(Date.now() / 1000);
  const payload = {
    iss: sa.client_email,
    sub: sa.client_email,
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
  };

  const jwt = await signJwt(payload, sa.private_key);

  const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
      assertion: jwt,
    }),
  });

  const tokenData = await tokenRes.json() as { access_token?: string };
  if (!tokenData.access_token) {
    throw new Error(`Failed to get access token: ${JSON.stringify(tokenData)}`);
  }
  return tokenData.access_token;
}

async function signJwt(
  payload: Record<string, unknown>,
  privateKeyPem: string
): Promise<string> {
  const header = { alg: "RS256", typ: "JWT" };

  const encode = (obj: unknown) =>
    btoa(JSON.stringify(obj))
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=/g, "");

  const signingInput = `${encode(header)}.${encode(payload)}`;

  // Import the RSA private key
  const keyData = pemToArrayBuffer(privateKeyPem);
  const cryptoKey = await crypto.subtle.importKey(
    "pkcs8",
    keyData,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"]
  );

  const signature = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    cryptoKey,
    new TextEncoder().encode(signingInput)
  );

  const sig = btoa(String.fromCharCode(...new Uint8Array(signature)))
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=/g, "");

  return `${signingInput}.${sig}`;
}

function pemToArrayBuffer(pem: string): ArrayBuffer {
  const b64 = pem
    .replace(/-----BEGIN PRIVATE KEY-----/, "")
    .replace(/-----END PRIVATE KEY-----/, "")
    .replace(/\n/g, "");
  const binary = atob(b64);
  const buffer = new ArrayBuffer(binary.length);
  const view = new Uint8Array(buffer);
  for (let i = 0; i < binary.length; i++) {
    view[i] = binary.charCodeAt(i);
  }
  return buffer;
}

// ── Helper ────────────────────────────────────────────────────────────────────

function jsonRes(data: unknown, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
  });
}
