// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {

 String get id; String get tipId; int get amount; String get currency; PaymentStatus get status; String get provider; PaymentMethodType get methodType; String? get providerReference; String? get idempotencyKey; String? get failureReason; DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.tipId, tipId) || other.tipId == tipId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.methodType, methodType) || other.methodType == methodType)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tipId,amount,currency,status,provider,methodType,providerReference,idempotencyKey,failureReason,createdAt,updatedAt);

@override
String toString() {
  return 'Payment(id: $id, tipId: $tipId, amount: $amount, currency: $currency, status: $status, provider: $provider, methodType: $methodType, providerReference: $providerReference, idempotencyKey: $idempotencyKey, failureReason: $failureReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String tipId, int amount, String currency, PaymentStatus status, String provider, PaymentMethodType methodType, String? providerReference, String? idempotencyKey, String? failureReason, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tipId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? provider = null,Object? methodType = null,Object? providerReference = freezed,Object? idempotencyKey = freezed,Object? failureReason = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tipId: null == tipId ? _self.tipId : tipId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,methodType: null == methodType ? _self.methodType : methodType // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: freezed == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String tipId,  int amount,  String currency,  PaymentStatus status,  String provider,  PaymentMethodType methodType,  String? providerReference,  String? idempotencyKey,  String? failureReason,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.tipId,_that.amount,_that.currency,_that.status,_that.provider,_that.methodType,_that.providerReference,_that.idempotencyKey,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String tipId,  int amount,  String currency,  PaymentStatus status,  String provider,  PaymentMethodType methodType,  String? providerReference,  String? idempotencyKey,  String? failureReason,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.tipId,_that.amount,_that.currency,_that.status,_that.provider,_that.methodType,_that.providerReference,_that.idempotencyKey,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String tipId,  int amount,  String currency,  PaymentStatus status,  String provider,  PaymentMethodType methodType,  String? providerReference,  String? idempotencyKey,  String? failureReason,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.tipId,_that.amount,_that.currency,_that.status,_that.provider,_that.methodType,_that.providerReference,_that.idempotencyKey,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment implements Payment {
  const _Payment({required this.id, required this.tipId, required this.amount, required this.currency, required this.status, required this.provider, required this.methodType, this.providerReference, this.idempotencyKey, this.failureReason, required this.createdAt, this.updatedAt});
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  String id;
@override final  String tipId;
@override final  int amount;
@override final  String currency;
@override final  PaymentStatus status;
@override final  String provider;
@override final  PaymentMethodType methodType;
@override final  String? providerReference;
@override final  String? idempotencyKey;
@override final  String? failureReason;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.tipId, tipId) || other.tipId == tipId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.methodType, methodType) || other.methodType == methodType)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tipId,amount,currency,status,provider,methodType,providerReference,idempotencyKey,failureReason,createdAt,updatedAt);

@override
String toString() {
  return 'Payment(id: $id, tipId: $tipId, amount: $amount, currency: $currency, status: $status, provider: $provider, methodType: $methodType, providerReference: $providerReference, idempotencyKey: $idempotencyKey, failureReason: $failureReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String tipId, int amount, String currency, PaymentStatus status, String provider, PaymentMethodType methodType, String? providerReference, String? idempotencyKey, String? failureReason, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tipId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? provider = null,Object? methodType = null,Object? providerReference = freezed,Object? idempotencyKey = freezed,Object? failureReason = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tipId: null == tipId ? _self.tipId : tipId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,methodType: null == methodType ? _self.methodType : methodType // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,idempotencyKey: freezed == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PaymentMethod {

 String get id; String get name; String get provider; PaymentMethodType get type; bool get isAvailable; String? get logoUrl; String? get description;
/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<PaymentMethod> get copyWith => _$PaymentMethodCopyWithImpl<PaymentMethod>(this as PaymentMethod, _$identity);

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,provider,type,isAvailable,logoUrl,description);

@override
String toString() {
  return 'PaymentMethod(id: $id, name: $name, provider: $provider, type: $type, isAvailable: $isAvailable, logoUrl: $logoUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodCopyWith<$Res>  {
  factory $PaymentMethodCopyWith(PaymentMethod value, $Res Function(PaymentMethod) _then) = _$PaymentMethodCopyWithImpl;
@useResult
$Res call({
 String id, String name, String provider, PaymentMethodType type, bool isAvailable, String? logoUrl, String? description
});




}
/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._self, this._then);

  final PaymentMethod _self;
  final $Res Function(PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? provider = null,Object? type = null,Object? isAvailable = null,Object? logoUrl = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethod].
