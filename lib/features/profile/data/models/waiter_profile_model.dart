import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/waiter_profile.dart';

part 'waiter_profile_model.freezed.dart';
part 'waiter_profile_model.g.dart';

@freezed
class WaiterProfileModel with _$WaiterProfileModel {
  const factory WaiterProfileModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'restaurant_name') required String restaurantName,
    required String city,
    required String country,
    @JsonKey(name: 'personal_message') String? personalMessage,
    @JsonKey(name: 'average_rating') @Default(0.0) double averageRating,
    @JsonKey(name: 'total_ratings') @Default(0) int totalRatings,
    @JsonKey(name: 'qr_token') required String qrToken,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'connected_payment_account')
    PaymentAccountModel? connectedPaymentAccount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _WaiterProfileModel;

  factory WaiterProfileModel.fromJson(Map<String, dynamic> json) =>
      _$WaiterProfileModelFromJson(json);
}

@freezed
class PaymentAccountModel with _$PaymentAccountModel {
  const factory PaymentAccountModel({
    required String id,
    required String type,
    required String provider,
    @JsonKey(name: 'account_identifier') required String accountIdentifier,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _PaymentAccountModel;

  factory PaymentAccountModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentAccountModelFromJson(json);
}

@freezed
class PublicWaiterProfileModel with _$PublicWaiterProfileModel {
  const factory PublicWaiterProfileModel({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'restaurant_name') required String restaurantName,
    required String city,
    required String country,
    @JsonKey(name: 'personal_message') String? personalMessage,
    @JsonKey(name: 'average_rating') @Default(0.0) double averageRating,
    @JsonKey(name: 'total_ratings') @Default(0) int totalRatings,
  }) = _PublicWaiterProfileModel;

  factory PublicWaiterProfileModel.fromJson(Map<String, dynamic> json) =>
      _$PublicWaiterProfileModelFromJson(json);
}

extension WaiterProfileModelX on WaiterProfileModel {
  WaiterProfile toDomain() => WaiterProfile(
        id: id,
        userId: userId,
        fullName: fullName,
        avatarUrl: avatarUrl,
        restaurantName: restaurantName,
        city: city,
        country: country,
        personalMessage: personalMessage,
        averageRating: averageRating,
        totalRatings: totalRatings,
        qrToken: qrToken,
        isActive: isActive,
        connectedPaymentAccount: connectedPaymentAccount?.toDomain(),
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension PaymentAccountModelX on PaymentAccountModel {
  PaymentAccountInfo toDomain() => PaymentAccountInfo(
        id: id,
        type: type,
        provider: provider,
        accountIdentifier: accountIdentifier,
        isActive: isActive,
      );
}

extension PublicWaiterProfileModelX on PublicWaiterProfileModel {
  PublicWaiterProfile toDomain() => PublicWaiterProfile(
        id: id,
        fullName: fullName,
        avatarUrl: avatarUrl,
        restaurantName: restaurantName,
        city: city,
        country: country,
        personalMessage: personalMessage,
        averageRating: averageRating,
        totalRatings: totalRatings,
      );
}
