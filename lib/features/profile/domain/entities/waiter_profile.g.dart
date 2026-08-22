// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiter_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaiterProfile _$WaiterProfileFromJson(Map<String, dynamic> json) =>
    _WaiterProfile(
      id: json['id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      restaurantName: json['restaurantName'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      personalMessage: json['personalMessage'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
      qrToken: json['qrToken'] as String,
      professions:
          (json['professions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      connectedPaymentAccount: json['connectedPaymentAccount'] == null
          ? null
          : PaymentAccountInfo.fromJson(
              json['connectedPaymentAccount'] as Map<String, dynamic>,
            ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$WaiterProfileToJson(_WaiterProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'avatarUrl': instance.avatarUrl,
      'restaurantName': instance.restaurantName,
      'city': instance.city,
      'country': instance.country,
      'personalMessage': instance.personalMessage,
      'averageRating': instance.averageRating,
      'totalRatings': instance.totalRatings,
      'qrToken': instance.qrToken,
      'professions': instance.professions,
      'isActive': instance.isActive,
      'connectedPaymentAccount': instance.connectedPaymentAccount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_PaymentAccountInfo _$PaymentAccountInfoFromJson(Map<String, dynamic> json) =>
    _PaymentAccountInfo(
      id: json['id'] as String,
      type: json['type'] as String,
      provider: json['provider'] as String,
      accountIdentifier: json['accountIdentifier'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$PaymentAccountInfoToJson(_PaymentAccountInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'provider': instance.provider,
      'accountIdentifier': instance.accountIdentifier,
      'isActive': instance.isActive,
    };

_PublicWaiterProfile _$PublicWaiterProfileFromJson(Map<String, dynamic> json) =>
    _PublicWaiterProfile(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      restaurantName: json['restaurantName'] as String? ?? '',
      city: json['city'] as String,
      country: json['country'] as String,
      personalMessage: json['personalMessage'] as String?,
      averageRating: (json['averageRating'] as num).toDouble(),
      totalRatings: (json['totalRatings'] as num).toInt(),
      professions:
          (json['professions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PublicWaiterProfileToJson(
  _PublicWaiterProfile instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'restaurantName': instance.restaurantName,
  'city': instance.city,
  'country': instance.country,
  'personalMessage': instance.personalMessage,
  'averageRating': instance.averageRating,
  'totalRatings': instance.totalRatings,
  'professions': instance.professions,
};
