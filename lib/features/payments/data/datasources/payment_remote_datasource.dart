import '../models/afripay_method_dto.dart';
import '../services/afripay_service.dart';

export '../models/afripay_method_dto.dart';

abstract class PaymentRemoteDataSource {
  /// Fetches available payment methods from AfriPay API dynamically.
  Future<List<AfriPayMethodDto>> getPaymentMethods(String currency);

  AfriPayFeeDto getFeeBreakdown({required int tipAmount, required String currency});

  /// Creates a pending payment record in Supabase.
  /// Returns a [AfriPayCheckoutDto] containing the clientToken for polling.
  Future<AfriPayCheckoutDto> initiateCheckout({
    required String tipId,
    required String waiterId,
    required String waiterName,
    required int tipAmount,
    required String currency,
  });

  /// Calls AfriPay C2B API directly — sends USSD push to [phone].
  /// Returns AfriPay's response {status, message, transaction_ref}.
  Future<Map<String, dynamic>> sendC2BRequest({
    required String clientToken,
    required int amount,
    required String currency,
    required String paymentMethod,
    required String phone,
    required String waiterName,
    String? otp,
  });

  /// Requests OTP for methods that require it (e.g. lumicash).
  Future<Map<String, dynamic>> requestOtp({
    required String phone,
    required String paymentMethod,
  });

  Future<String> pollPaymentStatus(String clientToken);

  Future<Map<String, dynamic>?> getCompletedPayment(String clientToken);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final AfriPayService afriPayService;

  PaymentRemoteDataSourceImpl({AfriPayService? afriPayService})
      : afriPayService = afriPayService ?? AfriPayService();

  @override
  Future<List<AfriPayMethodDto>> getPaymentMethods(String currency) =>
      afriPayService.fetchPaymentMethods(currency);

  @override
  AfriPayFeeDto getFeeBreakdown({required int tipAmount, required String currency}) {
    final gateway = AfriPayService.gatewayFee(tipAmount);
    final platform = AfriPayService.platformFee(tipAmount);
    return AfriPayFeeDto(
      tipAmount: tipAmount,
      gatewayFee: gateway,
      platformFee: platform,
      totalFee: gateway + platform,
      customerPays: tipAmount,
      waiterReceives: tipAmount - gateway - platform,
      currency: currency,
    );
  }

  @override
  Future<AfriPayCheckoutDto> initiateCheckout({
    required String tipId,
    required String waiterId,
    required String waiterName,
    required int tipAmount,
    required String currency,
  }) async {
    final fee = getFeeBreakdown(tipAmount: tipAmount, currency: currency);
    final clientToken = afriPayService.generateClientToken(tipId);

    await afriPayService.createPendingPayment(
      tipId: tipId,
      clientToken: clientToken,
      tipAmount: fee.waiterReceives,
      gatewayFeeAmount: fee.gatewayFee,
      platformFeeAmount: fee.platformFee,
      customerPaysAmount: fee.customerPays,
      currency: currency,
    );

    return AfriPayCheckoutDto(clientToken: clientToken, feeBreakdown: fee);
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
      afriPayService.initiateC2B(
        amount: amount,
        currency: currency,
        clientToken: clientToken,
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
      afriPayService.getOtp(phone: phone, paymentMethod: paymentMethod);

  @override
  Future<String> pollPaymentStatus(String clientToken) =>
      afriPayService.getPaymentStatus(clientToken);

  @override
  Future<Map<String, dynamic>?> getCompletedPayment(String clientToken) =>
      afriPayService.getCompletedPayment(clientToken);
}

// ── DTOs ──────────────────────────────────────────────────────────────────────
// AfriPayMethodDto is defined in ../models/afripay_method_dto.dart

class AfriPayFeeDto {
  final int tipAmount;
  final int gatewayFee;
  final int platformFee;
  final int totalFee;
  final int customerPays;
  final int waiterReceives;
  final String currency;

  const AfriPayFeeDto({
    required this.tipAmount,
    required this.gatewayFee,
    required this.platformFee,
    required this.totalFee,
    required this.customerPays,
    required this.waiterReceives,
    required this.currency,
  });
}

class AfriPayCheckoutDto {
  final String clientToken;
  final AfriPayFeeDto feeBreakdown;

  const AfriPayCheckoutDto({
    required this.clientToken,
    required this.feeBreakdown,
  });
}
