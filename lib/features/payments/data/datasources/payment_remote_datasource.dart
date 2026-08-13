import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/payment_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentMethodModel>> getPaymentMethods();
  Future<PaymentResultModel> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  });
  Future<String> checkPaymentStatus(String paymentId);
  Future<TipFeeBreakdownModel> getFeeBreakdown({
    required int amount,
    required String currency,
  });
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final ApiClient apiClient;
  PaymentRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final res = await apiClient.get(ApiEndpoints.paymentMethods);
    final list = res.data['data'] as List;
    return list
        .map((e) => PaymentMethodModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PaymentResultModel> initiatePayment({
    required String tipId,
    required String methodId,
    required String idempotencyKey,
  }) async {
    final res = await apiClient.post(
      ApiEndpoints.initiatePayment(tipId),
      data: {'method_id': methodId},
      options: _withIdempotency(idempotencyKey),
    );
    return PaymentResultModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<String> checkPaymentStatus(String paymentId) async {
    final res = await apiClient.get(ApiEndpoints.paymentStatus(paymentId));
    return (res.data as Map<String, dynamic>)['status'] as String;
  }

  @override
  Future<TipFeeBreakdownModel> getFeeBreakdown({
    required int amount,
    required String currency,
  }) async {
    final res = await apiClient.get(
      '/payments/fee-preview',
      queryParameters: {'amount': amount, 'currency': currency},
    );
    return TipFeeBreakdownModel.fromJson(res.data as Map<String, dynamic>);
  }

  dynamic _withIdempotency(String key) {
    return null; // handled via Dio options headers in a real impl
  }
}
