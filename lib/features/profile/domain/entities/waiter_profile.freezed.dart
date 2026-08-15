// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waiter_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WaiterProfile {

 String get id; String get userId; String get fullName; String? get avatarUrl; String get restaurantName; String get city; String get country; String? get personalMessage; double get averageRating; int get totalRatings; String get qrToken; bool get isActive; PaymentAccountInfo? get connectedPaymentAccount; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of WaiterProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaiterProfileCopyWith<WaiterProfile> get copyWith => _$WaiterProfileCopyWithImpl<WaiterProfile>(this as WaiterProfile, _$identity);

  /// Serializes this WaiterProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaiterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.qrToken, qrToken) || other.qrToken == qrToken)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.connectedPaymentAccount, connectedPaymentAccount) || other.connectedPaymentAccount == connectedPaymentAccount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings,qrToken,isActive,connectedPaymentAccount,createdAt,updatedAt);

@override
String toString() {
  return 'WaiterProfile(id: $id, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings, qrToken: $qrToken, isActive: $isActive, connectedPaymentAccount: $connectedPaymentAccount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WaiterProfileCopyWith<$Res>  {
  factory $WaiterProfileCopyWith(WaiterProfile value, $Res Function(WaiterProfile) _then) = _$WaiterProfileCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String fullName, String? avatarUrl, String restaurantName, String city, String country, String? personalMessage, double averageRating, int totalRatings, String qrToken, bool isActive, PaymentAccountInfo? connectedPaymentAccount, DateTime createdAt, DateTime? updatedAt
});


