// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletModel {

@JsonKey(name: 'waiter_id') String get waiterId;@JsonKey(name: 'available_balance') int get availableBalance;@JsonKey(name: 'pending_balance') int get pendingBalance; String get currency;@JsonKey(name: 'last_updated_at') DateTime? get lastUpdatedAt;
/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletModelCopyWith<WalletModel> get copyWith => _$WalletModelCopyWithImpl<WalletModel>(this as WalletModel, _$identity);

  /// Serializes this WalletModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletModel&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.pendingBalance, pendingBalance) || other.pendingBalance == pendingBalance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,waiterId,availableBalance,pendingBalance,currency,lastUpdatedAt);

@override
String toString() {
  return 'WalletModel(waiterId: $waiterId, availableBalance: $availableBalance, pendingBalance: $pendingBalance, currency: $currency, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class $WalletModelCopyWith<$Res>  {
  factory $WalletModelCopyWith(WalletModel value, $Res Function(WalletModel) _then) = _$WalletModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'waiter_id') String waiterId,@JsonKey(name: 'available_balance') int availableBalance,@JsonKey(name: 'pending_balance') int pendingBalance, String currency,@JsonKey(name: 'last_updated_at') DateTime? lastUpdatedAt
});




}
/// @nodoc
class _$WalletModelCopyWithImpl<$Res>
    implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._self, this._then);

  final WalletModel _self;
  final $Res Function(WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? waiterId = null,Object? availableBalance = null,Object? pendingBalance = null,Object? currency = null,Object? lastUpdatedAt = freezed,}) {
  return _then(_self.copyWith(
waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as int,pendingBalance: null == pendingBalance ? _self.pendingBalance : pendingBalance // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletModel].
extension WalletModelPatterns on WalletModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'waiter_id')  String waiterId, @JsonKey(name: 'available_balance')  int availableBalance, @JsonKey(name: 'pending_balance')  int pendingBalance,  String currency, @JsonKey(name: 'last_updated_at')  DateTime? lastUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.waiterId,_that.availableBalance,_that.pendingBalance,_that.currency,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'waiter_id')  String waiterId, @JsonKey(name: 'available_balance')  int availableBalance, @JsonKey(name: 'pending_balance')  int pendingBalance,  String currency, @JsonKey(name: 'last_updated_at')  DateTime? lastUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _WalletModel():
return $default(_that.waiterId,_that.availableBalance,_that.pendingBalance,_that.currency,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'waiter_id')  String waiterId, @JsonKey(name: 'available_balance')  int availableBalance, @JsonKey(name: 'pending_balance')  int pendingBalance,  String currency, @JsonKey(name: 'last_updated_at')  DateTime? lastUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.waiterId,_that.availableBalance,_that.pendingBalance,_that.currency,_that.lastUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletModel implements WalletModel {
  const _WalletModel({@JsonKey(name: 'waiter_id') required this.waiterId, @JsonKey(name: 'available_balance') required this.availableBalance, @JsonKey(name: 'pending_balance') this.pendingBalance = 0, required this.currency, @JsonKey(name: 'last_updated_at') this.lastUpdatedAt});
  factory _WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

@override@JsonKey(name: 'waiter_id') final  String waiterId;
@override@JsonKey(name: 'available_balance') final  int availableBalance;
@override@JsonKey(name: 'pending_balance') final  int pendingBalance;
@override final  String currency;
@override@JsonKey(name: 'last_updated_at') final  DateTime? lastUpdatedAt;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletModelCopyWith<_WalletModel> get copyWith => __$WalletModelCopyWithImpl<_WalletModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletModel&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&(identical(other.pendingBalance, pendingBalance) || other.pendingBalance == pendingBalance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,waiterId,availableBalance,pendingBalance,currency,lastUpdatedAt);

@override
String toString() {
  return 'WalletModel(waiterId: $waiterId, availableBalance: $availableBalance, pendingBalance: $pendingBalance, currency: $currency, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class _$WalletModelCopyWith<$Res> implements $WalletModelCopyWith<$Res> {
  factory _$WalletModelCopyWith(_WalletModel value, $Res Function(_WalletModel) _then) = __$WalletModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'waiter_id') String waiterId,@JsonKey(name: 'available_balance') int availableBalance,@JsonKey(name: 'pending_balance') int pendingBalance, String currency,@JsonKey(name: 'last_updated_at') DateTime? lastUpdatedAt
});




}
/// @nodoc
class __$WalletModelCopyWithImpl<$Res>
    implements _$WalletModelCopyWith<$Res> {
  __$WalletModelCopyWithImpl(this._self, this._then);

  final _WalletModel _self;
  final $Res Function(_WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? waiterId = null,Object? availableBalance = null,Object? pendingBalance = null,Object? currency = null,Object? lastUpdatedAt = freezed,}) {
  return _then(_WalletModel(
waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as int,pendingBalance: null == pendingBalance ? _self.pendingBalance : pendingBalance // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$WalletTransactionModel {

 String get id; String get type; int get amount; String get currency;@JsonKey(name: 'is_credit') bool get isCredit; String? get reference; String? get description;@JsonKey(name: 'created_at') DateTime get createdAt;
/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletTransactionModelCopyWith<WalletTransactionModel> get copyWith => _$WalletTransactionModelCopyWithImpl<WalletTransactionModel>(this as WalletTransactionModel, _$identity);

  /// Serializes this WalletTransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isCredit, isCredit) || other.isCredit == isCredit)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,currency,isCredit,reference,description,createdAt);

@override
String toString() {
  return 'WalletTransactionModel(id: $id, type: $type, amount: $amount, currency: $currency, isCredit: $isCredit, reference: $reference, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $WalletTransactionModelCopyWith<$Res>  {
  factory $WalletTransactionModelCopyWith(WalletTransactionModel value, $Res Function(WalletTransactionModel) _then) = _$WalletTransactionModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, int amount, String currency,@JsonKey(name: 'is_credit') bool isCredit, String? reference, String? description,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class _$WalletTransactionModelCopyWithImpl<$Res>
    implements $WalletTransactionModelCopyWith<$Res> {
  _$WalletTransactionModelCopyWithImpl(this._self, this._then);

  final WalletTransactionModel _self;
  final $Res Function(WalletTransactionModel) _then;

/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? currency = null,Object? isCredit = null,Object? reference = freezed,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isCredit: null == isCredit ? _self.isCredit : isCredit // ignore: cast_nullable_to_non_nullable
as bool,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletTransactionModel].
extension WalletTransactionModelPatterns on WalletTransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletTransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletTransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletTransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  int amount,  String currency, @JsonKey(name: 'is_credit')  bool isCredit,  String? reference,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.currency,_that.isCredit,_that.reference,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  int amount,  String currency, @JsonKey(name: 'is_credit')  bool isCredit,  String? reference,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionModel():
return $default(_that.id,_that.type,_that.amount,_that.currency,_that.isCredit,_that.reference,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  int amount,  String currency, @JsonKey(name: 'is_credit')  bool isCredit,  String? reference,  String? description, @JsonKey(name: 'created_at')  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _WalletTransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.currency,_that.isCredit,_that.reference,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletTransactionModel implements WalletTransactionModel {
  const _WalletTransactionModel({required this.id, required this.type, required this.amount, required this.currency, @JsonKey(name: 'is_credit') required this.isCredit, this.reference, this.description, @JsonKey(name: 'created_at') required this.createdAt});
  factory _WalletTransactionModel.fromJson(Map<String, dynamic> json) => _$WalletTransactionModelFromJson(json);

@override final  String id;
@override final  String type;
@override final  int amount;
@override final  String currency;
@override@JsonKey(name: 'is_credit') final  bool isCredit;
@override final  String? reference;
@override final  String? description;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;

/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletTransactionModelCopyWith<_WalletTransactionModel> get copyWith => __$WalletTransactionModelCopyWithImpl<_WalletTransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletTransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.isCredit, isCredit) || other.isCredit == isCredit)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,currency,isCredit,reference,description,createdAt);

@override
String toString() {
  return 'WalletTransactionModel(id: $id, type: $type, amount: $amount, currency: $currency, isCredit: $isCredit, reference: $reference, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$WalletTransactionModelCopyWith<$Res> implements $WalletTransactionModelCopyWith<$Res> {
  factory _$WalletTransactionModelCopyWith(_WalletTransactionModel value, $Res Function(_WalletTransactionModel) _then) = __$WalletTransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, int amount, String currency,@JsonKey(name: 'is_credit') bool isCredit, String? reference, String? description,@JsonKey(name: 'created_at') DateTime createdAt
});




}
/// @nodoc
class __$WalletTransactionModelCopyWithImpl<$Res>
    implements _$WalletTransactionModelCopyWith<$Res> {
  __$WalletTransactionModelCopyWithImpl(this._self, this._then);

  final _WalletTransactionModel _self;
  final $Res Function(_WalletTransactionModel) _then;

/// Create a copy of WalletTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? currency = null,Object? isCredit = null,Object? reference = freezed,Object? description = freezed,Object? createdAt = null,}) {
  return _then(_WalletTransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,isCredit: null == isCredit ? _self.isCredit : isCredit // ignore: cast_nullable_to_non_nullable
as bool,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
