/**
 * amTips — AfriPay Disbursement Edge Function
 *
 * Called by the Flutter app after a withdrawal is created with status='requested'.
 * Calls AfriPay Disbursement API (payment_type=6) and updates the withdrawal row.
 *
 * On SUCCESS  → withdrawal.status = 'completed'
 * On FAILURE  → withdrawal.status = 'failed' + balance RESTORED to wallet
 *
 * AfriPay API (from official PDF docs): https://www.api.afripay.africa
 * payment_type = 6 (disbursement/payout)
 */

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL             = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const AFRIPAY_APP_ID           = Deno.env.get("AFRIPAY_APP_ID")!;
const AFRIPAY_APP_SECRET       = Deno.env.get("AFRIPAY_APP_SECRET")!;
const AFRIPAY_ACCESS_TOKEN     = Deno.env.get("AFRIPAY_ACCESS_TOKEN")!;

// ✅ Correct URL from AfriPay disbursement PDF docs
const AFRIPAY_API = "https://www.api.afripay.africa";

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

  console.log(`[disbursement] Processing withdrawal: ${withdrawal_id}`);

  // ── 1. Fetch withdrawal ──────────────────────────────────────────────────
  const { data: withdrawal, error: fetchErr } = await supabase
    .from("withdrawals")
    .select("id, amount, currency, status, payment_account_id, waiter_id")
    .eq("id", withdrawal_id)
    .single();

  if (fetchErr || !withdrawal) {
    console.error("[disbursement] Withdrawal not found:", fetchErr?.message);
    return json({ error: "Withdrawal not found" }, 404);
  }

  // Idempotency: skip if already processed
  if (withdrawal.status !== "requested") {
    console.log(`[disbursement] Skipping — status is '${withdrawal.status}'`);
    return json({ ok: true, status: withdrawal.status, skipped: true });
  }

  // ── 2. Fetch payment account ─────────────────────────────────────────────
  const { data: account, error: accErr } = await supabase
    .from("payment_accounts")
    .select("account_identifier, provider")
    .eq("id", withdrawal.payment_account_id)
    .single();

  if (accErr || !account) {
    console.error("[disbursement] Payment account not found:", accErr?.message);
    await markFailed(withdrawal_id, withdrawal.waiter_id, withdrawal.amount,
      "Payment account not found");
    return json({ error: "Payment account not found" }, 404);
  }

  // ── 3. Fetch payment method code for this provider ───────────────────────
  // PDF section 2: GET payment methods that have enable_on_withdrawal=1
  // We pass the provider name (e.g. "lumicash") and look up the numeric code.
  // If the lookup fails we fall back to using the provider string directly.
  let paymentMethodCode = account.provider as string;
  try {
    const pmRes = await fetch(
      `${AFRIPAY_API}/?request=payment_currencies&action=list_by_currency&currency=${withdrawal.currency}`
    );
    const pmData = await pmRes.json() as Array<Record<string, unknown>>;
    const match = pmData.find(
      (m) =>
        (m.enable_on_withdrawal == 1 || m.enable_on_withdrawal === "1") &&
        String(m.name ?? m.slug ?? "")
          .toLowerCase()
          .includes((account.provider as string).toLowerCase())
    );
    if (match && match.id) {
      paymentMethodCode = String(match.id);
      console.log(`[disbursement] Resolved payment method: ${account.provider} → ${paymentMethodCode}`);
    }
  } catch (e) {
    console.warn("[disbursement] Could not fetch payment methods, using provider string:", e);
  }

  // ── 4. Mark as processing ─────────────────────────────────────────────────
  await supabase
    .from("withdrawals")
    .update({ status: "processing", updated_at: new Date().toISOString() })
    .eq("id", withdrawal_id);

  // ── 5. Call AfriPay Disbursement API ─────────────────────────────────────
  // PDF section 3: POST form-data to https://www.api.afripay.africa
  const params = new URLSearchParams({
    request:        "payment",
    payment_type:   "6",
    app_id:         AFRIPAY_APP_ID,
    app_secret:     AFRIPAY_APP_SECRET,
    access_token:   AFRIPAY_ACCESS_TOKEN,
    payment_method: paymentMethodCode,
    amount:         withdrawal.amount.toString(),
    currency:       withdrawal.currency,
    recipient:      (account.account_identifier as string).replace(/^\+/, ""),
    comment:        `amTips withdrawal ${withdrawal_id.substring(0, 8)}`,
  });

  console.log(`[disbursement] Calling AfriPay: recipient=${account.account_identifier}, amount=${withdrawal.amount} ${withdrawal.currency}`);

  let afriPayRes: Record<string, string>;
  try {
    const res = await fetch(AFRIPAY_API, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: params.toString(),
    });
    const raw = await res.text();
    console.log("[disbursement] AfriPay raw response:", raw);
    try {
      afriPayRes = JSON.parse(raw);
    } catch {
      // Non-JSON response from AfriPay
      await markFailed(withdrawal_id, withdrawal.waiter_id, withdrawal.amount,
        `Non-JSON response: ${raw.substring(0, 200)}`);
      return json({ error: "AfriPay returned non-JSON response" }, 502);
    }
  } catch (e) {
    const msg = `Network error reaching AfriPay: ${e instanceof Error ? e.message : String(e)}`;
    console.error("[disbursement]", msg);
    await markFailed(withdrawal_id, withdrawal.waiter_id, withdrawal.amount, msg);
    return json({ error: msg }, 502);
  }

  // ── 6. Handle AfriPay response ────────────────────────────────────────────
  // PDF: status=success means success, status=error means failed
  const responseStatus = (afriPayRes.status ?? "").toLowerCase();

  if (responseStatus !== "success") {
    const reason = afriPayRes.message ?? `AfriPay error: ${responseStatus}`;
    console.error("[disbursement] AfriPay rejected disbursement:", reason);
    await markFailed(withdrawal_id, withdrawal.waiter_id, withdrawal.amount, reason);
    return json({ ok: false, status: "failed", message: reason });
  }

  const transactionRef = afriPayRes.transaction_ref ?? afriPayRes.transactionRef ?? null;
  console.log("[disbursement] AfriPay accepted, transaction_ref:", transactionRef);

  // ── 7. Poll checkstatus to confirm ───────────────────────────────────────
  // PDF section 4: POST { request, action, transaction_ref }
  if (transactionRef) {
    const finalStatus = await pollCheckStatus(transactionRef);

    if (finalStatus === "success") {
      await supabase
        .from("withdrawals")
        .update({
          status:             "completed",
          provider_reference: transactionRef,
          updated_at:         new Date().toISOString(),
        })
        .eq("id", withdrawal_id);
      console.log(`[disbursement] ✅ Withdrawal ${withdrawal_id} COMPLETED`);
      return json({ ok: true, status: "completed", transaction_ref: transactionRef });
    }

    if (finalStatus === "failed" || finalStatus === "error" || finalStatus === "cancelled") {
      await markFailed(withdrawal_id, withdrawal.waiter_id, withdrawal.amount,
        `Disbursement ${finalStatus} after confirmation`);
      return json({ ok: false, status: "failed", message: `Confirmed as ${finalStatus}` });
    }
  }

  // AfriPay said success but we couldn't confirm yet — leave as processing.
  // A webhook or manual retry will update later.
  console.log(`[disbursement] Withdrawal ${withdrawal_id} left as 'processing' — pending confirmation`);
  return json({ ok: true, status: "processing", transaction_ref: transactionRef });
});

