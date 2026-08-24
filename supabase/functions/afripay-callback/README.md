# AfriPay Callback Edge Function

Receives AfriPay's webhook POST after a payment completes or fails.

## Deploy

```bash
# Install Supabase CLI if not already installed
npm install -g supabase

# Login
supabase login

# Link to your project
supabase link --project-ref ygtgfqitctowlhkqomjw

# Set the AfriPay secret as an env variable (never hardcode in code)
supabase secrets set AFRIPAY_APP_SECRET=JDJ5JDEwJDI0dlNu

# Deploy the function (no JWT verification — AfriPay is not an authenticated caller)
supabase functions deploy afripay-callback --no-verify-jwt
```

## Callback URL to send to AfriPay

```
https://ygtgfqitctowlhkqomjw.supabase.co/functions/v1/afripay-callback
```

Send this URL to marcellin@afriregister.com as your `callbackUrl`.

## What it does

1. Receives AfriPay POST with: `status`, `amount`, `currency`, `transaction_ref`,
   `payment_method`, `client_token`
2. Maps AfriPay status → internal status (`success` → `completed`, etc.)
3. Updates the `payments` row matching `client_token`
4. The Supabase DB trigger `trg_on_payment_completed` then automatically:
   - Marks `tips.status = 'completed'`
   - Credits `wallets.balance += tip_amount`

## Test locally

```bash
supabase functions serve afripay-callback --no-verify-jwt

# Simulate a successful AfriPay callback
curl -X POST http://localhost:54321/functions/v1/afripay-callback \
  -H "Content-Type: application/json" \
  -d '{
    "status": "success",
    "amount": "1040",
    "currency": "BIF",
    "transaction_ref": "TXN123456",
    "payment_method": "lumicash",
    "client_token": "tip_abc123_x7k2m1"
  }'
```
