// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentMethodModel {

 String get id; String get name; String get provider; String get type;@JsonKey(name: 'is_available') bool get isAvailable;@JsonKey(name: 'logo_url') String? get logoUrl; String? get description;
/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodModelCopyWith<PaymentMethodModel> get copyWith => _$PaymentMethodModelCopyWithImpl<PaymentMethodModel>(this as PaymentMethodModel, _$identity);

  /// Serializes this PaymentMethodModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,provider,type,isAvailable,logoUrl,description);

@override
String toString() {
  return 'PaymentMethodModel(id: $id, name: $name, provider: $provider, type: $type, isAvailable: $isAvailable, logoUrl: $logoUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodModelCopyWith<$Res>  {
  factory $PaymentMethodModelCopyWith(PaymentMethodModel value, $Res Function(PaymentMethodModel) _then) = _$PaymentMethodModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String provider, String type,@JsonKey(name: 'is_available') bool isAvailable,@JsonKey(name: 'logo_url') String? logoUrl, String? description
});




}
/// @nodoc
class _$PaymentMethodModelCopyWithImpl<$Res>
    implements $PaymentMethodModelCopyWith<$Res> {
  _$PaymentMethodModelCopyWithImpl(this._self, this._then);

  final PaymentMethodModel _self;
  final $Res Function(PaymentMethodModel) _then;

/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? provider = null,Object? type = null,Object? isAvailable = null,Object? logoUrl = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethodModel].
extension PaymentMethodModelPatterns on PaymentMethodModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethodModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethodModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethodModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String provider,  String type, @JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'logo_url')  String? logoUrl,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String provider,  String type, @JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'logo_url')  String? logoUrl,  String? description)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String provider,  String type, @JsonKey(name: 'is_available')  bool isAvailable, @JsonKey(name: 'logo_url')  String? logoUrl,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodModel() when $default != null:
return $default(_that.id,_that.name,_that.provider,_that.type,_that.isAvailable,_that.logoUrl,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethodModel implements PaymentMethodModel {
  const _PaymentMethodModel({required this.id, required this.name, required this.provider, required this.type, @JsonKey(name: 'is_available') this.isAvailable = true, @JsonKey(name: 'logo_url') this.logoUrl, this.description});
  factory _PaymentMethodModel.fromJson(Map<String, dynamic> json) => _$PaymentMethodModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String provider;
@override final  String type;
@override@JsonKey(name: 'is_available') final  bool isAvailable;
@override@JsonKey(name: 'logo_url') final  String? logoUrl;
@override final  String? description;

/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodModelCopyWith<_PaymentMethodModel> get copyWith => __$PaymentMethodModelCopyWithImpl<_PaymentMethodModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethodModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.type, type) || other.type == type)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,provider,type,isAvailable,logoUrl,description);

