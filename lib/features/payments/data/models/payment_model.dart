import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payment.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentMethodModel with _$PaymentMethodModel {
  const factory PaymentMethodModel({
    required String id,
    required String name,
    required String provider,
    required String type,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    @JsonKey(name: 'logo_url') String? logoUrl,
    String? description,
  }) = _PaymentMethodModel;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodModelFromJson(json);
}

@freezed
class PaymentResultModel with _$PaymentResultModel {
  const factory PaymentResultModel({
    @JsonKey(name: 'payment_id') required String paymentId,
    required String status,
    @JsonKey(name: 'redirect_url') String? redirectUrl,
    @JsonKey(name: 'ussd_code') String? ussdCode,
    @JsonKey(name: 'provider_reference') String? providerReference,
    String? message,
  }) = _PaymentResultModel;

  factory PaymentResultModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultModelFromJson(json);
}

@freezed
class TipFeeBreakdownModel with _$TipFeeBreakdownModel {
  const factory TipFeeBreakdownModel({
    @JsonKey(name: 'tip_amount') required int tipAmount,
    @JsonKey(name: 'platform_fee') required int platformFee,
    @JsonKey(name: 'waiter_receives') required int waiterReceives,
    required String currency,
    @JsonKey(name: 'is_fee_waived_for_customer')
    @Default(false)
    bool isFeeWaivedForCustomer,
  }) = _TipFeeBreakdownModel;

  factory TipFeeBreakdownModel.fromJson(Map<String, dynamic> json) =>
      _$TipFeeBreakdownModelFromJson(json);
}

extension PaymentMethodModelX on PaymentMethodModel {
  PaymentMethod toDomain() => PaymentMethod(
        id: id,
        name: name,
        provider: provider,
        type: _parseType(type),
        isAvailable: isAvailable,
        logoUrl: logoUrl,
        description: description,
      );

  static PaymentMethodType _parseType(String t) {
    switch (t.toLowerCase()) {
      case 'mobile_money':
        return PaymentMethodType.mobileMoney;
      case 'card':
        return PaymentMethodType.card;
      case 'bank':
        return PaymentMethodType.bank;
      default:
        return PaymentMethodType.mobileMoney;
    }
  }
}

extension PaymentResultModelX on PaymentResultModel {
  PaymentResult toDomain() => PaymentResult(
        paymentId: paymentId,
        status: _parseStatus(status),
        redirectUrl: redirectUrl,
        ussdCode: ussdCode,
        providerReference: providerReference,
        message: message,
      );

  static PaymentStatus _parseStatus(String s) {
    return PaymentStatus.values.firstWhere(
      (e) => e.name == s.toLowerCase(),
      orElse: () => PaymentStatus.pending,
    );
  }
}

extension TipFeeBreakdownModelX on TipFeeBreakdownModel {
  TipFeeBreakdown toDomain() => TipFeeBreakdown(
        tipAmount: tipAmount,
        platformFee: platformFee,
        waiterReceives: waiterReceives,
        currency: currency,
        isFeeWaivedForCustomer: isFeeWaivedForCustomer,
      );
}
