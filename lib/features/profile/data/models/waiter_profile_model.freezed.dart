// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waiter_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaiterProfileModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'restaurant_name') String get restaurantName; String get city; String get country;@JsonKey(name: 'personal_message') String? get personalMessage;@JsonKey(name: 'average_rating') double get averageRating;@JsonKey(name: 'total_ratings') int get totalRatings;@JsonKey(name: 'qr_token') String get qrToken;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'connected_payment_account') PaymentAccountModel? get connectedPaymentAccount;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of WaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaiterProfileModelCopyWith<WaiterProfileModel> get copyWith => _$WaiterProfileModelCopyWithImpl<WaiterProfileModel>(this as WaiterProfileModel, _$identity);

  /// Serializes this WaiterProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaiterProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.qrToken, qrToken) || other.qrToken == qrToken)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.connectedPaymentAccount, connectedPaymentAccount) || other.connectedPaymentAccount == connectedPaymentAccount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings,qrToken,isActive,connectedPaymentAccount,createdAt,updatedAt);

@override
String toString() {
  return 'WaiterProfileModel(id: $id, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings, qrToken: $qrToken, isActive: $isActive, connectedPaymentAccount: $connectedPaymentAccount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WaiterProfileModelCopyWith<$Res>  {
  factory $WaiterProfileModelCopyWith(WaiterProfileModel value, $Res Function(WaiterProfileModel) _then) = _$WaiterProfileModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'restaurant_name') String restaurantName, String city, String country,@JsonKey(name: 'personal_message') String? personalMessage,@JsonKey(name: 'average_rating') double averageRating,@JsonKey(name: 'total_ratings') int totalRatings,@JsonKey(name: 'qr_token') String qrToken,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'connected_payment_account') PaymentAccountModel? connectedPaymentAccount,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


$PaymentAccountModelCopyWith<$Res>? get connectedPaymentAccount;

}
/// @nodoc
class _$WaiterProfileModelCopyWithImpl<$Res>
    implements $WaiterProfileModelCopyWith<$Res> {
  _$WaiterProfileModelCopyWithImpl(this._self, this._then);

  final WaiterProfileModel _self;
  final $Res Function(WaiterProfileModel) _then;

/// Create a copy of WaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? restaurantName = null,Object? city = null,Object? country = null,Object? personalMessage = freezed,Object? averageRating = null,Object? totalRatings = null,Object? qrToken = null,Object? isActive = null,Object? connectedPaymentAccount = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,personalMessage: freezed == personalMessage ? _self.personalMessage : personalMessage // ignore: cast_nullable_to_non_nullable
as String?,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,qrToken: null == qrToken ? _self.qrToken : qrToken // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,connectedPaymentAccount: freezed == connectedPaymentAccount ? _self.connectedPaymentAccount : connectedPaymentAccount // ignore: cast_nullable_to_non_nullable
as PaymentAccountModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of WaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentAccountModelCopyWith<$Res>? get connectedPaymentAccount {
    if (_self.connectedPaymentAccount == null) {
    return null;
  }

  return $PaymentAccountModelCopyWith<$Res>(_self.connectedPaymentAccount!, (value) {
    return _then(_self.copyWith(connectedPaymentAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [WaiterProfileModel].
extension WaiterProfileModelPatterns on WaiterProfileModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaiterProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaiterProfileModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaiterProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _WaiterProfileModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaiterProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _WaiterProfileModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'restaurant_name')  String restaurantName,  String city,  String country, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'average_rating')  double averageRating, @JsonKey(name: 'total_ratings')  int totalRatings, @JsonKey(name: 'qr_token')  String qrToken, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'connected_payment_account')  PaymentAccountModel? connectedPaymentAccount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaiterProfileModel() when $default != null:
return $default(_that.id,_that.userId,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings,_that.qrToken,_that.isActive,_that.connectedPaymentAccount,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'restaurant_name')  String restaurantName,  String city,  String country, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'average_rating')  double averageRating, @JsonKey(name: 'total_ratings')  int totalRatings, @JsonKey(name: 'qr_token')  String qrToken, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'connected_payment_account')  PaymentAccountModel? connectedPaymentAccount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WaiterProfileModel():
return $default(_that.id,_that.userId,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings,_that.qrToken,_that.isActive,_that.connectedPaymentAccount,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'restaurant_name')  String restaurantName,  String city,  String country, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'average_rating')  double averageRating, @JsonKey(name: 'total_ratings')  int totalRatings, @JsonKey(name: 'qr_token')  String qrToken, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'connected_payment_account')  PaymentAccountModel? connectedPaymentAccount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WaiterProfileModel() when $default != null:
return $default(_that.id,_that.userId,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings,_that.qrToken,_that.isActive,_that.connectedPaymentAccount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaiterProfileModel implements WaiterProfileModel {
  const _WaiterProfileModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'full_name') this.fullName = '', @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'restaurant_name') this.restaurantName = '', this.city = '', this.country = '', @JsonKey(name: 'personal_message') this.personalMessage, @JsonKey(name: 'average_rating') this.averageRating = 0.0, @JsonKey(name: 'total_ratings') this.totalRatings = 0, @JsonKey(name: 'qr_token') this.qrToken = '', @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'connected_payment_account') this.connectedPaymentAccount, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _WaiterProfileModel.fromJson(Map<String, dynamic> json) => _$WaiterProfileModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'restaurant_name') final  String restaurantName;
