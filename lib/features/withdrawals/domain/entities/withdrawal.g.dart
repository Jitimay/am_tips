// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Withdrawal _$WithdrawalFromJson(Map<String, dynamic> json) => _Withdrawal(
  id: json['id'] as String,
  waiterId: json['waiterId'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  status: $enumDecode(_$WithdrawalStatusEnumMap, json['status']),
  paymentAccountId: json['paymentAccountId'] as String,
  providerReference: json['providerReference'] as String?,
  failureReason: json['failureReason'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$WithdrawalToJson(_Withdrawal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'waiterId': instance.waiterId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$WithdrawalStatusEnumMap[instance.status]!,
      'paymentAccountId': instance.paymentAccountId,
      'providerReference': instance.providerReference,
      'failureReason': instance.failureReason,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$WithdrawalStatusEnumMap = {
  WithdrawalStatus.requested: 'requested',
  WithdrawalStatus.processing: 'processing',
  WithdrawalStatus.completed: 'completed',
  WithdrawalStatus.failed: 'failed',
  WithdrawalStatus.cancelled: 'cancelled',
};
