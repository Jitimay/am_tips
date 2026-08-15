// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: json['id'] as String,
  tipId: json['tipId'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
  provider: json['provider'] as String,
  methodType: $enumDecode(_$PaymentMethodTypeEnumMap, json['methodType']),
  providerReference: json['providerReference'] as String?,
  idempotencyKey: json['idempotencyKey'] as String?,
  failureReason: json['failureReason'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'tipId': instance.tipId,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'provider': instance.provider,
  'methodType': _$PaymentMethodTypeEnumMap[instance.methodType]!,
  'providerReference': instance.providerReference,
  'idempotencyKey': instance.idempotencyKey,
  'failureReason': instance.failureReason,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.cancelled: 'cancelled',
};

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.mobileMoney: 'mobileMoney',
  PaymentMethodType.card: 'card',
  PaymentMethodType.bank: 'bank',
};

_PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    _PaymentMethod(
      id: json['id'] as String,
      name: json['name'] as String,
      provider: json['provider'] as String,
      type: $enumDecode(_$PaymentMethodTypeEnumMap, json['type']),
      isAvailable: json['isAvailable'] as bool,
      logoUrl: json['logoUrl'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PaymentMethodToJson(_PaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'provider': instance.provider,
      'type': _$PaymentMethodTypeEnumMap[instance.type]!,
      'isAvailable': instance.isAvailable,
      'logoUrl': instance.logoUrl,
      'description': instance.description,
    };

_PaymentResult _$PaymentResultFromJson(Map<String, dynamic> json) =>
    _PaymentResult(
      paymentId: json['paymentId'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      redirectUrl: json['redirectUrl'] as String?,
      ussdCode: json['ussdCode'] as String?,
      providerReference: json['providerReference'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PaymentResultToJson(_PaymentResult instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'redirectUrl': instance.redirectUrl,
      'ussdCode': instance.ussdCode,
      'providerReference': instance.providerReference,
      'message': instance.message,
    };

_TipFeeBreakdown _$TipFeeBreakdownFromJson(Map<String, dynamic> json) =>
    _TipFeeBreakdown(
      tipAmount: (json['tipAmount'] as num).toInt(),
      platformFee: (json['platformFee'] as num).toInt(),
      waiterReceives: (json['waiterReceives'] as num).toInt(),
      currency: json['currency'] as String,
      isFeeWaivedForCustomer: json['isFeeWaivedForCustomer'] as bool? ?? false,
    );

Map<String, dynamic> _$TipFeeBreakdownToJson(_TipFeeBreakdown instance) =>
    <String, dynamic>{
      'tipAmount': instance.tipAmount,
      'platformFee': instance.platformFee,
      'waiterReceives': instance.waiterReceives,
      'currency': instance.currency,
      'isFeeWaivedForCustomer': instance.isFeeWaivedForCustomer,
    };
