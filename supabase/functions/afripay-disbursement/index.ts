/**
 * amTips — AfriPay Disbursement Edge Function
 *
 * Called by the Flutter app after a withdrawal is created.
 * Calls AfriPay Disbursement API (payment_type=6) and updates the withdrawal row.
 *
 * URL: https://ygtgfqitctowlhkqomjw.supabase.co/functions/v1/afripay-disbursement
 *
 * Body (JSON): { withdrawal_id: string }
 */

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const AFRIPAY_APP_ID = Deno.env.get("AFRIPAY_APP_ID")!;
const AFRIPAY_APP_SECRET = Deno.env.get("AFRIPAY_APP_SECRET")!;
const AFRIPAY_ACCESS_TOKEN = Deno.env.get("AFRIPAY_ACCESS_TOKEN")!;

const AFRIPAY_API = "http://162.35.118.233:8080";

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

Deno.serve(async (req: Request) => {
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

  if (req.method !== "POST") return json({ error: "Method not allowed" }, 405);

  let body: { withdrawal_id?: string };
  try {
    body = await req.json();
  } catch {
    return json({ error: "Invalid JSON body" }, 400);
  }

  const { withdrawal_id } = body;
  if (!withdrawal_id) return json({ error: "Missing withdrawal_id" }, 400);

  // ── Fetch withdrawal + payment account ──────────────────────────────────
  const { data: withdrawal, error: fetchErr } = await supabase
    .from("withdrawals")
    .select("id, amount, currency, status, payment_account_id, waiter_id")
    .eq("id", withdrawal_id)
    .single();

  if (fetchErr || !withdrawal) {
    console.error("[disbursement] Withdrawal not found:", fetchErr?.message);
    return json({ error: "Withdrawal not found" }, 404);
  }

  if (withdrawal.status !== "requested") {
    return json({ error: `Withdrawal already in status: ${withdrawal.status}` }, 409);
  }

  // ── Fetch payment account (phone number) ────────────────────────────────
  const { data: account, error: accErr } = await supabase
    .from("payment_accounts")
    .select("account_identifier, provider")
    .eq("id", withdrawal.payment_account_id)
    .single();

  if (accErr || !account) {
    console.error("[disbursement] Payment account not found:", accErr?.message);
    await markFailed(withdrawal_id, "Payment account not found");
    return json({ error: "Payment account not found" }, 404);
  }

  // ── Mark as processing ───────────────────────────────────────────────────
  await supabase
    .from("withdrawals")
    .update({ status: "processing", updated_at: new Date().toISOString() })
    .eq("id", withdrawal_id);

  // ── Call AfriPay Disbursement API ────────────────────────────────────────
  const params = new URLSearchParams({
    request: "payment",
    payment_type: "6",
    app_id: AFRIPAY_APP_ID,
    app_secret: AFRIPAY_APP_SECRET,
    access_token: AFRIPAY_ACCESS_TOKEN,
    payment_method: account.provider,
    amount: withdrawal.amount.toString(),
    currency: withdrawal.currency,
    recipient: account.account_identifier,
    comment: `amTips withdrawal ${withdrawal_id.substring(0, 8)}`,
  });

  let afriPayRes: Record<string, string>;
  try {
    const res = await fetch(AFRIPAY_API, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString(),
    });
    afriPayRes = await res.json();
    console.log("[disbursement] AfriPay response:", JSON.stringify(afriPayRes));
  } catch (e) {
    console.error("[disbursement] AfriPay request failed:", e);
    await markFailed(withdrawal_id, "AfriPay request failed");
    return json({ error: "AfriPay request failed" }, 502);
  }

  // ── Update withdrawal based on AfriPay response ──────────────────────────
  if (afriPayRes.status === "success") {
    const transactionRef = afriPayRes.transaction_ref;

    // Poll checkstatus to confirm final state (PDF 2 — section 4)
    const finalStatus = await pollCheckStatus(transactionRef);

    if (finalStatus === "success") {
      await supabase
        .from("withdrawals")
        .update({
          status: "completed",
          provider_reference: transactionRef ?? null,
          updated_at: new Date().toISOString(),
        })
        .eq("id", withdrawal_id);
      return json({ ok: true, status: "completed", transaction_ref: transactionRef });
    } else {
      await markFailed(withdrawal_id, `Disbursement not confirmed: ${finalStatus}`);
      return json({ ok: false, status: "failed", message: `Not confirmed: ${finalStatus}` }, 200);
    }
  } else {
    await markFailed(withdrawal_id, afriPayRes.message ?? "AfriPay disbursement failed");
    return json({ ok: false, status: "failed", message: afriPayRes.message }, 200);
  }
});

async function pollCheckStatus(
  transactionRef: string,
  maxAttempts = 5,
  delayMs = 3000
): Promise<string> {
  for (let i = 0; i < maxAttempts; i++) {
    await new Promise((r) => setTimeout(r, delayMs));
    try {
      const params = new URLSearchParams({
        request: "transaction",
        action: "checkstatus",
        transaction_ref: transactionRef,
      });
      const res = await fetch(AFRIPAY_API, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString(),
      });
      const data = await res.json() as Record<string, string>;
      console.log(`[disbursement] checkstatus attempt ${i + 1}:`, JSON.stringify(data));
      const s = (data.status ?? "").toLowerCase();
      if (s === "success" || s === "completed") return "success";
      if (s === "failed" || s === "error" || s === "cancelled") return s;
      // still pending — keep polling
    } catch (e) {
      console.error(`[disbursement] checkstatus error attempt ${i + 1}:`, e);
    }
  }
  return "pending"; // could not confirm after all attempts
}

async function markFailed(withdrawalId: string, reason: string) {
  await supabase
    .from("withdrawals")
    .update({
      status: "failed",
      failure_reason: reason,
      updated_at: new Date().toISOString(),
    })
    .eq("id", withdrawalId);
}

function json(data: unknown, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  });
}