@override@JsonKey() final  String city;
@override@JsonKey() final  String country;
@override@JsonKey(name: 'personal_message') final  String? personalMessage;
@override@JsonKey(name: 'average_rating') final  double averageRating;
@override@JsonKey(name: 'total_ratings') final  int totalRatings;
@override@JsonKey(name: 'qr_token') final  String qrToken;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'connected_payment_account') final  PaymentAccountModel? connectedPaymentAccount;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of WaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaiterProfileModelCopyWith<_WaiterProfileModel> get copyWith => __$WaiterProfileModelCopyWithImpl<_WaiterProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaiterProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaiterProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.qrToken, qrToken) || other.qrToken == qrToken)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.connectedPaymentAccount, connectedPaymentAccount) || other.connectedPaymentAccount == connectedPaymentAccount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings,qrToken,isActive,connectedPaymentAccount,createdAt,updatedAt);

@override
String toString() {
  return 'WaiterProfileModel(id: $id, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings, qrToken: $qrToken, isActive: $isActive, connectedPaymentAccount: $connectedPaymentAccount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WaiterProfileModelCopyWith<$Res> implements $WaiterProfileModelCopyWith<$Res> {
  factory _$WaiterProfileModelCopyWith(_WaiterProfileModel value, $Res Function(_WaiterProfileModel) _then) = __$WaiterProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'restaurant_name') String restaurantName, String city, String country,@JsonKey(name: 'personal_message') String? personalMessage,@JsonKey(name: 'average_rating') double averageRating,@JsonKey(name: 'total_ratings') int totalRatings,@JsonKey(name: 'qr_token') String qrToken,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'connected_payment_account') PaymentAccountModel? connectedPaymentAccount,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});


@override $PaymentAccountModelCopyWith<$Res>? get connectedPaymentAccount;

}
/// @nodoc
class __$WaiterProfileModelCopyWithImpl<$Res>
    implements _$WaiterProfileModelCopyWith<$Res> {
  __$WaiterProfileModelCopyWithImpl(this._self, this._then);

  final _WaiterProfileModel _self;
  final $Res Function(_WaiterProfileModel) _then;

/// Create a copy of WaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? restaurantName = null,Object? city = null,Object? country = null,Object? personalMessage = freezed,Object? averageRating = null,Object? totalRatings = null,Object? qrToken = null,Object? isActive = null,Object? connectedPaymentAccount = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_WaiterProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,personalMessage: freezed == personalMessage ? _self.personalMessage : personalMessage // ignore: cast_nullable_to_non_nullable
as String?,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,qrToken: null == qrToken ? _self.qrToken : qrToken // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,connectedPaymentAccount: freezed == connectedPaymentAccount ? _self.connectedPaymentAccount : connectedPaymentAccount // ignore: cast_nullable_to_non_nullable
as PaymentAccountModel?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of WaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentAccountModelCopyWith<$Res>? get connectedPaymentAccount {
    if (_self.connectedPaymentAccount == null) {
    return null;
  }

  return $PaymentAccountModelCopyWith<$Res>(_self.connectedPaymentAccount!, (value) {
    return _then(_self.copyWith(connectedPaymentAccount: value));
  });
}
}


