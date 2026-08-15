// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WithdrawalModel {

 String get id;@JsonKey(name: 'waiter_id') String get waiterId; int get amount; String get currency; String get status;@JsonKey(name: 'payment_account_id') String get paymentAccountId;@JsonKey(name: 'provider_reference') String? get providerReference;@JsonKey(name: 'failure_reason') String? get failureReason;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of WithdrawalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawalModelCopyWith<WithdrawalModel> get copyWith => _$WithdrawalModelCopyWithImpl<WithdrawalModel>(this as WithdrawalModel, _$identity);

  /// Serializes this WithdrawalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentAccountId, paymentAccountId) || other.paymentAccountId == paymentAccountId)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,waiterId,amount,currency,status,paymentAccountId,providerReference,failureReason,createdAt,updatedAt);

@override
String toString() {
  return 'WithdrawalModel(id: $id, waiterId: $waiterId, amount: $amount, currency: $currency, status: $status, paymentAccountId: $paymentAccountId, providerReference: $providerReference, failureReason: $failureReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $WithdrawalModelCopyWith<$Res>  {
  factory $WithdrawalModelCopyWith(WithdrawalModel value, $Res Function(WithdrawalModel) _then) = _$WithdrawalModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'waiter_id') String waiterId, int amount, String currency, String status,@JsonKey(name: 'payment_account_id') String paymentAccountId,@JsonKey(name: 'provider_reference') String? providerReference,@JsonKey(name: 'failure_reason') String? failureReason,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$WithdrawalModelCopyWithImpl<$Res>
    implements $WithdrawalModelCopyWith<$Res> {
  _$WithdrawalModelCopyWithImpl(this._self, this._then);

  final WithdrawalModel _self;
  final $Res Function(WithdrawalModel) _then;

/// Create a copy of WithdrawalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? waiterId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? paymentAccountId = null,Object? providerReference = freezed,Object? failureReason = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,paymentAccountId: null == paymentAccountId ? _self.paymentAccountId : paymentAccountId // ignore: cast_nullable_to_non_nullable
as String,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawalModel].
extension WithdrawalModelPatterns on WithdrawalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawalModel value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawalModel value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'waiter_id')  String waiterId,  int amount,  String currency,  String status, @JsonKey(name: 'payment_account_id')  String paymentAccountId, @JsonKey(name: 'provider_reference')  String? providerReference, @JsonKey(name: 'failure_reason')  String? failureReason, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawalModel() when $default != null:
return $default(_that.id,_that.waiterId,_that.amount,_that.currency,_that.status,_that.paymentAccountId,_that.providerReference,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'waiter_id')  String waiterId,  int amount,  String currency,  String status, @JsonKey(name: 'payment_account_id')  String paymentAccountId, @JsonKey(name: 'provider_reference')  String? providerReference, @JsonKey(name: 'failure_reason')  String? failureReason, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WithdrawalModel():
return $default(_that.id,_that.waiterId,_that.amount,_that.currency,_that.status,_that.paymentAccountId,_that.providerReference,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'waiter_id')  String waiterId,  int amount,  String currency,  String status, @JsonKey(name: 'payment_account_id')  String paymentAccountId, @JsonKey(name: 'provider_reference')  String? providerReference, @JsonKey(name: 'failure_reason')  String? failureReason, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawalModel() when $default != null:
return $default(_that.id,_that.waiterId,_that.amount,_that.currency,_that.status,_that.paymentAccountId,_that.providerReference,_that.failureReason,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WithdrawalModel implements WithdrawalModel {
  const _WithdrawalModel({required this.id, @JsonKey(name: 'waiter_id') required this.waiterId, required this.amount, required this.currency, required this.status, @JsonKey(name: 'payment_account_id') required this.paymentAccountId, @JsonKey(name: 'provider_reference') this.providerReference, @JsonKey(name: 'failure_reason') this.failureReason, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _WithdrawalModel.fromJson(Map<String, dynamic> json) => _$WithdrawalModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'waiter_id') final  String waiterId;
@override final  int amount;
@override final  String currency;
@override final  String status;
@override@JsonKey(name: 'payment_account_id') final  String paymentAccountId;
@override@JsonKey(name: 'provider_reference') final  String? providerReference;
@override@JsonKey(name: 'failure_reason') final  String? failureReason;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of WithdrawalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawalModelCopyWith<_WithdrawalModel> get copyWith => __$WithdrawalModelCopyWithImpl<_WithdrawalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WithdrawalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawalModel&&(identical(other.id, id) || other.id == id)&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentAccountId, paymentAccountId) || other.paymentAccountId == paymentAccountId)&&(identical(other.providerReference, providerReference) || other.providerReference == providerReference)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,waiterId,amount,currency,status,paymentAccountId,providerReference,failureReason,createdAt,updatedAt);

@override
String toString() {
  return 'WithdrawalModel(id: $id, waiterId: $waiterId, amount: $amount, currency: $currency, status: $status, paymentAccountId: $paymentAccountId, providerReference: $providerReference, failureReason: $failureReason, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WithdrawalModelCopyWith<$Res> implements $WithdrawalModelCopyWith<$Res> {
  factory _$WithdrawalModelCopyWith(_WithdrawalModel value, $Res Function(_WithdrawalModel) _then) = __$WithdrawalModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'waiter_id') String waiterId, int amount, String currency, String status,@JsonKey(name: 'payment_account_id') String paymentAccountId,@JsonKey(name: 'provider_reference') String? providerReference,@JsonKey(name: 'failure_reason') String? failureReason,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$WithdrawalModelCopyWithImpl<$Res>
    implements _$WithdrawalModelCopyWith<$Res> {
  __$WithdrawalModelCopyWithImpl(this._self, this._then);

  final _WithdrawalModel _self;
  final $Res Function(_WithdrawalModel) _then;

/// Create a copy of WithdrawalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? waiterId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? paymentAccountId = null,Object? providerReference = freezed,Object? failureReason = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_WithdrawalModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,paymentAccountId: null == paymentAccountId ? _self.paymentAccountId : paymentAccountId // ignore: cast_nullable_to_non_nullable
as String,providerReference: freezed == providerReference ? _self.providerReference : providerReference // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
