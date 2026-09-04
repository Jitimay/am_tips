/**
 * amTips — AfriPay Webhook Callback Edge Function
 *
 * AfriPay POSTs to this URL after a payment completes or fails.
 * URL: https://ygtgfqitctowlhkqomjw.supabase.co/functions/v1/afripay-callback
 *
 * AfriPay sends (POST, application/x-www-form-urlencoded or JSON):
 *   status           — "success" | "failed" | "cancelled"
 *   amount           — amount charged (customer_pays)
 *   currency         — "BIF" | "USD"
 *   transaction_ref  — AfriPay's own transaction reference
 *   payment_method   — "lumicash" | "bancobu_enoti" | etc.
 *   client_token     — the token we sent; format: tip_{tipId}_{random}
 *
 * This function:
 *   1. Validates the request (checks app_secret header/field).
 *   2. Looks up the payment row by client_token.
 *   3. Updates the payment status.
 *   4. The DB trigger on_payment_completed() then marks the tip completed
 *      and credits the waiter's wallet — no extra code needed here.
 *
 * Deploy with:
 *   supabase functions deploy afripay-callback --no-verify-jwt
 */

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const AFRIPAY_APP_SECRET = Deno.env.get("AFRIPAY_APP_SECRET")!;

// Use service_role so the UPDATE policy allows the status change.
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

Deno.serve(async (req: Request) => {
  // ── CORS preflight ──────────────────────────────────────────────────────
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 204,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type, Authorization",
      },
    });
  }

  if (req.method !== "POST") {
    return json({ error: "Method not allowed" }, 405);
  }

  // ── Parse body (AfriPay sends form-encoded or JSON) ─────────────────────
  let body: Record<string, string> = {};
  const contentType = req.headers.get("content-type") ?? "";

  try {
    if (contentType.includes("application/json")) {
      body = await req.json();
    } else {
      // application/x-www-form-urlencoded
      const text = await req.text();
      for (const pair of text.split("&")) {
        const [k, v] = pair.split("=");
        if (k) body[decodeURIComponent(k)] = decodeURIComponent(v ?? "");
      }
    }
  } catch {
    return json({ error: "Invalid request body" }, 400);
  }

  const {
    status: afriPayStatus,
    amount,
    currency,
    transaction_ref,
    payment_method,
    client_token,
    app_secret,
  } = body;

  // ── Basic validation ─────────────────────────────────────────────────────
  if (!client_token) {
    console.error("[afripay-callback] Missing client_token");
    return json({ error: "Missing client_token" }, 400);
  }

  // ── Verify secret ────────────────────────────────────────────────────────
  if (!app_secret) {
    console.warn("[afripay-callback] No app_secret in callback body — proceeding without verification");
  } else if (app_secret !== AFRIPAY_APP_SECRET) {
    console.error("[afripay-callback] Invalid app_secret");
    return json({ error: "Unauthorized" }, 401);
  }

  // ── Map AfriPay status → our status ─────────────────────────────────────
  let internalStatus: string;
  switch ((afriPayStatus ?? "").toLowerCase()) {
    case "success":
    case "completed":
      internalStatus = "completed";
      break;
    case "failed":
    case "error":
      internalStatus = "failed";
      break;
    case "cancelled":
    case "canceled":
      internalStatus = "cancelled";
      break;
    default:
      internalStatus = "pending";
  }

  console.log(
    `[afripay-callback] client_token=${client_token} ` +
    `afriPayStatus=${afriPayStatus} → internalStatus=${internalStatus} ` +
    `transaction_ref=${transaction_ref} amount=${amount} currency=${currency}`
  );

  // ── Update the payment row ───────────────────────────────────────────────
  // The DB trigger on_payment_completed() fires on this UPDATE and:
  //   • marks tip.status = 'completed'
  //   • credits wallets.balance += tip_amount
  const { error: updateError } = await supabase
    .from("payments")
    .update({
      status: internalStatus,
      transaction_ref: transaction_ref ?? null,
      payment_method: payment_method ?? null,
      // confirmed_at is set by the DB trigger for 'completed'
    })
    .eq("client_token", client_token)
    .eq("status", "pending"); // only update if still pending (idempotency)

  if (updateError) {
    console.error("[afripay-callback] DB update error:", updateError.message);
    // Return 200 to AfriPay regardless — retrying won't help a DB error
    return json({ ok: false, error: updateError.message }, 200);
  }

  console.log(`[afripay-callback] Payment updated: ${client_token} → ${internalStatus}`);

  // ── Send push notification to the waiter when a tip is completed ─────────
  if (internalStatus === "completed") {
    try {
      // Look up the tip → waiter from the payment row we just updated
      const { data: payment } = await supabase
        .from("payments")
        .select("tip_id, tip_amount, currency, tips(waiter_id)")
        .eq("client_token", client_token)
        .single();

      const waiterId = (payment?.tips as { waiter_id?: string })?.waiter_id;
      const tipAmount = payment?.tip_amount as number | undefined;
      const tipCurrency = (payment?.currency as string | undefined) ?? "BIF";
      const tipId = payment?.tip_id as string | undefined;
      const formattedAmount = tipAmount
        ? `${tipAmount.toLocaleString()} ${tipCurrency}`
        : "";

      if (waiterId) {
        const notifTitle = "💰 You received a tip!";
        const notifBody = formattedAmount
          ? `${formattedAmount} just landed in your wallet.`
          : "A new tip just landed in your wallet.";

        // 1. Insert a persistent notification row so the app page shows it
        await supabase.from("notifications").insert({
          user_id:  waiterId,
          type:     "new_tip",
          title:    notifTitle,
          body:     notifBody,
          is_read:  false,
          metadata: { tip_id: tipId ?? null, amount: tipAmount ?? null, currency: tipCurrency },
        });

        // 2. Send FCM push so the device gets a heads-up immediately
        await supabase.functions.invoke("send-notification", {
          body: {
            waiter_id: waiterId,
            title: notifTitle,
            body:  notifBody,
            data: {
              type:   "new_tip",
              tip_id: tipId ?? "",
            },
          },
        });
        console.log(`[afripay-callback] Notification inserted + push sent to waiter ${waiterId}`);
      }
    } catch (notifErr) {
      // Non-fatal — log but don't fail the callback response
      console.error("[afripay-callback] Failed to send push notification:", notifErr);
    }
  }

  return json({ ok: true, status: internalStatus }, 200);
});

function json(data: unknown, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  });
}
