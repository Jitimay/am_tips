// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TipModel _$TipModelFromJson(Map<String, dynamic> json) => _TipModel(
  id: json['id'] as String,
  waiterId: json['waiter_id'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  status: json['status'] as String,
  message: json['message'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  transactionReference: json['transaction_reference'] as String?,
  paymentProvider: json['payment_provider'] as String?,
  isAnonymous: json['is_anonymous'] as bool? ?? false,
  customerName: json['customer_name'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TipModelToJson(_TipModel instance) => <String, dynamic>{
  'id': instance.id,
  'waiter_id': instance.waiterId,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': instance.status,
  'message': instance.message,
  'rating': instance.rating,
  'transaction_reference': instance.transactionReference,
  'payment_provider': instance.paymentProvider,
  'is_anonymous': instance.isAnonymous,
  'customer_name': instance.customerName,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

_TipStatsModel _$TipStatsModelFromJson(Map<String, dynamic> json) =>
    _TipStatsModel(
      todayTotal: (json['today_total'] as num).toInt(),
      weekTotal: (json['week_total'] as num).toInt(),
      allTimeTotal: (json['all_time_total'] as num).toInt(),
      currency: json['currency'] as String,
      todayCount: (json['today_count'] as num).toInt(),
      weekCount: (json['week_count'] as num).toInt(),
      allTimeCount: (json['all_time_count'] as num).toInt(),
    );

Map<String, dynamic> _$TipStatsModelToJson(_TipStatsModel instance) =>
    <String, dynamic>{
      'today_total': instance.todayTotal,
      'week_total': instance.weekTotal,
      'all_time_total': instance.allTimeTotal,
      'currency': instance.currency,
      'today_count': instance.todayCount,
      'week_count': instance.weekCount,
      'all_time_count': instance.allTimeCount,
    };