@override
String toString() {
  return 'PaymentMethodModel(id: $id, name: $name, provider: $provider, type: $type, isAvailable: $isAvailable, logoUrl: $logoUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodModelCopyWith<$Res> implements $PaymentMethodModelCopyWith<$Res> {
  factory _$PaymentMethodModelCopyWith(_PaymentMethodModel value, $Res Function(_PaymentMethodModel) _then) = __$PaymentMethodModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String provider, String type,@JsonKey(name: 'is_available') bool isAvailable,@JsonKey(name: 'logo_url') String? logoUrl, String? description
});




}
/// @nodoc
class __$PaymentMethodModelCopyWithImpl<$Res>
    implements _$PaymentMethodModelCopyWith<$Res> {
  __$PaymentMethodModelCopyWithImpl(this._self, this._then);

  final _PaymentMethodModel _self;
  final $Res Function(_PaymentMethodModel) _then;

/// Create a copy of PaymentMethodModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? provider = null,Object? type = null,Object? isAvailable = null,Object? logoUrl = freezed,Object? description = freezed,}) {
  return _then(_PaymentMethodModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaymentResultModel {

@JsonKey(name: 'payment_id') String get paymentId; String get status;@JsonKey(name: 'redirect_url') String? get redirectUrl;@JsonKey(name: 'ussd_code') String? get ussdCode;@JsonKey(name: 'provider_reference') String? get providerReference; String? get message;
/// Create a copy of PaymentResultModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentResultModelCopyWith<PaymentResultModel> get copyWith => _$PaymentResultModelCopyWithImpl<PaymentResultModel>(this as PaymentResultModel, _$identity);

  /// Serializes this PaymentResultModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentResultModel&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.ussdCode, ussdCode) || other.ussdCode == ussdCode)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,status,redirectUrl,ussdCode,providerReference,message);

@override
String toString() {
  return 'PaymentResultModel(paymentId: $paymentId, status: $status, redirectUrl: $redirectUrl, ussdCode: $ussdCode, providerReference: $providerReference, message: $message)';
}


}

/// @nodoc
abstract mixin class $PaymentResultModelCopyWith<$Res>  {
  factory $PaymentResultModelCopyWith(PaymentResultModel value, $Res Function(PaymentResultModel) _then) = _$PaymentResultModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'payment_id') String paymentId, String status,@JsonKey(name: 'redirect_url') String? redirectUrl,@JsonKey(name: 'ussd_code') String? ussdCode,@JsonKey(name: 'provider_reference') String? providerReference, String? message
});




}
/// @nodoc
class _$PaymentResultModelCopyWithImpl<$Res>
    implements $PaymentResultModelCopyWith<$Res> {
  _$PaymentResultModelCopyWithImpl(this._self, this._then);

  final PaymentResultModel _self;
  final $Res Function(PaymentResultModel) _then;

/// Create a copy of PaymentResultModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? status = null,Object? redirectUrl = freezed,Object? ussdCode = freezed,Object? providerReference = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,ussdCode: freezed == ussdCode ? _self.ussdCode : ussdCode // ignore: cast_nullable_to_non_nullable
as String?,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentResultModel].
extension PaymentResultModelPatterns on PaymentResultModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentResultModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentResultModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentResultModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentResultModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentResultModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentResultModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'payment_id')  String paymentId,  String status, @JsonKey(name: 'redirect_url')  String? redirectUrl, @JsonKey(name: 'ussd_code')  String? ussdCode, @JsonKey(name: 'provider_reference')  String? providerReference,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentResultModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'payment_id')  String paymentId,  String status, @JsonKey(name: 'redirect_url')  String? redirectUrl, @JsonKey(name: 'ussd_code')  String? ussdCode, @JsonKey(name: 'provider_reference')  String? providerReference,  String? message)  $default,) {final _that = this;
switch (_that) {
case _PaymentResultModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'payment_id')  String paymentId,  String status, @JsonKey(name: 'redirect_url')  String? redirectUrl, @JsonKey(name: 'ussd_code')  String? ussdCode, @JsonKey(name: 'provider_reference')  String? providerReference,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _PaymentResultModel() when $default != null:
return $default(_that.paymentId,_that.status,_that.redirectUrl,_that.ussdCode,_that.providerReference,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentResultModel implements PaymentResultModel {
  const _PaymentResultModel({@JsonKey(name: 'payment_id') required this.paymentId, required this.status, @JsonKey(name: 'redirect_url') this.redirectUrl, @JsonKey(name: 'ussd_code') this.ussdCode, @JsonKey(name: 'provider_reference') this.providerReference, this.message});
  factory _PaymentResultModel.fromJson(Map<String, dynamic> json) => _$PaymentResultModelFromJson(json);

@override@JsonKey(name: 'payment_id') final  String paymentId;
@override final  String status;
@override@JsonKey(name: 'redirect_url') final  String? redirectUrl;
@override@JsonKey(name: 'ussd_code') final  String? ussdCode;
@override@JsonKey(name: 'provider_reference') final  String? providerReference;
@override final  String? message;

/// Create a copy of PaymentResultModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentResultModelCopyWith<_PaymentResultModel> get copyWith => __$PaymentResultModelCopyWithImpl<_PaymentResultModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentResultModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentResultModel&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.ussdCode, ussdCode) || other.ussdCode == ussdCode)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,status,redirectUrl,ussdCode,providerReference,message);

@override
String toString() {
  return 'PaymentResultModel(paymentId: $paymentId, status: $status, redirectUrl: $redirectUrl, ussdCode: $ussdCode, providerReference: $providerReference, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PaymentResultModelCopyWith<$Res> implements $PaymentResultModelCopyWith<$Res> {
  factory _$PaymentResultModelCopyWith(_PaymentResultModel value, $Res Function(_PaymentResultModel) _then) = __$PaymentResultModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'payment_id') String paymentId, String status,@JsonKey(name: 'redirect_url') String? redirectUrl,@JsonKey(name: 'ussd_code') String? ussdCode,@JsonKey(name: 'provider_reference') String? providerReference, String? message
});




}
/// @nodoc
class __$PaymentResultModelCopyWithImpl<$Res>
    implements _$PaymentResultModelCopyWith<$Res> {
  __$PaymentResultModelCopyWithImpl(this._self, this._then);

  final _PaymentResultModel _self;
  final $Res Function(_PaymentResultModel) _then;

/// Create a copy of PaymentResultModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? status = null,Object? redirectUrl = freezed,Object? ussdCode = freezed,Object? providerReference = freezed,Object? message = freezed,}) {
  return _then(_PaymentResultModel(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,ussdCode: freezed == ussdCode ? _self.ussdCode : ussdCode // ignore: cast_nullable_to_non_nullable
as String?,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TipFeeBreakdownModel {

@JsonKey(name: 'tip_amount') int get tipAmount;@JsonKey(name: 'platform_fee') int get platformFee;@JsonKey(name: 'waiter_receives') int get waiterReceives; String get currency;@JsonKey(name: 'is_fee_waived_for_customer') bool get isFeeWaivedForCustomer;
/// Create a copy of TipFeeBreakdownModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipFeeBreakdownModelCopyWith<TipFeeBreakdownModel> get copyWith => _$TipFeeBreakdownModelCopyWithImpl<TipFeeBreakdownModel>(this as TipFeeBreakdownModel, _$identity);

  /// Serializes this TipFeeBreakdownModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipFeeBreakdownModel&&(identical(other.tipAmount, tipAmount) || other.tipAmount == tipAmount)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.waiterReceives, waiterReceives) || other.waiterReceives == waiterReceives)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isFeeWaivedForCustomer, isFeeWaivedForCustomer) || other.isFeeWaivedForCustomer == isFeeWaivedForCustomer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tipAmount,platformFee,waiterReceives,currency,isFeeWaivedForCustomer);

@override
String toString() {
  return 'TipFeeBreakdownModel(tipAmount: $tipAmount, platformFee: $platformFee, waiterReceives: $waiterReceives, currency: $currency, isFeeWaivedForCustomer: $isFeeWaivedForCustomer)';
}


}

/// @nodoc
abstract mixin class $TipFeeBreakdownModelCopyWith<$Res>  {
  factory $TipFeeBreakdownModelCopyWith(TipFeeBreakdownModel value, $Res Function(TipFeeBreakdownModel) _then) = _$TipFeeBreakdownModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tip_amount') int tipAmount,@JsonKey(name: 'platform_fee') int platformFee,@JsonKey(name: 'waiter_receives') int waiterReceives, String currency,@JsonKey(name: 'is_fee_waived_for_customer') bool isFeeWaivedForCustomer
});




}
/// @nodoc
class _$TipFeeBreakdownModelCopyWithImpl<$Res>
    implements $TipFeeBreakdownModelCopyWith<$Res> {
  _$TipFeeBreakdownModelCopyWithImpl(this._self, this._then);

  final TipFeeBreakdownModel _self;
  final $Res Function(TipFeeBreakdownModel) _then;

/// Create a copy of TipFeeBreakdownModel
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


/// Adds pattern-matching-related methods to [TipFeeBreakdownModel].
extension TipFeeBreakdownModelPatterns on TipFeeBreakdownModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipFeeBreakdownModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipFeeBreakdownModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipFeeBreakdownModel value)  $default,){
final _that = this;
switch (_that) {
case _TipFeeBreakdownModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipFeeBreakdownModel value)?  $default,){
final _that = this;
switch (_that) {
case _TipFeeBreakdownModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tip_amount')  int tipAmount, @JsonKey(name: 'platform_fee')  int platformFee, @JsonKey(name: 'waiter_receives')  int waiterReceives,  String currency, @JsonKey(name: 'is_fee_waived_for_customer')  bool isFeeWaivedForCustomer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipFeeBreakdownModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tip_amount')  int tipAmount, @JsonKey(name: 'platform_fee')  int platformFee, @JsonKey(name: 'waiter_receives')  int waiterReceives,  String currency, @JsonKey(name: 'is_fee_waived_for_customer')  bool isFeeWaivedForCustomer)  $default,) {final _that = this;
switch (_that) {
case _TipFeeBreakdownModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tip_amount')  int tipAmount, @JsonKey(name: 'platform_fee')  int platformFee, @JsonKey(name: 'waiter_receives')  int waiterReceives,  String currency, @JsonKey(name: 'is_fee_waived_for_customer')  bool isFeeWaivedForCustomer)?  $default,) {final _that = this;
switch (_that) {
case _TipFeeBreakdownModel() when $default != null:
return $default(_that.tipAmount,_that.platformFee,_that.waiterReceives,_that.currency,_that.isFeeWaivedForCustomer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipFeeBreakdownModel implements TipFeeBreakdownModel {
  const _TipFeeBreakdownModel({@JsonKey(name: 'tip_amount') required this.tipAmount, @JsonKey(name: 'platform_fee') required this.platformFee, @JsonKey(name: 'waiter_receives') required this.waiterReceives, required this.currency, @JsonKey(name: 'is_fee_waived_for_customer') this.isFeeWaivedForCustomer = false});
  factory _TipFeeBreakdownModel.fromJson(Map<String, dynamic> json) => _$TipFeeBreakdownModelFromJson(json);

@override@JsonKey(name: 'tip_amount') final  int tipAmount;
@override@JsonKey(name: 'platform_fee') final  int platformFee;
@override@JsonKey(name: 'waiter_receives') final  int waiterReceives;
@override final  String currency;
@override@JsonKey(name: 'is_fee_waived_for_customer') final  bool isFeeWaivedForCustomer;

/// Create a copy of TipFeeBreakdownModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipFeeBreakdownModelCopyWith<_TipFeeBreakdownModel> get copyWith => __$TipFeeBreakdownModelCopyWithImpl<_TipFeeBreakdownModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipFeeBreakdownModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipFeeBreakdownModel&&(identical(other.tipAmount, tipAmount) || other.tipAmount == tipAmount)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.waiterReceives, waiterReceives) || other.waiterReceives == waiterReceives)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isFeeWaivedForCustomer, isFeeWaivedForCustomer) || other.isFeeWaivedForCustomer == isFeeWaivedForCustomer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tipAmount,platformFee,waiterReceives,currency,isFeeWaivedForCustomer);

@override
String toString() {
  return 'TipFeeBreakdownModel(tipAmount: $tipAmount, platformFee: $platformFee, waiterReceives: $waiterReceives, currency: $currency, isFeeWaivedForCustomer: $isFeeWaivedForCustomer)';
}


}

/// @nodoc
abstract mixin class _$TipFeeBreakdownModelCopyWith<$Res> implements $TipFeeBreakdownModelCopyWith<$Res> {
  factory _$TipFeeBreakdownModelCopyWith(_TipFeeBreakdownModel value, $Res Function(_TipFeeBreakdownModel) _then) = __$TipFeeBreakdownModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tip_amount') int tipAmount,@JsonKey(name: 'platform_fee') int platformFee,@JsonKey(name: 'waiter_receives') int waiterReceives, String currency,@JsonKey(name: 'is_fee_waived_for_customer') bool isFeeWaivedForCustomer
});




}
/// @nodoc
class __$TipFeeBreakdownModelCopyWithImpl<$Res>
    implements _$TipFeeBreakdownModelCopyWith<$Res> {
  __$TipFeeBreakdownModelCopyWithImpl(this._self, this._then);

  final _TipFeeBreakdownModel _self;
  final $Res Function(_TipFeeBreakdownModel) _then;

/// Create a copy of TipFeeBreakdownModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tipAmount = null,Object? platformFee = null,Object? waiterReceives = null,Object? currency = null,Object? isFeeWaivedForCustomer = null,}) {
  return _then(_TipFeeBreakdownModel(
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
