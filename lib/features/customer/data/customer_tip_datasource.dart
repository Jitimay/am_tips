import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../../payments/data/models/payment_model.dart';
import '../../profile/data/models/waiter_profile_model.dart';
import '../../tips/data/models/tip_model.dart';

abstract class CustomerTipDataSource {
  Future<PublicWaiterProfileModel> getWaiterPublicProfile(String waiterId);
  Future<TipFeeBreakdownModel> getFeeBreakdown({
    required String waiterId,
    required int amount,
    required String currency,
  });
  Future<TipModel> initiateTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
    String? idempotencyKey,
  });
  Future<PaymentResultModel> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  });
  Future<String> checkTipStatus(String tipId);
  Future<void> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  });
  Future<List<PaymentMethodModel>> getPaymentMethods();
}

class CustomerTipDataSourceImpl implements CustomerTipDataSource {
  final ApiClient apiClient;
  CustomerTipDataSourceImpl({required this.apiClient});

  @override
  Future<PublicWaiterProfileModel> getWaiterPublicProfile(
      String waiterId) async {
    final res =
        await apiClient.get(ApiEndpoints.waiterPublicProfile(waiterId));
    return PublicWaiterProfileModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<TipFeeBreakdownModel> getFeeBreakdown({
    required String waiterId,
    required int amount,
    required String currency,
  }) async {
    final res = await apiClient.get(
      '/public/fee-preview',
      queryParameters: {
        'waiter_id': waiterId,
        'amount': amount,
        'currency': currency,
      },
    );
    return TipFeeBreakdownModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<TipModel> initiateTip({
    required String waiterId,
    required int amount,
    required String currency,
    required bool isAnonymous,
    String? idempotencyKey,
  }) async {
    final res = await apiClient.post(
      ApiEndpoints.initiateTip(waiterId),
      data: {
        'amount': amount,
        'currency': currency,
        'is_anonymous': isAnonymous,
        if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      },
    );
    return TipModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<PaymentResultModel> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  }) async {
    final res = await apiClient.post(
      ApiEndpoints.initiatePayment(tipId),
      data: {'method_id': methodId, 'idempotency_key': idempotencyKey},
    );
    return PaymentResultModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<String> checkTipStatus(String tipId) async {
    final res = await apiClient.get(ApiEndpoints.tipPaymentStatus(tipId));
    return (res.data as Map<String, dynamic>)['status'] as String;
  }

  @override
  Future<void> submitFeedback({
    required String tipId,
    int? rating,
    String? message,
  }) async {
    await apiClient.post(
      ApiEndpoints.completeTip(tipId),
      data: {
        if (rating != null) 'rating': rating,
        if (message != null) 'message': message,
      },
    );
  }

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final res = await apiClient.get('/public/payment-methods');
    final list = res.data['data'] as List;
    return list
        .map((e) => PaymentMethodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
