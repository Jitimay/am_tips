import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_secrets.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/afripay_method_dto.dart';

/// AfriPay integration service — Direct C2B API (no WebView).
///
/// Flow:
///   1. [initiateC2B] → POSTs directly to AfriPay API (payment_type=3).
///   2. AfriPay sends a USSD push to the customer's phone.
///   3. Customer confirms on their phone.
///   4. AfriPay POSTs result to our Supabase Edge Function callback.
///   5. [getPaymentStatus] → app polls Supabase `payments` table until done.
class AfriPayService {
  final SupabaseClient _db;
  final _uuid = const Uuid();

  static const _apiUrl = 'https://www.api.afripay.africa';
  // Proxy for server-side calls (Supabase Edge Functions) — static IP whitelisted by AfriPay.
  static const _proxyUrl = 'http://162.35.118.233:8080';

  AfriPayService({SupabaseClient? client})
      : _db = client ?? Supabase.instance.client;

  // ── Fee Calculation ────────────────────────────────────────────────────────

  static int gatewayFee(int tipAmount) =>
      (tipAmount * AppConstants.afriPayFeePercent).round();

  static int platformFee(int tipAmount) =>
      (tipAmount * AppConstants.amTipsPlatformFeePercent).round();

  static int totalFee(int tipAmount) =>
      gatewayFee(tipAmount) + platformFee(tipAmount);

  static int customerPays(int tipAmount) => tipAmount;

  static int waiterReceives(int tipAmount) =>
      tipAmount - totalFee(tipAmount);

  // ── Token ─────────────────────────────────────────────────────────────────

  String generateClientToken(String tipId) {
    final short = _uuid.v4().substring(0, 6);
    return 'tip_${tipId}_$short';
  }

  // ── Direct C2B API ────────────────────────────────────────────────────────

  /// Fetches payment methods for [currency] from AfriPay API.
  /// [forWithdrawal] filters to only methods with enable_on_withdrawal=1 (PDF 2).
  Future<List<AfriPayMethodDto>> fetchPaymentMethods(
    String currency, {
    bool forWithdrawal = false,
  }) async {
    try {
      final uri = Uri.parse(_proxyUrl).replace(queryParameters: {
        'request': 'payment_currencies',
        'action': 'list_by_currency',
        'currency': currency,
        'app_id': AppSecrets.afriPayAppId,
        'app_secret': AppSecrets.afriPayAppSecret,
      });
      final response = await http.get(uri);
      debugPrint('[AfriPayService] fetchPaymentMethods (${response.statusCode}): ${response.body.substring(0, response.body.length.clamp(0, 300))}');
      final decoded = jsonDecode(response.body);

      final list = decoded is List
          ? decoded
          : (decoded is Map && decoded['list'] is List)
              ? decoded['list'] as List
              : (decoded is Map && decoded['data'] is List)
                  ? decoded['data'] as List
                  : <dynamic>[];

      return list
          .whereType<Map<String, dynamic>>()
          .where((m) => forWithdrawal
              ? m['enable_on_withdrawal'] == 1 || m['enable_on_withdrawal'] == '1' || m['enable_on_withdrawal'] == true
              : m['enable_on_collection'] == 1 || m['enable_on_collection'] == '1' || m['enable_on_collection'] == true)
          .map((m) => AfriPayMethodDto(
                id: m['payment_method_name'] as String? ?? m['slug'] as String? ?? m['id'] as String? ?? '',
                name: m['payment_method_name'] as String? ?? m['name'] as String? ?? '',
                provider: 'afripay',
                type: m['payment_method_type'] as String? ?? 'mobile_money',
                description: m['steps_to_follow'] as String? ?? '',
                isAvailable: true,
                emoji: _emojiForMethod(m['payment_method_name'] as String? ?? m['slug'] as String? ?? ''),
                requiresOtp: m['otp_on_collection'] == 1 || m['otp_on_collection'] == '1' || m['otp_on_collection'] == true,
                iconUrl: m['icon'] as String?,
              ))
          .where((m) => m.id.isNotEmpty)
          .toList();
    } catch (e) {
      debugPrint('[AfriPayService] fetchPaymentMethods error: $e');
      return forWithdrawal ? fallbackWithdrawalMethods() : fallbackMethods();
    }
  }

  static String _emojiForMethod(String slug) {
    const map = {
      'lumicash': '📱',
      'bancobu_enoti': '🏦',
      'ecocash': '🌿',
      'burundipay': '🇧🇮',
      'ihela': '💳',
    };
    return map[slug.toLowerCase()] ?? '💰';
  }

