import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';

/// AfriPay integration service.
///
/// Flow:
///   1. [buildCheckoutUri] → builds the amTips web checkout-redirect URL.
///   2. AfriPay checkout runs inside the app WebView via checkout-redirect page.
///   3. AfriPay POSTs the result to our Supabase Edge Function callback.
///   4. [getPaymentStatus] → app polls Supabase `payments` table until done.
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

  /// Builds the checkout-redirect URL on the amTips web app.
  /// The web page handles the AfriPay POST form server-side (secret stays there).
  Uri buildCheckoutUri({
    required int amount,
    required String currency,
    required String clientToken,
    required String waiterId,
    required String waiterName,
  }) {
    final returnUrl =
        '${AppConstants.webBaseUrl}/t/$waiterId/success'
        '?token=${Uri.encodeComponent(clientToken)}';

    return Uri.parse(
      '${AppConstants.webBaseUrl}/t/$waiterId/checkout-redirect',
    ).replace(queryParameters: {
      'amount': amount.toString(),
      'currency': currency,
      'client_token': clientToken,
      'comment': 'Tip for $waiterName — amTips',
      'return_url': returnUrl,
    });
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