/// @nodoc
mixin _$PaymentAccountModel {

 String get id; String get type; String get provider;@JsonKey(name: 'account_identifier') String get accountIdentifier;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of PaymentAccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentAccountModelCopyWith<PaymentAccountModel> get copyWith => _$PaymentAccountModelCopyWithImpl<PaymentAccountModel>(this as PaymentAccountModel, _$identity);

  /// Serializes this PaymentAccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentAccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,provider,accountIdentifier,isActive);

@override
String toString() {
  return 'PaymentAccountModel(id: $id, type: $type, provider: $provider, accountIdentifier: $accountIdentifier, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $PaymentAccountModelCopyWith<$Res>  {
  factory $PaymentAccountModelCopyWith(PaymentAccountModel value, $Res Function(PaymentAccountModel) _then) = _$PaymentAccountModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String provider,@JsonKey(name: 'account_identifier') String accountIdentifier,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$PaymentAccountModelCopyWithImpl<$Res>
    implements $PaymentAccountModelCopyWith<$Res> {
  _$PaymentAccountModelCopyWithImpl(this._self, this._then);

  final PaymentAccountModel _self;
  final $Res Function(PaymentAccountModel) _then;

/// Create a copy of PaymentAccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? provider = null,Object? accountIdentifier = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,accountIdentifier: null == accountIdentifier ? _self.accountIdentifier : accountIdentifier // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentAccountModel].
extension PaymentAccountModelPatterns on PaymentAccountModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentAccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentAccountModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentAccountModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentAccountModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentAccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentAccountModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String provider, @JsonKey(name: 'account_identifier')  String accountIdentifier, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentAccountModel() when $default != null:
return $default(_that.id,_that.type,_that.provider,_that.accountIdentifier,_that.isActive);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String provider, @JsonKey(name: 'account_identifier')  String accountIdentifier, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _PaymentAccountModel():
return $default(_that.id,_that.type,_that.provider,_that.accountIdentifier,_that.isActive);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String provider, @JsonKey(name: 'account_identifier')  String accountIdentifier, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _PaymentAccountModel() when $default != null:
return $default(_that.id,_that.type,_that.provider,_that.accountIdentifier,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentAccountModel implements PaymentAccountModel {
  const _PaymentAccountModel({required this.id, required this.type, required this.provider, @JsonKey(name: 'account_identifier') required this.accountIdentifier, @JsonKey(name: 'is_active') this.isActive = true});
  factory _PaymentAccountModel.fromJson(Map<String, dynamic> json) => _$PaymentAccountModelFromJson(json);

@override final  String id;
@override final  String type;
@override final  String provider;
@override@JsonKey(name: 'account_identifier') final  String accountIdentifier;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of PaymentAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentAccountModelCopyWith<_PaymentAccountModel> get copyWith => __$PaymentAccountModelCopyWithImpl<_PaymentAccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentAccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentAccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,provider,accountIdentifier,isActive);

@override
String toString() {
  return 'PaymentAccountModel(id: $id, type: $type, provider: $provider, accountIdentifier: $accountIdentifier, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$PaymentAccountModelCopyWith<$Res> implements $PaymentAccountModelCopyWith<$Res> {
  factory _$PaymentAccountModelCopyWith(_PaymentAccountModel value, $Res Function(_PaymentAccountModel) _then) = __$PaymentAccountModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String provider,@JsonKey(name: 'account_identifier') String accountIdentifier,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$PaymentAccountModelCopyWithImpl<$Res>
    implements _$PaymentAccountModelCopyWith<$Res> {
  __$PaymentAccountModelCopyWithImpl(this._self, this._then);

  final _PaymentAccountModel _self;
  final $Res Function(_PaymentAccountModel) _then;

/// Create a copy of PaymentAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? provider = null,Object? accountIdentifier = null,Object? isActive = null,}) {
  return _then(_PaymentAccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,accountIdentifier: null == accountIdentifier ? _self.accountIdentifier : accountIdentifier // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PublicWaiterProfileModel {

 String get id;@JsonKey(name: 'full_name') String get fullName;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'restaurant_name') String get restaurantName; String get city; String get country;@JsonKey(name: 'personal_message') String? get personalMessage;@JsonKey(name: 'average_rating') double get averageRating;@JsonKey(name: 'total_ratings') int get totalRatings;
/// Create a copy of PublicWaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicWaiterProfileModelCopyWith<PublicWaiterProfileModel> get copyWith => _$PublicWaiterProfileModelCopyWithImpl<PublicWaiterProfileModel>(this as PublicWaiterProfileModel, _$identity);

  /// Serializes this PublicWaiterProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicWaiterProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings);

@override
String toString() {
  return 'PublicWaiterProfileModel(id: $id, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings)';
}


}

/// @nodoc
abstract mixin class $PublicWaiterProfileModelCopyWith<$Res>  {
  factory $PublicWaiterProfileModelCopyWith(PublicWaiterProfileModel value, $Res Function(PublicWaiterProfileModel) _then) = _$PublicWaiterProfileModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'restaurant_name') String restaurantName, String city, String country,@JsonKey(name: 'personal_message') String? personalMessage,@JsonKey(name: 'average_rating') double averageRating,@JsonKey(name: 'total_ratings') int totalRatings
});




}
/// @nodoc
class _$PublicWaiterProfileModelCopyWithImpl<$Res>
    implements $PublicWaiterProfileModelCopyWith<$Res> {
  _$PublicWaiterProfileModelCopyWithImpl(this._self, this._then);

  final PublicWaiterProfileModel _self;
  final $Res Function(PublicWaiterProfileModel) _then;

/// Create a copy of PublicWaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? avatarUrl = freezed,Object? restaurantName = null,Object? city = null,Object? country = null,Object? personalMessage = freezed,Object? averageRating = null,Object? totalRatings = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,personalMessage: freezed == personalMessage ? _self.personalMessage : personalMessage // ignore: cast_nullable_to_non_nullable
as String?,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicWaiterProfileModel].
extension PublicWaiterProfileModelPatterns on PublicWaiterProfileModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicWaiterProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicWaiterProfileModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicWaiterProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _PublicWaiterProfileModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicWaiterProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _PublicWaiterProfileModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'restaurant_name')  String restaurantName,  String city,  String country, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'average_rating')  double averageRating, @JsonKey(name: 'total_ratings')  int totalRatings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicWaiterProfileModel() when $default != null:
return $default(_that.id,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'restaurant_name')  String restaurantName,  String city,  String country, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'average_rating')  double averageRating, @JsonKey(name: 'total_ratings')  int totalRatings)  $default,) {final _that = this;
switch (_that) {
case _PublicWaiterProfileModel():
return $default(_that.id,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'full_name')  String fullName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'restaurant_name')  String restaurantName,  String city,  String country, @JsonKey(name: 'personal_message')  String? personalMessage, @JsonKey(name: 'average_rating')  double averageRating, @JsonKey(name: 'total_ratings')  int totalRatings)?  $default,) {final _that = this;
switch (_that) {
case _PublicWaiterProfileModel() when $default != null:
return $default(_that.id,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicWaiterProfileModel implements PublicWaiterProfileModel {
  const _PublicWaiterProfileModel({required this.id, @JsonKey(name: 'full_name') required this.fullName, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'restaurant_name') required this.restaurantName, required this.city, required this.country, @JsonKey(name: 'personal_message') this.personalMessage, @JsonKey(name: 'average_rating') this.averageRating = 0.0, @JsonKey(name: 'total_ratings') this.totalRatings = 0});
  factory _PublicWaiterProfileModel.fromJson(Map<String, dynamic> json) => _$PublicWaiterProfileModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'full_name') final  String fullName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'restaurant_name') final  String restaurantName;
@override final  String city;
@override final  String country;
@override@JsonKey(name: 'personal_message') final  String? personalMessage;
@override@JsonKey(name: 'average_rating') final  double averageRating;
@override@JsonKey(name: 'total_ratings') final  int totalRatings;

/// Create a copy of PublicWaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicWaiterProfileModelCopyWith<_PublicWaiterProfileModel> get copyWith => __$PublicWaiterProfileModelCopyWithImpl<_PublicWaiterProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicWaiterProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicWaiterProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings);

@override
String toString() {
  return 'PublicWaiterProfileModel(id: $id, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings)';
}


}

