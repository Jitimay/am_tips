// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentMethodModel _$PaymentMethodModelFromJson(Map<String, dynamic> json) =>
    _PaymentMethodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      provider: json['provider'] as String,
      type: json['type'] as String,
      isAvailable: json['is_available'] as bool? ?? true,
      logoUrl: json['logo_url'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PaymentMethodModelToJson(_PaymentMethodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'provider': instance.provider,
      'type': instance.type,
      'is_available': instance.isAvailable,
      'logo_url': instance.logoUrl,
      'description': instance.description,
    };

_PaymentResultModel _$PaymentResultModelFromJson(Map<String, dynamic> json) =>
    _PaymentResultModel(
      paymentId: json['payment_id'] as String,
      status: json['status'] as String,
      redirectUrl: json['redirect_url'] as String?,
      ussdCode: json['ussd_code'] as String?,
      providerReference: json['provider_reference'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PaymentResultModelToJson(_PaymentResultModel instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'status': instance.status,
      'redirect_url': instance.redirectUrl,
      'ussd_code': instance.ussdCode,
      'provider_reference': instance.providerReference,
      'message': instance.message,
    };

_TipFeeBreakdownModel _$TipFeeBreakdownModelFromJson(
  Map<String, dynamic> json,
) => _TipFeeBreakdownModel(
  tipAmount: (json['tip_amount'] as num).toInt(),
  platformFee: (json['platform_fee'] as num).toInt(),
  waiterReceives: (json['waiter_receives'] as num).toInt(),
  currency: json['currency'] as String,
  isFeeWaivedForCustomer: json['is_fee_waived_for_customer'] as bool? ?? false,
);

Map<String, dynamic> _$TipFeeBreakdownModelToJson(
  _TipFeeBreakdownModel instance,
) => <String, dynamic>{
  'tip_amount': instance.tipAmount,
  'platform_fee': instance.platformFee,
  'waiter_receives': instance.waiterReceives,
  'currency': instance.currency,
  'is_fee_waived_for_customer': instance.isFeeWaivedForCustomer,
};
