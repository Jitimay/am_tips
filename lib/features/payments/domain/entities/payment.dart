import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

enum PaymentStatus { pending, processing, completed, failed, refunded, cancelled }

enum PaymentMethodType { mobileMoney, card, bank }

@freezed
abstract class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String tipId,
    required int amount,
    required String currency,
    required PaymentStatus status,
    required String provider,
    required PaymentMethodType methodType,
    String? providerReference,
    String? idempotencyKey,
    String? failureReason,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

@freezed
abstract class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String id,
    required String name,
    required String provider,
    required PaymentMethodType type,
    required bool isAvailable,
    String? logoUrl,
    String? description,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}

@freezed
abstract class PaymentResult with _$PaymentResult {
  const factory PaymentResult({
    required String paymentId,
    required PaymentStatus status,
    String? redirectUrl,
    String? ussdCode,
    String? providerReference,
    String? message,
  }) = _PaymentResult;

  factory PaymentResult.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultFromJson(json);
}

/// Fee breakdown shown to customer before paying.
@freezed
abstract class TipFeeBreakdown with _$TipFeeBreakdown {
  const factory TipFeeBreakdown({
    required int tipAmount,
    required int platformFee,
    required int waiterReceives,
    required String currency,
    @Default(false) bool isFeeWaivedForCustomer,
  }) = _TipFeeBreakdown;

  factory TipFeeBreakdown.fromJson(Map<String, dynamic> json) =>
      _$TipFeeBreakdownFromJson(json);
}