/// @nodoc
abstract mixin class _$PublicWaiterProfileModelCopyWith<$Res> implements $PublicWaiterProfileModelCopyWith<$Res> {
  factory _$PublicWaiterProfileModelCopyWith(_PublicWaiterProfileModel value, $Res Function(_PublicWaiterProfileModel) _then) = __$PublicWaiterProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'full_name') String fullName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'restaurant_name') String restaurantName, String city, String country,@JsonKey(name: 'personal_message') String? personalMessage,@JsonKey(name: 'average_rating') double averageRating,@JsonKey(name: 'total_ratings') int totalRatings
});




}
/// @nodoc
class __$PublicWaiterProfileModelCopyWithImpl<$Res>
    implements _$PublicWaiterProfileModelCopyWith<$Res> {
  __$PublicWaiterProfileModelCopyWithImpl(this._self, this._then);

  final _PublicWaiterProfileModel _self;
  final $Res Function(_PublicWaiterProfileModel) _then;

/// Create a copy of PublicWaiterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? avatarUrl = freezed,Object? restaurantName = null,Object? city = null,Object? country = null,Object? personalMessage = freezed,Object? averageRating = null,Object? totalRatings = null,}) {
  return _then(_PublicWaiterProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,personalMessage: freezed == personalMessage ? _self.personalMessage : personalMessage // ignore: cast_nullable_to_non_nullable
as String?,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
