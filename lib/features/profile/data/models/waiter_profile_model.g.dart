// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiter_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaiterProfileModel _$WaiterProfileModelFromJson(Map<String, dynamic> json) =>
    _WaiterProfileModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      restaurantName: json['restaurant_name'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      personalMessage: json['personal_message'] as String?,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['total_ratings'] as num?)?.toInt() ?? 0,
      qrToken: json['qr_token'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      connectedPaymentAccount: json['connected_payment_account'] == null
          ? null
          : PaymentAccountModel.fromJson(
              json['connected_payment_account'] as Map<String, dynamic>,
            ),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$WaiterProfileModelToJson(_WaiterProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'avatar_url': instance.avatarUrl,
      'restaurant_name': instance.restaurantName,
      'city': instance.city,
      'country': instance.country,
      'personal_message': instance.personalMessage,
      'average_rating': instance.averageRating,
      'total_ratings': instance.totalRatings,
      'qr_token': instance.qrToken,
      'is_active': instance.isActive,
      'connected_payment_account': instance.connectedPaymentAccount,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_PaymentAccountModel _$PaymentAccountModelFromJson(Map<String, dynamic> json) =>
    _PaymentAccountModel(
      id: json['id'] as String,
      type: json['type'] as String,
      provider: json['provider'] as String,
      accountIdentifier: json['account_identifier'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$PaymentAccountModelToJson(
  _PaymentAccountModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'provider': instance.provider,
  'account_identifier': instance.accountIdentifier,
  'is_active': instance.isActive,
};

_PublicWaiterProfileModel _$PublicWaiterProfileModelFromJson(
  Map<String, dynamic> json,
) => _PublicWaiterProfileModel(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  avatarUrl: json['avatar_url'] as String?,
  restaurantName: json['restaurant_name'] as String,
  city: json['city'] as String,
  country: json['country'] as String,
  personalMessage: json['personal_message'] as String?,
  averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
  totalRatings: (json['total_ratings'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$PublicWaiterProfileModelToJson(
  _PublicWaiterProfileModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'avatar_url': instance.avatarUrl,
  'restaurant_name': instance.restaurantName,
  'city': instance.city,
  'country': instance.country,
  'personal_message': instance.personalMessage,
  'average_rating': instance.averageRating,
  'total_ratings': instance.totalRatings,
};
