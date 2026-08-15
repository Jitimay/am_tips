// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletModel _$WalletModelFromJson(Map<String, dynamic> json) => _WalletModel(
  waiterId: json['waiter_id'] as String,
  availableBalance: (json['available_balance'] as num).toInt(),
  pendingBalance: (json['pending_balance'] as num?)?.toInt() ?? 0,
  currency: json['currency'] as String,
  lastUpdatedAt: json['last_updated_at'] == null
      ? null
      : DateTime.parse(json['last_updated_at'] as String),
);

Map<String, dynamic> _$WalletModelToJson(_WalletModel instance) =>
    <String, dynamic>{
      'waiter_id': instance.waiterId,
      'available_balance': instance.availableBalance,
      'pending_balance': instance.pendingBalance,
      'currency': instance.currency,
      'last_updated_at': instance.lastUpdatedAt?.toIso8601String(),
    };

_WalletTransactionModel _$WalletTransactionModelFromJson(
  Map<String, dynamic> json,
) => _WalletTransactionModel(
  id: json['id'] as String,
  type: json['type'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  isCredit: json['is_credit'] as bool,
  reference: json['reference'] as String?,
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$WalletTransactionModelToJson(
  _WalletTransactionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'amount': instance.amount,
  'currency': instance.currency,
  'is_credit': instance.isCredit,
  'reference': instance.reference,
  'description': instance.description,
  'created_at': instance.createdAt.toIso8601String(),
};