extension PaymentMethodPatterns on PaymentMethod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethod value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethod value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String provider,  PaymentMethodType type,  bool isAvailable,  String? logoUrl,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.id,_that.name,_that.provider,_that.type,_that.isAvailable,_that.logoUrl,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String provider,  PaymentMethodType type,  bool isAvailable,  String? logoUrl,  String? description)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod():
return $default(_that.id,_that.name,_that.provider,_that.type,_that.isAvailable,_that.logoUrl,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String provider,  PaymentMethodType type,  bool isAvailable,  String? logoUrl,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.id,_that.name,_that.provider,_that.type,_that.isAvailable,_that.logoUrl,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethod implements PaymentMethod {
  const _PaymentMethod({required this.id, required this.name, required this.provider, required this.type, required this.isAvailable, this.logoUrl, this.description});
  factory _PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

@override final  String id;
@override final  String name;
@override final  String provider;
@override final  PaymentMethodType type;
@override final  bool isAvailable;
@override final  String? logoUrl;
@override final  String? description;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodCopyWith<_PaymentMethod> get copyWith => __$PaymentMethodCopyWithImpl<_PaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,provider,type,isAvailable,logoUrl,description);

@override
String toString() {
  return 'PaymentMethod(id: $id, name: $name, provider: $provider, type: $type, isAvailable: $isAvailable, logoUrl: $logoUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory _$PaymentMethodCopyWith(_PaymentMethod value, $Res Function(_PaymentMethod) _then) = __$PaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String provider, PaymentMethodType type, bool isAvailable, String? logoUrl, String? description
});




}
/// @nodoc
class __$PaymentMethodCopyWithImpl<$Res>
    implements _$PaymentMethodCopyWith<$Res> {
  __$PaymentMethodCopyWithImpl(this._self, this._then);

  final _PaymentMethod _self;
  final $Res Function(_PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? provider = null,Object? type = null,Object? isAvailable = null,Object? logoUrl = freezed,Object? description = freezed,}) {
  return _then(_PaymentMethod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaymentResult {

 String get paymentId; PaymentStatus get status; String? get redirectUrl; String? get ussdCode; String? get providerReference; String? get message;
/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentResultCopyWith<PaymentResult> get copyWith => _$PaymentResultCopyWithImpl<PaymentResult>(this as PaymentResult, _$identity);

  /// Serializes this PaymentResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentResult&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.ussdCode, ussdCode) || other.ussdCode == ussdCode)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,status,redirectUrl,ussdCode,providerReference,message);

@override
String toString() {
  return 'PaymentResult(paymentId: $paymentId, status: $status, redirectUrl: $redirectUrl, ussdCode: $ussdCode, providerReference: $providerReference, message: $message)';
}


}

/// @nodoc
abstract mixin class $PaymentResultCopyWith<$Res>  {
  factory $PaymentResultCopyWith(PaymentResult value, $Res Function(PaymentResult) _then) = _$PaymentResultCopyWithImpl;
@useResult
$Res call({
 String paymentId, PaymentStatus status, String? redirectUrl, String? ussdCode, String? providerReference, String? message
});




}
/// @nodoc
class _$PaymentResultCopyWithImpl<$Res>
    implements $PaymentResultCopyWith<$Res> {
  _$PaymentResultCopyWithImpl(this._self, this._then);

  final PaymentResult _self;
  final $Res Function(PaymentResult) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? status = null,Object? redirectUrl = freezed,Object? ussdCode = freezed,Object? providerReference = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,ussdCode: freezed == ussdCode ? _self.ussdCode : ussdCode // ignore: cast_nullable_to_non_nullable
as String?,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentResult].
extension PaymentResultPatterns on PaymentResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentResult value)  $default,){
final _that = this;
switch (_that) {
case _PaymentResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentResult value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  PaymentStatus status,  String? redirectUrl,  String? ussdCode,  String? providerReference,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
return $default(_that.paymentId,_that.status,_that.redirectUrl,_that.ussdCode,_that.providerReference,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  PaymentStatus status,  String? redirectUrl,  String? ussdCode,  String? providerReference,  String? message)  $default,) {final _that = this;
switch (_that) {
case _PaymentResult():
return $default(_that.paymentId,_that.status,_that.redirectUrl,_that.ussdCode,_that.providerReference,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  PaymentStatus status,  String? redirectUrl,  String? ussdCode,  String? providerReference,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
return $default(_that.paymentId,_that.status,_that.redirectUrl,_that.ussdCode,_that.providerReference,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentResult implements PaymentResult {
  const _PaymentResult({required this.paymentId, required this.status, this.redirectUrl, this.ussdCode, this.providerReference, this.message});
  factory _PaymentResult.fromJson(Map<String, dynamic> json) => _$PaymentResultFromJson(json);

@override final  String paymentId;
@override final  PaymentStatus status;
@override final  String? redirectUrl;
@override final  String? ussdCode;
@override final  String? providerReference;
@override final  String? message;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentResultCopyWith<_PaymentResult> get copyWith => __$PaymentResultCopyWithImpl<_PaymentResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentResult&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.ussdCode, ussdCode) || other.ussdCode == ussdCode)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,status,redirectUrl,ussdCode,providerReference,message);

@override
String toString() {
  return 'PaymentResult(paymentId: $paymentId, status: $status, redirectUrl: $redirectUrl, ussdCode: $ussdCode, providerReference: $providerReference, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PaymentResultCopyWith<$Res> implements $PaymentResultCopyWith<$Res> {
  factory _$PaymentResultCopyWith(_PaymentResult value, $Res Function(_PaymentResult) _then) = __$PaymentResultCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, PaymentStatus status, String? redirectUrl, String? ussdCode, String? providerReference, String? message
});




}
/// @nodoc
class __$PaymentResultCopyWithImpl<$Res>
    implements _$PaymentResultCopyWith<$Res> {
  __$PaymentResultCopyWithImpl(this._self, this._then);

  final _PaymentResult _self;
  final $Res Function(_PaymentResult) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? status = null,Object? redirectUrl = freezed,Object? ussdCode = freezed,Object? providerReference = freezed,Object? message = freezed,}) {
  return _then(_PaymentResult(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,ussdCode: freezed == ussdCode ? _self.ussdCode : ussdCode // ignore: cast_nullable_to_non_nullable
as String?,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TipFeeBreakdown {

 int get tipAmount; int get platformFee; int get waiterReceives; String get currency; bool get isFeeWaivedForCustomer;
/// Create a copy of TipFeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipFeeBreakdownCopyWith<TipFeeBreakdown> get copyWith => _$TipFeeBreakdownCopyWithImpl<TipFeeBreakdown>(this as TipFeeBreakdown, _$identity);

  /// Serializes this TipFeeBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipFeeBreakdown&&(identical(other.tipAmount, tipAmount) || other.tipAmount == tipAmount)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.waiterReceives, waiterReceives) || other.waiterReceives == waiterReceives)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isFeeWaivedForCustomer, isFeeWaivedForCustomer) || other.isFeeWaivedForCustomer == isFeeWaivedForCustomer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tipAmount,platformFee,waiterReceives,currency,isFeeWaivedForCustomer);

@override
String toString() {
  return 'TipFeeBreakdown(tipAmount: $tipAmount, platformFee: $platformFee, waiterReceives: $waiterReceives, currency: $currency, isFeeWaivedForCustomer: $isFeeWaivedForCustomer)';
}


}

/// @nodoc
abstract mixin class $TipFeeBreakdownCopyWith<$Res>  {
  factory $TipFeeBreakdownCopyWith(TipFeeBreakdown value, $Res Function(TipFeeBreakdown) _then) = _$TipFeeBreakdownCopyWithImpl;
@useResult
$Res call({
 int tipAmount, int platformFee, int waiterReceives, String currency, bool isFeeWaivedForCustomer
});




}
/// @nodoc
class _$TipFeeBreakdownCopyWithImpl<$Res>
    implements $TipFeeBreakdownCopyWith<$Res> {
  _$TipFeeBreakdownCopyWithImpl(this._self, this._then);

  final TipFeeBreakdown _self;
  final $Res Function(TipFeeBreakdown) _then;

/// Create a copy of TipFeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tipAmount = null,Object? platformFee = null,Object? waiterReceives = null,Object? currency = null,Object? isFeeWaivedForCustomer = null,}) {
  return _then(_self.copyWith(
tipAmount: null == tipAmount ? _self.tipAmount : tipAmount // ignore: cast_nullable_to_non_nullable
as int,platformFee: null == platformFee ? _self.platformFee : platformFee // ignore: cast_nullable_to_non_nullable
as int,waiterReceives: null == waiterReceives ? _self.waiterReceives : waiterReceives // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isFeeWaivedForCustomer: null == isFeeWaivedForCustomer ? _self.isFeeWaivedForCustomer : isFeeWaivedForCustomer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TipFeeBreakdown].
extension TipFeeBreakdownPatterns on TipFeeBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipFeeBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipFeeBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipFeeBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _TipFeeBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipFeeBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _TipFeeBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tipAmount,  int platformFee,  int waiterReceives,  String currency,  bool isFeeWaivedForCustomer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipFeeBreakdown() when $default != null:
return $default(_that.tipAmount,_that.platformFee,_that.waiterReceives,_that.currency,_that.isFeeWaivedForCustomer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tipAmount,  int platformFee,  int waiterReceives,  String currency,  bool isFeeWaivedForCustomer)  $default,) {final _that = this;
switch (_that) {
case _TipFeeBreakdown():
return $default(_that.tipAmount,_that.platformFee,_that.waiterReceives,_that.currency,_that.isFeeWaivedForCustomer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tipAmount,  int platformFee,  int waiterReceives,  String currency,  bool isFeeWaivedForCustomer)?  $default,) {final _that = this;
switch (_that) {
case _TipFeeBreakdown() when $default != null:
return $default(_that.tipAmount,_that.platformFee,_that.waiterReceives,_that.currency,_that.isFeeWaivedForCustomer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipFeeBreakdown implements TipFeeBreakdown {
  const _TipFeeBreakdown({required this.tipAmount, required this.platformFee, required this.waiterReceives, required this.currency, this.isFeeWaivedForCustomer = false});
  factory _TipFeeBreakdown.fromJson(Map<String, dynamic> json) => _$TipFeeBreakdownFromJson(json);

@override final  int tipAmount;
@override final  int platformFee;
@override final  int waiterReceives;
@override final  String currency;
@override@JsonKey() final  bool isFeeWaivedForCustomer;

/// Create a copy of TipFeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipFeeBreakdownCopyWith<_TipFeeBreakdown> get copyWith => __$TipFeeBreakdownCopyWithImpl<_TipFeeBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipFeeBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipFeeBreakdown&&(identical(other.tipAmount, tipAmount) || other.tipAmount == tipAmount)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.waiterReceives, waiterReceives) || other.waiterReceives == waiterReceives)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isFeeWaivedForCustomer, isFeeWaivedForCustomer) || other.isFeeWaivedForCustomer == isFeeWaivedForCustomer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tipAmount,platformFee,waiterReceives,currency,isFeeWaivedForCustomer);

@override
String toString() {
  return 'TipFeeBreakdown(tipAmount: $tipAmount, platformFee: $platformFee, waiterReceives: $waiterReceives, currency: $currency, isFeeWaivedForCustomer: $isFeeWaivedForCustomer)';
}


}

/// @nodoc
abstract mixin class _$TipFeeBreakdownCopyWith<$Res> implements $TipFeeBreakdownCopyWith<$Res> {
  factory _$TipFeeBreakdownCopyWith(_TipFeeBreakdown value, $Res Function(_TipFeeBreakdown) _then) = __$TipFeeBreakdownCopyWithImpl;
@override @useResult
$Res call({
 int tipAmount, int platformFee, int waiterReceives, String currency, bool isFeeWaivedForCustomer
});




}
/// @nodoc
class __$TipFeeBreakdownCopyWithImpl<$Res>
    implements _$TipFeeBreakdownCopyWith<$Res> {
  __$TipFeeBreakdownCopyWithImpl(this._self, this._then);

  final _TipFeeBreakdown _self;
  final $Res Function(_TipFeeBreakdown) _then;

/// Create a copy of TipFeeBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tipAmount = null,Object? platformFee = null,Object? waiterReceives = null,Object? currency = null,Object? isFeeWaivedForCustomer = null,}) {
  return _then(_TipFeeBreakdown(
tipAmount: null == tipAmount ? _self.tipAmount : tipAmount // ignore: cast_nullable_to_non_nullable
as int,platformFee: null == platformFee ? _self.platformFee : platformFee // ignore: cast_nullable_to_non_nullable
as int,waiterReceives: null == waiterReceives ? _self.waiterReceives : waiterReceives // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isFeeWaivedForCustomer: null == isFeeWaivedForCustomer ? _self.isFeeWaivedForCustomer : isFeeWaivedForCustomer // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