// ── Polling ───────────────────────────────────────────────────────────────────

async function pollCheckStatus(
  transactionRef: string,
  maxAttempts = 6,
  delayMs = 4000
): Promise<string> {
  for (let i = 0; i < maxAttempts; i++) {
    await new Promise((r) => setTimeout(r, delayMs));
    try {
      // PDF section 4: required params are request, action, transaction_ref
      const params = new URLSearchParams({
        request:         "transaction",
        action:          "checkstatus",
        app_id:          AFRIPAY_APP_ID,
        app_secret:      AFRIPAY_APP_SECRET,
        access_token:    AFRIPAY_ACCESS_TOKEN,
        transaction_ref: transactionRef,
      });
      const res = await fetch(AFRIPAY_API, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString(),
      });
      const data = await res.json() as Record<string, string>;
      const s = (data.status ?? "").toLowerCase();
      console.log(`[disbursement] checkstatus attempt ${i + 1}/${maxAttempts}: ${s}`);
      if (s === "success" || s === "completed") return "success";
      if (s === "failed" || s === "error" || s === "cancelled") return s;
      // still pending — keep polling
    } catch (e) {
      console.error(`[disbursement] checkstatus error attempt ${i + 1}:`, e);
    }
  }
  return "pending";
}

// ── Status updaters ────────────────────────────────────────────────────────────

/**
 * Marks the withdrawal as failed AND restores the balance.
 * Critical: without this the user permanently loses money on failed withdrawals.
 */
async function markFailed(
  withdrawalId: string,
  waiterId: string,
  amount: number,
  reason: string
) {
  console.log(`[disbursement] ❌ FAILED ${withdrawalId}: ${reason}. Restoring ${amount} to wallet.`);

  // Restore the balance that was deducted when the withdrawal was created
  const { error: restoreErr } = await supabase.rpc("restore_withdrawal_balance", {
    p_waiter_id: waiterId,
    p_amount:    amount,
  });

  if (restoreErr) {
    // Log clearly — this needs manual intervention
    console.error(
      `[disbursement] CRITICAL: could not restore balance for waiter ${waiterId}:`,
      restoreErr.message
    );
  }

  await supabase
    .from("withdrawals")
    .update({
      status:         "failed",
      failure_reason: reason,
      updated_at:     new Date().toISOString(),
    })
    .eq("id", withdrawalId);
}

// ── Helpers ────────────────────────────────────────────────────────────────────

function json(data: unknown, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  });
}
