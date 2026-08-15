// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QrCodeModel _$QrCodeModelFromJson(Map<String, dynamic> json) => _QrCodeModel(
  waiterId: json['waiter_id'] as String,
  token: json['token'] as String,
  url: json['url'] as String,
  generatedAt: DateTime.parse(json['generated_at'] as String),
  lastUsedAt: json['last_used_at'] == null
      ? null
      : DateTime.parse(json['last_used_at'] as String),
);

Map<String, dynamic> _$QrCodeModelToJson(_QrCodeModel instance) =>
    <String, dynamic>{
      'waiter_id': instance.waiterId,
      'token': instance.token,
      'url': instance.url,
      'generated_at': instance.generatedAt.toIso8601String(),
      'last_used_at': instance.lastUsedAt?.toIso8601String(),
    };
