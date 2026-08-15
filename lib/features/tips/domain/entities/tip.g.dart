// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tip _$TipFromJson(Map<String, dynamic> json) => _Tip(
  id: json['id'] as String,
  waiterId: json['waiterId'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  status: $enumDecode(_$TipStatusEnumMap, json['status']),
  message: json['message'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  transactionReference: json['transactionReference'] as String?,
  paymentProvider: json['paymentProvider'] as String?,
  isAnonymous: json['isAnonymous'] as bool? ?? false,
  customerName: json['customerName'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TipToJson(_Tip instance) => <String, dynamic>{
  'id': instance.id,
  'waiterId': instance.waiterId,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': _$TipStatusEnumMap[instance.status]!,
  'message': instance.message,
  'rating': instance.rating,
  'transactionReference': instance.transactionReference,
  'paymentProvider': instance.paymentProvider,
  'isAnonymous': instance.isAnonymous,
  'customerName': instance.customerName,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$TipStatusEnumMap = {
  TipStatus.pending: 'pending',
  TipStatus.processing: 'processing',
  TipStatus.completed: 'completed',
  TipStatus.failed: 'failed',
  TipStatus.refunded: 'refunded',
  TipStatus.cancelled: 'cancelled',
};

_TipStats _$TipStatsFromJson(Map<String, dynamic> json) => _TipStats(
  todayTotal: (json['todayTotal'] as num).toInt(),
  weekTotal: (json['weekTotal'] as num).toInt(),
  allTimeTotal: (json['allTimeTotal'] as num).toInt(),
  currency: json['currency'] as String,
  todayCount: (json['todayCount'] as num).toInt(),
  weekCount: (json['weekCount'] as num).toInt(),
  allTimeCount: (json['allTimeCount'] as num).toInt(),
);

Map<String, dynamic> _$TipStatsToJson(_TipStats instance) => <String, dynamic>{
  'todayTotal': instance.todayTotal,
  'weekTotal': instance.weekTotal,
  'allTimeTotal': instance.allTimeTotal,
  'currency': instance.currency,
  'todayCount': instance.todayCount,
  'weekCount': instance.weekCount,
  'allTimeCount': instance.allTimeCount,
};
