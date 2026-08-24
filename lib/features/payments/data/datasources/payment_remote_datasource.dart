import '../../../../core/constants/app_constants.dart';
import '../services/afripay_service.dart';

/// Available payment methods on AfriPay for Burundi.
/// These are static — AfriPay does not expose a dynamic methods endpoint.
const List<Map<String, dynamic>> kAfriPayMethods = [
  {
    'id': 'lumicash',
    'name': 'LumiCash',
    'provider': 'afripay',
    'type': 'mobile_money',
    'description': 'Pay with your LumiCash mobile wallet',
    'is_available': true,
    'emoji': '📱',
  },
  {
    'id': 'bancobu_enoti',
    'name': 'BANCOBU eNoti',
    'provider': 'afripay',
    'type': 'mobile_money',
    'description': 'Pay via BANCOBU eNoti mobile banking',
    'is_available': true,
    'emoji': '🏦',
  },
];

abstract class PaymentRemoteDataSource {
  /// Returns the hardcoded AfriPay payment methods (LumiCash + BANCOBU eNoti).
  List<AfriPayMethodDto> getPaymentMethods();

  /// Calculates fee breakdown for the given tip amount.
  AfriPayFeeDto getFeeBreakdown({required int tipAmount, required String currency});

  /// Creates a pending payment record in Supabase and launches AfriPay checkout.
  /// Returns a [AfriPayCheckoutDto] containing the clientToken for polling.
  Future<AfriPayCheckoutDto> initiateCheckout({
    required String tipId,
    required String waiterId,
    required String waiterName,
    required int tipAmount,
    required String currency,
  });

  /// Polls Supabase for payment status by [clientToken].
  /// Returns 'pending' | 'completed' | 'failed'.
  Future<String> pollPaymentStatus(String clientToken);

  /// Fetches the full completed payment row (used to build success screen).
  Future<Map<String, dynamic>?> getCompletedPayment(String clientToken);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final AfriPayService afriPayService;

  PaymentRemoteDataSourceImpl({
    AfriPayService? afriPayService,
  })  : afriPayService = afriPayService ?? AfriPayService();

  @override
  List<AfriPayMethodDto> getPaymentMethods() {
    return kAfriPayMethods
        .map((m) => AfriPayMethodDto.fromMap(m))
        .toList();
  }

  @override
  AfriPayFeeDto getFeeBreakdown({
    required int tipAmount,
    required String currency,
  }) {
    final gateway = AfriPayService.gatewayFee(tipAmount);
    final platform = (tipAmount * AppConstants.amTipsPlatformFeePercent).ceil();
    return AfriPayFeeDto(
      tipAmount: tipAmount,
      gatewayFee: gateway,
      platformFee: platform,
      totalFee: gateway + platform,
      customerPays: tipAmount + gateway + platform,
      waiterReceives: tipAmount - platform, // waiter loses only amTips cut, not gateway
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

    // 1. Insert pending payment row into Supabase
    await afriPayService.createPendingPayment(
      tipId: tipId,
      clientToken: clientToken,
      tipAmount: tipAmount,
      gatewayFeeAmount: fee.gatewayFee,
      customerPaysAmount: fee.customerPays,
      currency: currency,
    );

    // 2. Launch AfriPay checkout in system browser
    await afriPayService.launchCheckout(
      amount: fee.customerPays,
      currency: currency,
      clientToken: clientToken,
      comment: 'Tip for $waiterName — amTips',
    );

    return AfriPayCheckoutDto(
      clientToken: clientToken,
      feeBreakdown: fee,
    );
  }

  @override
  Future<String> pollPaymentStatus(String clientToken) {
    return afriPayService.getPaymentStatus(clientToken);
  }

  @override
  Future<Map<String, dynamic>?> getCompletedPayment(String clientToken) {
    return afriPayService.getCompletedPayment(clientToken);
  }
}

// ── DTOs ──────────────────────────────────────────────────────────────────────

class AfriPayMethodDto {
  final String id;
  final String name;
  final String provider;
  final String type;
  final String description;
  final bool isAvailable;
  final String emoji;

  const AfriPayMethodDto({
    required this.id,
    required this.name,
    required this.provider,
    required this.type,
    required this.description,
    required this.isAvailable,
    required this.emoji,
  });

  factory AfriPayMethodDto.fromMap(Map<String, dynamic> m) => AfriPayMethodDto(
        id: m['id'] as String,
        name: m['name'] as String,
        provider: m['provider'] as String,
        type: m['type'] as String,
        description: m['description'] as String,
        isAvailable: m['is_available'] as bool,
        emoji: m['emoji'] as String,
      );
}

class AfriPayFeeDto {
  final int tipAmount;
  final int gatewayFee;    // AfriPay 4%
  final int platformFee;   // amTips cut (default 0%)
  final int totalFee;
  final int customerPays;  // tipAmount + totalFee
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