  /// Fallback if the API is unreachable.
  static List<AfriPayMethodDto> fallbackMethods() => [
        const AfriPayMethodDto(id: 'afripay', name: 'AfriPay', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '💳', requiresOtp: false),
        const AfriPayMethodDto(id: 'ecocash', name: 'EcoCash', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '🌿', requiresOtp: false),
        const AfriPayMethodDto(id: 'lumicash', name: 'LumiCash', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '📱', requiresOtp: true),
        const AfriPayMethodDto(id: 'ibb_mobile_plus', name: 'IBB Mobile Plus', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '🏦', requiresOtp: false),
        const AfriPayMethodDto(id: 'bancobu_enoti', name: 'eNoti', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '🏦', requiresOtp: false),
        const AfriPayMethodDto(id: 'ihela', name: 'iHela', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '💳', requiresOtp: false),
      ];

  /// Fallback withdrawal methods (enable_on_withdrawal=1).
  static List<AfriPayMethodDto> fallbackWithdrawalMethods() => [
        const AfriPayMethodDto(id: 'lumicash', name: 'LumiCash', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '📱', requiresOtp: false),
        const AfriPayMethodDto(id: 'bancobu_enoti', name: 'eNoti', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '🏦', requiresOtp: false),
        const AfriPayMethodDto(id: 'ibb_mobile_plus', name: 'IBB Mobile Plus', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '🏦', requiresOtp: false),
        const AfriPayMethodDto(id: 'ihela', name: 'iHela', provider: 'afripay', type: 'mobile_money', description: '', isAvailable: true, emoji: '💳', requiresOtp: false),
      ];

  /// [phone] — customer's mobile money number (e.g. 25761234567).
  /// [paymentMethod] — AfriPay method id (e.g. 'lumicash', 'bancobu_enoti').
  /// Returns AfriPay's response: {status, message, transaction_ref}.
  Future<Map<String, dynamic>> initiateC2B({
    required int amount,
    required String currency,
    required String clientToken,
    required String paymentMethod,
    required String phone,
    required String waiterName,
    String? otp,
  }) async {
    final body = {
      'request': 'payment',
      'payment_type': '3',
      'app_id': AppSecrets.afriPayAppId,
      'app_secret': AppSecrets.afriPayAppSecret,
      'payment_method': paymentMethod.toUpperCase(),
      'amount': amount.toString(),
      'currency': currency,
      'initiator': phone,
      'client_token': clientToken,
      'comment': 'Tip for $waiterName — amTips',
      'notify_url': AppSecrets.afriPayCallbackUrl,
    };
    if (otp != null && otp.isNotEmpty) body['otp'] = otp;

    try {
      debugPrint('[AfriPayService] C2B request → url: $_proxyUrl | method: $paymentMethod | amount: $amount | phone: $phone');
      final response = await http.post(Uri.parse(_proxyUrl), body: body);
      debugPrint('[AfriPayService] C2B raw response (${response.statusCode}): ${response.body}');
      if (response.statusCode != 200 || !response.body.trim().startsWith('{')) {
        return {
          'status': 'error',
          'message': response.statusCode == 403
              ? 'AfriPay access forbidden (IP not whitelisted). Please contact support.'
              : 'Payment initiation returned HTTP ${response.statusCode}.',
        };
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('[AfriPayService] C2B response: $json');
      return json;
    } catch (e) {
      debugPrint('[AfriPayService] C2B exception: $e');
      throw PaymentException(message: 'AfriPay request failed: $e');
    }
  }

  /// Requests an OTP for payment methods that require it (e.g. LUMICASH).
  Future<Map<String, dynamic>> getOtp({
    required String phone,
    required String paymentMethod,
  }) async {
    try {
      debugPrint('[AfriPayService] OTP request → phone: $phone | method: $paymentMethod');
      final response = await http.post(
        Uri.parse(_apiUrl),
        body: {
          'request': 'transaction',
          'action': 'getOTP',
          'mobile': phone,
          'payment_method': paymentMethod.toUpperCase(),
        },
      );
      debugPrint('[AfriPayService] OTP raw response (${response.statusCode}): ${response.body}');
      if (response.statusCode != 200 || !response.body.trim().startsWith('{')) {
        return {
          'status': 'error',
          'message': response.statusCode == 403
              ? 'AfriPay OTP request was forbidden (HTTP 403: IP not whitelisted).'
              : 'Failed to retrieve OTP from provider (HTTP ${response.statusCode}).',
        };
      }
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('[AfriPayService] OTP exception: $e');
      throw PaymentException(message: 'OTP request failed: $e');
    }
  }

  // ── Payment record in Supabase ─────────────────────────────────────────────

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
      if (platformFeeAmount > 0) insertData['platform_fee'] = platformFeeAmount;
      final row = await _db.from('payments').insert(insertData).select('id').single();
      return row['id'] as String;
    } on PostgrestException catch (e) {
      throw PaymentException(message: e.message);
    }
  }

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

  Future<Map<String, dynamic>?> getCompletedPayment(String clientToken) async {
    try {
      return await _db
          .from('payments')
          .select('id, status, transaction_ref, payment_method, tip_amount, currency')
          .eq('client_token', clientToken)
          .eq('status', 'completed')
          .maybeSingle();
    } on PostgrestException {
      return null;
    }
  }
}
