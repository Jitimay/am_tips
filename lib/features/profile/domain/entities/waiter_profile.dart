import 'package:freezed_annotation/freezed_annotation.dart';

part 'waiter_profile.freezed.dart';
part 'waiter_profile.g.dart';

@freezed
abstract class WaiterProfile with _$WaiterProfile {
  const factory WaiterProfile({
    required String id,
    required String userId,
    required String fullName,
    String? avatarUrl,
    required String restaurantName,
    required String city,
    required String country,
    String? personalMessage,
    @Default(0.0) double averageRating,
    @Default(0) int totalRatings,
    required String qrToken,
    @Default([]) List<String> professions,
    @Default(true) bool isActive,
    PaymentAccountInfo? connectedPaymentAccount,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _WaiterProfile;

  factory WaiterProfile.fromJson(Map<String, dynamic> json) =>
      _$WaiterProfileFromJson(json);
}

@freezed
abstract class PaymentAccountInfo with _$PaymentAccountInfo {
  const factory PaymentAccountInfo({
    required String id,
    required String type,   // 'mobile_money' | 'bank' | 'card'
    required String provider,
    required String accountIdentifier,  // phone or masked account number
    @Default(true) bool isActive,
  }) = _PaymentAccountInfo;

  factory PaymentAccountInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentAccountInfoFromJson(json);
}

/// Public-facing profile — safe to expose to customers.
@freezed
abstract class PublicWaiterProfile with _$PublicWaiterProfile {
  const factory PublicWaiterProfile({
    required String id,
    required String fullName,
    String? avatarUrl,
    /// Generic workplace/venue name — e.g. restaurant, club, channel.
    /// Empty string means the person works independently.
    @Default('') String restaurantName,
    required String city,
    required String country,
    String? personalMessage,
    required double averageRating,
    required int totalRatings,
    /// The professions/roles this person does, e.g. ["🎵 Musician / Singer"].
    @Default([]) List<String> professions,
  }) = _PublicWaiterProfile;

  factory PublicWaiterProfile.fromJson(Map<String, dynamic> json) =>
      _$PublicWaiterProfileFromJson(json);
}
