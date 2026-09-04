import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/exceptions.dart';
import '../../payments/data/datasources/payment_remote_datasource.dart';
import '../../payments/data/services/afripay_service.dart';
import '../../profile/data/models/waiter_profile_model.dart';
import '../../tips/data/models/tip_model.dart';

/// Customer-facing datasource.
/// Uses Supabase directly for profile + tip data.
/// Uses AfriPayService for the payment flow.
abstract class CustomerTipDataSource {
  Future<PublicWaiterProfileModel> getWaiterPublicProfile(String waiterId);

  Future<Map<String, dynamic>?> getActiveCampaign(String waiterId);

  AfriPayFeeDto getFeeBreakdown({
    required int tipAmount,
    required String currency,
  });

  Future<TipModel> insertTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
  });

  Future<AfriPayCheckoutDto> initiateAfriPayCheckout({
    required String tipId,
    required String waiterId,
    required String waiterName,
    required int tipAmount,
    required String currency,
  });

  Future<Map<String, dynamic>> sendC2BRequest({
    required String clientToken,
    required int amount,
    required String currency,
    required String paymentMethod,
    required String phone,
    required String waiterName,
    String? otp,
  });

  Future<Map<String, dynamic>> requestOtp({
    required String phone,
    required String paymentMethod,
  });

  Future<String> pollPaymentStatus(String clientToken);

  Future<Map<String, dynamic>?> getCompletedPayment(String clientToken);

  Future<void> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  });

  Future<List<AfriPayMethodDto>> getPaymentMethods(String currency);
}

class CustomerTipDataSourceImpl implements CustomerTipDataSource {
  final SupabaseClient _db;
  final AfriPayService _afri;
  final PaymentRemoteDataSource _paymentDs;

  CustomerTipDataSourceImpl({
    SupabaseClient? client,
    AfriPayService? afriPayService,
    PaymentRemoteDataSource? paymentDataSource,
  })  : _db = client ?? Supabase.instance.client,
        _afri = afriPayService ?? AfriPayService(),
        _paymentDs = paymentDataSource ?? PaymentRemoteDataSourceImpl();

  // ── Public profile ────────────────────────────────────────────────────────

  @override
  Future<PublicWaiterProfileModel> getWaiterPublicProfile(
      String waiterId) async {
    try {
      final data = await _db
          .from('profiles')
          .select(
            'id, full_name, avatar_url, restaurant_name, city, country, '
            'personal_message, average_rating, total_ratings, professions, qr_token',
          )
          .eq('id', waiterId)
          .eq('is_active', true)
          .single();
      return PublicWaiterProfileModel.fromJson(data);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  @override
  Future<Map<String, dynamic>?> getActiveCampaign(String waiterId) async {
    try {
      final rows = await _db
          .from('campaigns')
          .select('id, title, description, emoji, target_amount, current_amount, tips_count, currency, category, end_date')
          .eq('waiter_id', waiterId)
          .eq('is_active', true)
          .order('created_at', ascending: false)
          .limit(1);
      if (rows.isNotEmpty) return Map<String, dynamic>.from(rows.first);
      return null;
    } catch (_) {
      return null; // non-critical — don't break the tipping flow
    }
  }

  // ── Fee breakdown (local — no network needed) ─────────────────────────────

  @override
  AfriPayFeeDto getFeeBreakdown({
    required int tipAmount,
    required String currency,
  }) {
    return _paymentDs.getFeeBreakdown(
      tipAmount: tipAmount,
      currency: currency,
    );
  }

  // ── Create tip row in Supabase ────────────────────────────────────────────

  @override
  Future<TipModel> insertTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
  }) async {
    try {
      // Tips are inserted with status = 'pending' until AfriPay confirms.
      final row = await _db
          .from('tips')
          .insert({
            'waiter_id': waiterId,
            'amount': amount,
            'currency': currency,
            'status': 'pending',
            'is_anonymous': isAnonymous,
          })
          .select()
          .single();
      return TipModel.fromJson(row);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: int.tryParse(e.code ?? ''),
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString(), statusCode: null);
    }
  }

  // ── AfriPay checkout ──────────────────────────────────────────────────────

  @override
  Future<AfriPayCheckoutDto> initiateAfriPayCheckout({
    required String tipId,
    required String waiterId,
    required String waiterName,
    required int tipAmount,
    required String currency,
  }) async {
    return _paymentDs.initiateCheckout(
      tipId: tipId,
      waiterId: waiterId,
      waiterName: waiterName,
      tipAmount: tipAmount,
      currency: currency,
    );
  }

  @override
  Future<Map<String, dynamic>> sendC2BRequest({
    required String clientToken,
    required int amount,
    required String currency,
    required String paymentMethod,
    required String phone,
    required String waiterName,
    String? otp,
  }) =>
      _paymentDs.sendC2BRequest(
        clientToken: clientToken,
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod,
        phone: phone,
        waiterName: waiterName,
        otp: otp,
      );

  @override
  Future<Map<String, dynamic>> requestOtp({
    required String phone,
    required String paymentMethod,
  }) =>
      _paymentDs.requestOtp(phone: phone, paymentMethod: paymentMethod);

  // ── Status polling ────────────────────────────────────────────────────────

  @override
  Future<String> pollPaymentStatus(String clientToken) {
    return _afri.getPaymentStatus(clientToken);
  }

  @override
  Future<Map<String, dynamic>?> getCompletedPayment(String clientToken) {
    return _afri.getCompletedPayment(clientToken);
  }

  // ── Feedback ──────────────────────────────────────────────────────────────

  @override
  Future<void> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (rating != null) updates['rating'] = rating;
      if (message != null && message.isNotEmpty) updates['message'] = message;
      if (updates.isEmpty) return;

      await _db.from('tips').update(updates).eq('id', tipId);
    } on PostgrestException catch (e) {
      debugPrint('[CustomerTipDataSource] submitFeedback error: ${e.message}');
      // Non-critical — don't throw
    }
  }

  // ── Payment methods ───────────────────────────────────────────────────────

  @override
  Future<List<AfriPayMethodDto>> getPaymentMethods(String currency) =>
      _paymentDs.getPaymentMethods(currency);
}
