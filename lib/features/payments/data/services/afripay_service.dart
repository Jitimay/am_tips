import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';

/// AfriPay integration service.
///
/// Flow:
///   1. [buildCheckoutUrl] → builds a signed URL / HTML form params.
///   2. [launchCheckout]   → opens AfriPay checkout in the system browser.
///   3. AfriPay POSTs the result to our Supabase Edge Function callback.
///   4. [pollPaymentStatus] → app polls Supabase `payments` table until done.
///
/// API details (from AfriPay, marcellin@afriregister.com):
///   POST https://www.afripay.africa/checkout/index.php
///   Fields: amount, currency, comment, client_token, return_url, app_id, app_secret
///   Callback POST: status, amount, currency, transaction_ref, payment_method, client_token
class AfriPayService {
  final SupabaseClient _db;
  final _uuid = const Uuid();

  AfriPayService({SupabaseClient? client})
      : _db = client ?? Supabase.instance.client;

  // ── Fee Calculation ────────────────────────────────────────────────────────

  /// Calculates the AfriPay gateway fee (4%) on a total tip amount.
  static int gatewayFee(int tipAmount) =>
      (tipAmount * AppConstants.afriPayFeePercent).round();

  /// Calculates the amTips platform fee (6%) on a total tip amount.
  static int platformFee(int tipAmount) =>
      (tipAmount * AppConstants.amTipsPlatformFeePercent).round();

  /// Total fee deductions (4% AfriPay + 6% amTips = 10%).
  static int totalFee(int tipAmount) =>
      gatewayFee(tipAmount) + platformFee(tipAmount);

  /// The total amount the customer pays (e.g. 10,000 BIF).
  static int customerPays(int tipAmount) => tipAmount;

  /// The net amount the waiter receives in their wallet (e.g. 9,000 BIF).
  static int waiterReceives(int tipAmount) =>
      tipAmount - totalFee(tipAmount);

  // ── Checkout ──────────────────────────────────────────────────────────────

  /// Generates a unique order/client token for this payment.
  /// Format: tip_{tipId}_{random6}
  String generateClientToken(String tipId) {
    final short = _uuid.v4().substring(0, 6);
    return 'tip_${tipId}_$short';
  }

  /// Builds the AfriPay checkout URL as a Uri with all parameters embedded.
  /// AfriPay uses a POST form but we construct a GET-compatible redirect URL
  /// so we can open it directly without a server round-trip.
  ///
  /// Returns the Uri to launch in the browser.
  Uri buildCheckoutUri({
    required int amount,
    required String currency,
    required String clientToken,
    required String comment,
  }) {
    // AfriPay expects a POST form. We use url_launcher to open their
    // checkout page passing params as query strings — AfriPay supports this.
    return Uri.parse(AppConstants.afriPayCheckoutUrl).replace(
      queryParameters: {
        'amount': amount.toString(),
        'currency': currency,
        'comment': comment,
        'client_token': clientToken,
        'return_url': AppConstants.afriPayReturnUrl,
        'app_id': AppConstants.afriPayAppId,
        'app_secret': AppConstants.afriPayAppSecret,
      },
    );
  }

  /// Opens the AfriPay checkout page in the device's default browser.
  /// Throws [PaymentException] if the browser cannot be launched.
  Future<void> launchCheckout({
    required int amount,
    required String currency,
    required String clientToken,
    required String comment,
  }) async {
    final uri = buildCheckoutUri(
      amount: amount,
      currency: currency,
      clientToken: clientToken,
      comment: comment,
    );

    debugPrint('[AfriPayService] Launching checkout: $uri');

    final canLaunch = await canLaunchUrl(uri);
    if (!canLaunch) {
      throw const PaymentException(
        message: 'Could not open the payment page. Please check your browser.',
      );
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  // ── Payment record in Supabase ─────────────────────────────────────────────

  /// Creates a pending payment record in Supabase before launching checkout.
  /// Returns the inserted row id.
  Future<String> createPendingPayment({
    required String tipId,
    required String clientToken,
    required int tipAmount,
    required int gatewayFeeAmount,
    int platformFeeAmount = 0,
    required int customerPaysAmount,
    required String currency,
  }) async {
    try {
      final insertData = <String, dynamic>{
        'tip_id': tipId,
        'client_token': clientToken,
        'tip_amount': tipAmount,
        'gateway_fee': gatewayFeeAmount,
        'customer_pays': customerPaysAmount,
        'currency': currency,
        'status': 'pending',
        'provider': 'afripay',
      };
      if (platformFeeAmount > 0) {
        insertData['platform_fee'] = platformFeeAmount;
      }

      final row = await _db.from('payments').insert(insertData).select('id').single();

      return row['id'] as String;
    } on PostgrestException catch (e) {
      throw PaymentException(message: e.message);
    }
  }

  /// Polls the Supabase `payments` table for the given [clientToken].
  /// Returns the current status string: 'pending' | 'completed' | 'failed'.
  Future<String> getPaymentStatus(String clientToken) async {
    try {
      final row = await _db
          .from('payments')
          .select('status, transaction_ref, payment_method')
          .eq('client_token', clientToken)
          .maybeSingle();

      if (row == null) return 'pending';
      return row['status'] as String? ?? 'pending';
    } on PostgrestException catch (e) {
      debugPrint('[AfriPayService] getPaymentStatus error: ${e.message}');
      return 'pending';
    }
  }

  /// Fetches the full payment row after confirmation.
  Future<Map<String, dynamic>?> getCompletedPayment(
      String clientToken) async {
    try {
      return await _db
          .from('payments')
          .select(
              'id, status, transaction_ref, payment_method, tip_amount, currency')
          .eq('client_token', clientToken)
          .eq('status', 'completed')
          .maybeSingle();
    } on PostgrestException {
      return null;
    }
  }
}