$PaymentAccountInfoCopyWith<$Res>? get connectedPaymentAccount;

}
/// @nodoc
class _$WaiterProfileCopyWithImpl<$Res>
    implements $WaiterProfileCopyWith<$Res> {
  _$WaiterProfileCopyWithImpl(this._self, this._then);

  final WaiterProfile _self;
  final $Res Function(WaiterProfile) _then;

/// Create a copy of WaiterProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? restaurantName = null,Object? city = null,Object? country = null,Object? personalMessage = freezed,Object? averageRating = null,Object? totalRatings = null,Object? qrToken = null,Object? isActive = null,Object? connectedPaymentAccount = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
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
as PaymentAccountInfo?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of WaiterProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentAccountInfoCopyWith<$Res>? get connectedPaymentAccount {
    if (_self.connectedPaymentAccount == null) {
    return null;
  }

  return $PaymentAccountInfoCopyWith<$Res>(_self.connectedPaymentAccount!, (value) {
    return _then(_self.copyWith(connectedPaymentAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [WaiterProfile].
extension WaiterProfilePatterns on WaiterProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaiterProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaiterProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaiterProfile value)  $default,){
final _that = this;
switch (_that) {
case _WaiterProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaiterProfile value)?  $default,){
final _that = this;
switch (_that) {
case _WaiterProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String fullName,  String? avatarUrl,  String restaurantName,  String city,  String country,  String? personalMessage,  double averageRating,  int totalRatings,  String qrToken,  bool isActive,  PaymentAccountInfo? connectedPaymentAccount,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaiterProfile() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String fullName,  String? avatarUrl,  String restaurantName,  String city,  String country,  String? personalMessage,  double averageRating,  int totalRatings,  String qrToken,  bool isActive,  PaymentAccountInfo? connectedPaymentAccount,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WaiterProfile():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String fullName,  String? avatarUrl,  String restaurantName,  String city,  String country,  String? personalMessage,  double averageRating,  int totalRatings,  String qrToken,  bool isActive,  PaymentAccountInfo? connectedPaymentAccount,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WaiterProfile() when $default != null:
return $default(_that.id,_that.userId,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings,_that.qrToken,_that.isActive,_that.connectedPaymentAccount,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaiterProfile implements WaiterProfile {
  const _WaiterProfile({required this.id, required this.userId, required this.fullName, this.avatarUrl, required this.restaurantName, required this.city, required this.country, this.personalMessage, this.averageRating = 0.0, this.totalRatings = 0, required this.qrToken, this.isActive = true, this.connectedPaymentAccount, required this.createdAt, this.updatedAt});
  factory _WaiterProfile.fromJson(Map<String, dynamic> json) => _$WaiterProfileFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  String restaurantName;
@override final  String city;
@override final  String country;
@override final  String? personalMessage;
@override@JsonKey() final  double averageRating;
@override@JsonKey() final  int totalRatings;
@override final  String qrToken;
@override@JsonKey() final  bool isActive;
@override final  PaymentAccountInfo? connectedPaymentAccount;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of WaiterProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaiterProfileCopyWith<_WaiterProfile> get copyWith => __$WaiterProfileCopyWithImpl<_WaiterProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaiterProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaiterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.qrToken, qrToken) || other.qrToken == qrToken)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.connectedPaymentAccount, connectedPaymentAccount) || other.connectedPaymentAccount == connectedPaymentAccount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings,qrToken,isActive,connectedPaymentAccount,createdAt,updatedAt);

@override
String toString() {
  return 'WaiterProfile(id: $id, userId: $userId, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings, qrToken: $qrToken, isActive: $isActive, connectedPaymentAccount: $connectedPaymentAccount, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WaiterProfileCopyWith<$Res> implements $WaiterProfileCopyWith<$Res> {
  factory _$WaiterProfileCopyWith(_WaiterProfile value, $Res Function(_WaiterProfile) _then) = __$WaiterProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String fullName, String? avatarUrl, String restaurantName, String city, String country, String? personalMessage, double averageRating, int totalRatings, String qrToken, bool isActive, PaymentAccountInfo? connectedPaymentAccount, DateTime createdAt, DateTime? updatedAt
});


@override $PaymentAccountInfoCopyWith<$Res>? get connectedPaymentAccount;

}
/// @nodoc
class __$WaiterProfileCopyWithImpl<$Res>
    implements _$WaiterProfileCopyWith<$Res> {
  __$WaiterProfileCopyWithImpl(this._self, this._then);

  final _WaiterProfile _self;
  final $Res Function(_WaiterProfile) _then;

/// Create a copy of WaiterProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? fullName = null,Object? avatarUrl = freezed,Object? restaurantName = null,Object? city = null,Object? country = null,Object? personalMessage = freezed,Object? averageRating = null,Object? totalRatings = null,Object? qrToken = null,Object? isActive = null,Object? connectedPaymentAccount = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_WaiterProfile(
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
as PaymentAccountInfo?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of WaiterProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentAccountInfoCopyWith<$Res>? get connectedPaymentAccount {
    if (_self.connectedPaymentAccount == null) {
    return null;
  }

  return $PaymentAccountInfoCopyWith<$Res>(_self.connectedPaymentAccount!, (value) {
    return _then(_self.copyWith(connectedPaymentAccount: value));
  });
}
}


/// @nodoc
mixin _$PaymentAccountInfo {

 String get id; String get type;// 'mobile_money' | 'bank' | 'card'
 String get provider; String get accountIdentifier;// phone or masked account number
 bool get isActive;
/// Create a copy of PaymentAccountInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentAccountInfoCopyWith<PaymentAccountInfo> get copyWith => _$PaymentAccountInfoCopyWithImpl<PaymentAccountInfo>(this as PaymentAccountInfo, _$identity);

  /// Serializes this PaymentAccountInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentAccountInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,provider,accountIdentifier,isActive);

@override
String toString() {
  return 'PaymentAccountInfo(id: $id, type: $type, provider: $provider, accountIdentifier: $accountIdentifier, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $PaymentAccountInfoCopyWith<$Res>  {
  factory $PaymentAccountInfoCopyWith(PaymentAccountInfo value, $Res Function(PaymentAccountInfo) _then) = _$PaymentAccountInfoCopyWithImpl;
@useResult
$Res call({
 String id, String type, String provider, String accountIdentifier, bool isActive
});




}
/// @nodoc
class _$PaymentAccountInfoCopyWithImpl<$Res>
    implements $PaymentAccountInfoCopyWith<$Res> {
  _$PaymentAccountInfoCopyWithImpl(this._self, this._then);

  final PaymentAccountInfo _self;
  final $Res Function(PaymentAccountInfo) _then;

/// Create a copy of PaymentAccountInfo
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


/// Adds pattern-matching-related methods to [PaymentAccountInfo].
extension PaymentAccountInfoPatterns on PaymentAccountInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentAccountInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentAccountInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentAccountInfo value)  $default,){
final _that = this;
switch (_that) {
case _PaymentAccountInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentAccountInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentAccountInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String provider,  String accountIdentifier,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentAccountInfo() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String provider,  String accountIdentifier,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _PaymentAccountInfo():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String provider,  String accountIdentifier,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _PaymentAccountInfo() when $default != null:
return $default(_that.id,_that.type,_that.provider,_that.accountIdentifier,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentAccountInfo implements PaymentAccountInfo {
  const _PaymentAccountInfo({required this.id, required this.type, required this.provider, required this.accountIdentifier, this.isActive = true});
  factory _PaymentAccountInfo.fromJson(Map<String, dynamic> json) => _$PaymentAccountInfoFromJson(json);

@override final  String id;
@override final  String type;
// 'mobile_money' | 'bank' | 'card'
@override final  String provider;
@override final  String accountIdentifier;
// phone or masked account number
@override@JsonKey() final  bool isActive;

/// Create a copy of PaymentAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentAccountInfoCopyWith<_PaymentAccountInfo> get copyWith => __$PaymentAccountInfoCopyWithImpl<_PaymentAccountInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentAccountInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentAccountInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.accountIdentifier, accountIdentifier) || other.accountIdentifier == accountIdentifier)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,provider,accountIdentifier,isActive);

@override
String toString() {
  return 'PaymentAccountInfo(id: $id, type: $type, provider: $provider, accountIdentifier: $accountIdentifier, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$PaymentAccountInfoCopyWith<$Res> implements $PaymentAccountInfoCopyWith<$Res> {
  factory _$PaymentAccountInfoCopyWith(_PaymentAccountInfo value, $Res Function(_PaymentAccountInfo) _then) = __$PaymentAccountInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String provider, String accountIdentifier, bool isActive
});




}
/// @nodoc
class __$PaymentAccountInfoCopyWithImpl<$Res>
    implements _$PaymentAccountInfoCopyWith<$Res> {
  __$PaymentAccountInfoCopyWithImpl(this._self, this._then);

  final _PaymentAccountInfo _self;
  final $Res Function(_PaymentAccountInfo) _then;

/// Create a copy of PaymentAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? provider = null,Object? accountIdentifier = null,Object? isActive = null,}) {
  return _then(_PaymentAccountInfo(
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
mixin _$PublicWaiterProfile {

 String get id; String get fullName; String? get avatarUrl; String get restaurantName; String get city; String get country; String? get personalMessage; double get averageRating; int get totalRatings;
/// Create a copy of PublicWaiterProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicWaiterProfileCopyWith<PublicWaiterProfile> get copyWith => _$PublicWaiterProfileCopyWithImpl<PublicWaiterProfile>(this as PublicWaiterProfile, _$identity);

  /// Serializes this PublicWaiterProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicWaiterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings);

@override
String toString() {
  return 'PublicWaiterProfile(id: $id, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings)';
}


}

/// @nodoc
abstract mixin class $PublicWaiterProfileCopyWith<$Res>  {
  factory $PublicWaiterProfileCopyWith(PublicWaiterProfile value, $Res Function(PublicWaiterProfile) _then) = _$PublicWaiterProfileCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String? avatarUrl, String restaurantName, String city, String country, String? personalMessage, double averageRating, int totalRatings
});




}
/// @nodoc
class _$PublicWaiterProfileCopyWithImpl<$Res>
    implements $PublicWaiterProfileCopyWith<$Res> {
  _$PublicWaiterProfileCopyWithImpl(this._self, this._then);

  final PublicWaiterProfile _self;
  final $Res Function(PublicWaiterProfile) _then;

/// Create a copy of PublicWaiterProfile
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


/// Adds pattern-matching-related methods to [PublicWaiterProfile].
extension PublicWaiterProfilePatterns on PublicWaiterProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicWaiterProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicWaiterProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicWaiterProfile value)  $default,){
final _that = this;
switch (_that) {
case _PublicWaiterProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicWaiterProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PublicWaiterProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String? avatarUrl,  String restaurantName,  String city,  String country,  String? personalMessage,  double averageRating,  int totalRatings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicWaiterProfile() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String? avatarUrl,  String restaurantName,  String city,  String country,  String? personalMessage,  double averageRating,  int totalRatings)  $default,) {final _that = this;
switch (_that) {
case _PublicWaiterProfile():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String? avatarUrl,  String restaurantName,  String city,  String country,  String? personalMessage,  double averageRating,  int totalRatings)?  $default,) {final _that = this;
switch (_that) {
case _PublicWaiterProfile() when $default != null:
return $default(_that.id,_that.fullName,_that.avatarUrl,_that.restaurantName,_that.city,_that.country,_that.personalMessage,_that.averageRating,_that.totalRatings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicWaiterProfile implements PublicWaiterProfile {
  const _PublicWaiterProfile({required this.id, required this.fullName, this.avatarUrl, required this.restaurantName, required this.city, required this.country, this.personalMessage, required this.averageRating, required this.totalRatings});
  factory _PublicWaiterProfile.fromJson(Map<String, dynamic> json) => _$PublicWaiterProfileFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  String restaurantName;
@override final  String city;
@override final  String country;
@override final  String? personalMessage;
@override final  double averageRating;
@override final  int totalRatings;

/// Create a copy of PublicWaiterProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicWaiterProfileCopyWith<_PublicWaiterProfile> get copyWith => __$PublicWaiterProfileCopyWithImpl<_PublicWaiterProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicWaiterProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicWaiterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.personalMessage, personalMessage) || other.personalMessage == personalMessage)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,avatarUrl,restaurantName,city,country,personalMessage,averageRating,totalRatings);

@override
String toString() {
  return 'PublicWaiterProfile(id: $id, fullName: $fullName, avatarUrl: $avatarUrl, restaurantName: $restaurantName, city: $city, country: $country, personalMessage: $personalMessage, averageRating: $averageRating, totalRatings: $totalRatings)';
}


}

/// @nodoc
abstract mixin class _$PublicWaiterProfileCopyWith<$Res> implements $PublicWaiterProfileCopyWith<$Res> {
  factory _$PublicWaiterProfileCopyWith(_PublicWaiterProfile value, $Res Function(_PublicWaiterProfile) _then) = __$PublicWaiterProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String? avatarUrl, String restaurantName, String city, String country, String? personalMessage, double averageRating, int totalRatings
});




}
/// @nodoc
class __$PublicWaiterProfileCopyWithImpl<$Res>
    implements _$PublicWaiterProfileCopyWith<$Res> {
  __$PublicWaiterProfileCopyWithImpl(this._self, this._then);

  final _PublicWaiterProfile _self;
  final $Res Function(_PublicWaiterProfile) _then;

/// Create a copy of PublicWaiterProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? avatarUrl = freezed,Object? restaurantName = null,Object? city = null,Object? country = null,Object? personalMessage = freezed,Object? averageRating = null,Object? totalRatings = null,}) {
  return _then(_PublicWaiterProfile(
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
