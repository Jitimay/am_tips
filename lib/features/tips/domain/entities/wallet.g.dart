// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wallet _$WalletFromJson(Map<String, dynamic> json) => _Wallet(
  waiterId: json['waiterId'] as String,
  availableBalance: (json['availableBalance'] as num).toInt(),
  pendingBalance: (json['pendingBalance'] as num).toInt(),
  currency: json['currency'] as String,
  lastUpdatedAt: json['lastUpdatedAt'] == null
      ? null
      : DateTime.parse(json['lastUpdatedAt'] as String),
);

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
  'waiterId': instance.waiterId,
  'availableBalance': instance.availableBalance,
  'pendingBalance': instance.pendingBalance,
  'currency': instance.currency,
  'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
};

_WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) =>
    _WalletTransaction(
      id: json['id'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
      isCredit: json['isCredit'] as bool,
      reference: json['reference'] as String?,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$WalletTransactionToJson(_WalletTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'currency': instance.currency,
      'isCredit': instance.isCredit,
      'reference': instance.reference,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.tipReceived: 'tipReceived',
  TransactionType.withdrawal: 'withdrawal',
  TransactionType.refund: 'refund',
  TransactionType.adjustment: 'adjustment',
};
