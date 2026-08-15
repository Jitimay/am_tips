// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WithdrawalModel _$WithdrawalModelFromJson(Map<String, dynamic> json) =>
    _WithdrawalModel(
      id: json['id'] as String,
      waiterId: json['waiter_id'] as String,
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      paymentAccountId: json['payment_account_id'] as String,
      providerReference: json['provider_reference'] as String?,
      failureReason: json['failure_reason'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$WithdrawalModelToJson(_WithdrawalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'waiter_id': instance.waiterId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'payment_account_id': instance.paymentAccountId,
      'provider_reference': instance.providerReference,
      'failure_reason': instance.failureReason,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
