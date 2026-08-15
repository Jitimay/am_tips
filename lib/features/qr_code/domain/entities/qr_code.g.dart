// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QrCode _$QrCodeFromJson(Map<String, dynamic> json) => _QrCode(
  waiterId: json['waiterId'] as String,
  token: json['token'] as String,
  url: json['url'] as String,
  generatedAt: DateTime.parse(json['generatedAt'] as String),
  lastUsedAt: json['lastUsedAt'] == null
      ? null
      : DateTime.parse(json['lastUsedAt'] as String),
);

Map<String, dynamic> _$QrCodeToJson(_QrCode instance) => <String, dynamic>{
  'waiterId': instance.waiterId,
  'token': instance.token,
  'url': instance.url,
  'generatedAt': instance.generatedAt.toIso8601String(),
  'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
};
