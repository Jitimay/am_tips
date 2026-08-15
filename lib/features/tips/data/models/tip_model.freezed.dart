// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TipModel {

 String get id;@JsonKey(name: 'waiter_id') String get waiterId; int get amount; String get currency; String get status; String? get message; int? get rating;@JsonKey(name: 'transaction_reference') String? get transactionReference;@JsonKey(name: 'payment_provider') String? get paymentProvider;@JsonKey(name: 'is_anonymous') bool get isAnonymous;@JsonKey(name: 'customer_name') String? get customerName;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of TipModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipModelCopyWith<TipModel> get copyWith => _$TipModelCopyWithImpl<TipModel>(this as TipModel, _$identity);

  /// Serializes this TipModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.paymentProvider, paymentProvider) || other.paymentProvider == paymentProvider)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,waiterId,amount,currency,status,message,rating,transactionReference,paymentProvider,isAnonymous,customerName,createdAt,updatedAt);

@override
String toString() {
  return 'TipModel(id: $id, waiterId: $waiterId, amount: $amount, currency: $currency, status: $status, message: $message, rating: $rating, transactionReference: $transactionReference, paymentProvider: $paymentProvider, isAnonymous: $isAnonymous, customerName: $customerName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TipModelCopyWith<$Res>  {
  factory $TipModelCopyWith(TipModel value, $Res Function(TipModel) _then) = _$TipModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'waiter_id') String waiterId, int amount, String currency, String status, String? message, int? rating,@JsonKey(name: 'transaction_reference') String? transactionReference,@JsonKey(name: 'payment_provider') String? paymentProvider,@JsonKey(name: 'is_anonymous') bool isAnonymous,@JsonKey(name: 'customer_name') String? customerName,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$TipModelCopyWithImpl<$Res>
    implements $TipModelCopyWith<$Res> {
  _$TipModelCopyWithImpl(this._self, this._then);

  final TipModel _self;
  final $Res Function(TipModel) _then;

/// Create a copy of TipModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? waiterId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? message = freezed,Object? rating = freezed,Object? transactionReference = freezed,Object? paymentProvider = freezed,Object? isAnonymous = null,Object? customerName = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String?,paymentProvider: freezed == paymentProvider ? _self.paymentProvider : paymentProvider // ignore: cast_nullable_to_non_nullable
as String?,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TipModel].
extension TipModelPatterns on TipModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipModel value)  $default,){
final _that = this;
switch (_that) {
case _TipModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipModel value)?  $default,){
final _that = this;
switch (_that) {
case _TipModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'waiter_id')  String waiterId,  int amount,  String currency,  String status,  String? message,  int? rating, @JsonKey(name: 'transaction_reference')  String? transactionReference, @JsonKey(name: 'payment_provider')  String? paymentProvider, @JsonKey(name: 'is_anonymous')  bool isAnonymous, @JsonKey(name: 'customer_name')  String? customerName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipModel() when $default != null:
return $default(_that.id,_that.waiterId,_that.amount,_that.currency,_that.status,_that.message,_that.rating,_that.transactionReference,_that.paymentProvider,_that.isAnonymous,_that.customerName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'waiter_id')  String waiterId,  int amount,  String currency,  String status,  String? message,  int? rating, @JsonKey(name: 'transaction_reference')  String? transactionReference, @JsonKey(name: 'payment_provider')  String? paymentProvider, @JsonKey(name: 'is_anonymous')  bool isAnonymous, @JsonKey(name: 'customer_name')  String? customerName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TipModel():
return $default(_that.id,_that.waiterId,_that.amount,_that.currency,_that.status,_that.message,_that.rating,_that.transactionReference,_that.paymentProvider,_that.isAnonymous,_that.customerName,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'waiter_id')  String waiterId,  int amount,  String currency,  String status,  String? message,  int? rating, @JsonKey(name: 'transaction_reference')  String? transactionReference, @JsonKey(name: 'payment_provider')  String? paymentProvider, @JsonKey(name: 'is_anonymous')  bool isAnonymous, @JsonKey(name: 'customer_name')  String? customerName, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TipModel() when $default != null:
return $default(_that.id,_that.waiterId,_that.amount,_that.currency,_that.status,_that.message,_that.rating,_that.transactionReference,_that.paymentProvider,_that.isAnonymous,_that.customerName,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipModel implements TipModel {
  const _TipModel({required this.id, @JsonKey(name: 'waiter_id') required this.waiterId, required this.amount, required this.currency, required this.status, this.message, this.rating, @JsonKey(name: 'transaction_reference') this.transactionReference, @JsonKey(name: 'payment_provider') this.paymentProvider, @JsonKey(name: 'is_anonymous') this.isAnonymous = false, @JsonKey(name: 'customer_name') this.customerName, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _TipModel.fromJson(Map<String, dynamic> json) => _$TipModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'waiter_id') final  String waiterId;
@override final  int amount;
@override final  String currency;
@override final  String status;
@override final  String? message;
@override final  int? rating;
@override@JsonKey(name: 'transaction_reference') final  String? transactionReference;
@override@JsonKey(name: 'payment_provider') final  String? paymentProvider;
@override@JsonKey(name: 'is_anonymous') final  bool isAnonymous;
@override@JsonKey(name: 'customer_name') final  String? customerName;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of TipModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipModelCopyWith<_TipModel> get copyWith => __$TipModelCopyWithImpl<_TipModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.paymentProvider, paymentProvider) || other.paymentProvider == paymentProvider)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,waiterId,amount,currency,status,message,rating,transactionReference,paymentProvider,isAnonymous,customerName,createdAt,updatedAt);

@override
String toString() {
  return 'TipModel(id: $id, waiterId: $waiterId, amount: $amount, currency: $currency, status: $status, message: $message, rating: $rating, transactionReference: $transactionReference, paymentProvider: $paymentProvider, isAnonymous: $isAnonymous, customerName: $customerName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TipModelCopyWith<$Res> implements $TipModelCopyWith<$Res> {
  factory _$TipModelCopyWith(_TipModel value, $Res Function(_TipModel) _then) = __$TipModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'waiter_id') String waiterId, int amount, String currency, String status, String? message, int? rating,@JsonKey(name: 'transaction_reference') String? transactionReference,@JsonKey(name: 'payment_provider') String? paymentProvider,@JsonKey(name: 'is_anonymous') bool isAnonymous,@JsonKey(name: 'customer_name') String? customerName,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$TipModelCopyWithImpl<$Res>
    implements _$TipModelCopyWith<$Res> {
  __$TipModelCopyWithImpl(this._self, this._then);

  final _TipModel _self;
  final $Res Function(_TipModel) _then;

/// Create a copy of TipModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? waiterId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? message = freezed,Object? rating = freezed,Object? transactionReference = freezed,Object? paymentProvider = freezed,Object? isAnonymous = null,Object? customerName = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_TipModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,transactionReference: freezed == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String?,paymentProvider: freezed == paymentProvider ? _self.paymentProvider : paymentProvider // ignore: cast_nullable_to_non_nullable
as String?,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TipStatsModel {

@JsonKey(name: 'today_total') int get todayTotal;@JsonKey(name: 'week_total') int get weekTotal;@JsonKey(name: 'all_time_total') int get allTimeTotal; String get currency;@JsonKey(name: 'today_count') int get todayCount;@JsonKey(name: 'week_count') int get weekCount;@JsonKey(name: 'all_time_count') int get allTimeCount;
/// Create a copy of TipStatsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipStatsModelCopyWith<TipStatsModel> get copyWith => _$TipStatsModelCopyWithImpl<TipStatsModel>(this as TipStatsModel, _$identity);

  /// Serializes this TipStatsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipStatsModel&&(identical(other.todayTotal, todayTotal) || other.todayTotal == todayTotal)&&(identical(other.weekTotal, weekTotal) || other.weekTotal == weekTotal)&&(identical(other.allTimeTotal, allTimeTotal) || other.allTimeTotal == allTimeTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.todayCount, todayCount) || other.todayCount == todayCount)&&(identical(other.weekCount, weekCount) || other.weekCount == weekCount)&&(identical(other.allTimeCount, allTimeCount) || other.allTimeCount == allTimeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayTotal,weekTotal,allTimeTotal,currency,todayCount,weekCount,allTimeCount);

@override
String toString() {
  return 'TipStatsModel(todayTotal: $todayTotal, weekTotal: $weekTotal, allTimeTotal: $allTimeTotal, currency: $currency, todayCount: $todayCount, weekCount: $weekCount, allTimeCount: $allTimeCount)';
}


}

/// @nodoc
abstract mixin class $TipStatsModelCopyWith<$Res>  {
  factory $TipStatsModelCopyWith(TipStatsModel value, $Res Function(TipStatsModel) _then) = _$TipStatsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'today_total') int todayTotal,@JsonKey(name: 'week_total') int weekTotal,@JsonKey(name: 'all_time_total') int allTimeTotal, String currency,@JsonKey(name: 'today_count') int todayCount,@JsonKey(name: 'week_count') int weekCount,@JsonKey(name: 'all_time_count') int allTimeCount
});




}
/// @nodoc
class _$TipStatsModelCopyWithImpl<$Res>
    implements $TipStatsModelCopyWith<$Res> {
  _$TipStatsModelCopyWithImpl(this._self, this._then);

  final TipStatsModel _self;
  final $Res Function(TipStatsModel) _then;

/// Create a copy of TipStatsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayTotal = null,Object? weekTotal = null,Object? allTimeTotal = null,Object? currency = null,Object? todayCount = null,Object? weekCount = null,Object? allTimeCount = null,}) {
  return _then(_self.copyWith(
todayTotal: null == todayTotal ? _self.todayTotal : todayTotal // ignore: cast_nullable_to_non_nullable
as int,weekTotal: null == weekTotal ? _self.weekTotal : weekTotal // ignore: cast_nullable_to_non_nullable
as int,allTimeTotal: null == allTimeTotal ? _self.allTimeTotal : allTimeTotal // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,todayCount: null == todayCount ? _self.todayCount : todayCount // ignore: cast_nullable_to_non_nullable
as int,weekCount: null == weekCount ? _self.weekCount : weekCount // ignore: cast_nullable_to_non_nullable
as int,allTimeCount: null == allTimeCount ? _self.allTimeCount : allTimeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TipStatsModel].
extension TipStatsModelPatterns on TipStatsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipStatsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipStatsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipStatsModel value)  $default,){
final _that = this;
switch (_that) {
case _TipStatsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipStatsModel value)?  $default,){
final _that = this;
switch (_that) {
case _TipStatsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'today_total')  int todayTotal, @JsonKey(name: 'week_total')  int weekTotal, @JsonKey(name: 'all_time_total')  int allTimeTotal,  String currency, @JsonKey(name: 'today_count')  int todayCount, @JsonKey(name: 'week_count')  int weekCount, @JsonKey(name: 'all_time_count')  int allTimeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipStatsModel() when $default != null:
return $default(_that.todayTotal,_that.weekTotal,_that.allTimeTotal,_that.currency,_that.todayCount,_that.weekCount,_that.allTimeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'today_total')  int todayTotal, @JsonKey(name: 'week_total')  int weekTotal, @JsonKey(name: 'all_time_total')  int allTimeTotal,  String currency, @JsonKey(name: 'today_count')  int todayCount, @JsonKey(name: 'week_count')  int weekCount, @JsonKey(name: 'all_time_count')  int allTimeCount)  $default,) {final _that = this;
switch (_that) {
case _TipStatsModel():
return $default(_that.todayTotal,_that.weekTotal,_that.allTimeTotal,_that.currency,_that.todayCount,_that.weekCount,_that.allTimeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'today_total')  int todayTotal, @JsonKey(name: 'week_total')  int weekTotal, @JsonKey(name: 'all_time_total')  int allTimeTotal,  String currency, @JsonKey(name: 'today_count')  int todayCount, @JsonKey(name: 'week_count')  int weekCount, @JsonKey(name: 'all_time_count')  int allTimeCount)?  $default,) {final _that = this;
switch (_that) {
case _TipStatsModel() when $default != null:
return $default(_that.todayTotal,_that.weekTotal,_that.allTimeTotal,_that.currency,_that.todayCount,_that.weekCount,_that.allTimeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipStatsModel implements TipStatsModel {
  const _TipStatsModel({@JsonKey(name: 'today_total') required this.todayTotal, @JsonKey(name: 'week_total') required this.weekTotal, @JsonKey(name: 'all_time_total') required this.allTimeTotal, required this.currency, @JsonKey(name: 'today_count') required this.todayCount, @JsonKey(name: 'week_count') required this.weekCount, @JsonKey(name: 'all_time_count') required this.allTimeCount});
  factory _TipStatsModel.fromJson(Map<String, dynamic> json) => _$TipStatsModelFromJson(json);

@override@JsonKey(name: 'today_total') final  int todayTotal;
@override@JsonKey(name: 'week_total') final  int weekTotal;
@override@JsonKey(name: 'all_time_total') final  int allTimeTotal;
@override final  String currency;
@override@JsonKey(name: 'today_count') final  int todayCount;
@override@JsonKey(name: 'week_count') final  int weekCount;
@override@JsonKey(name: 'all_time_count') final  int allTimeCount;

/// Create a copy of TipStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipStatsModelCopyWith<_TipStatsModel> get copyWith => __$TipStatsModelCopyWithImpl<_TipStatsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipStatsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipStatsModel&&(identical(other.todayTotal, todayTotal) || other.todayTotal == todayTotal)&&(identical(other.weekTotal, weekTotal) || other.weekTotal == weekTotal)&&(identical(other.allTimeTotal, allTimeTotal) || other.allTimeTotal == allTimeTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.todayCount, todayCount) || other.todayCount == todayCount)&&(identical(other.weekCount, weekCount) || other.weekCount == weekCount)&&(identical(other.allTimeCount, allTimeCount) || other.allTimeCount == allTimeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayTotal,weekTotal,allTimeTotal,currency,todayCount,weekCount,allTimeCount);

@override
String toString() {
  return 'TipStatsModel(todayTotal: $todayTotal, weekTotal: $weekTotal, allTimeTotal: $allTimeTotal, currency: $currency, todayCount: $todayCount, weekCount: $weekCount, allTimeCount: $allTimeCount)';
}


}

/// @nodoc
abstract mixin class _$TipStatsModelCopyWith<$Res> implements $TipStatsModelCopyWith<$Res> {
  factory _$TipStatsModelCopyWith(_TipStatsModel value, $Res Function(_TipStatsModel) _then) = __$TipStatsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'today_total') int todayTotal,@JsonKey(name: 'week_total') int weekTotal,@JsonKey(name: 'all_time_total') int allTimeTotal, String currency,@JsonKey(name: 'today_count') int todayCount,@JsonKey(name: 'week_count') int weekCount,@JsonKey(name: 'all_time_count') int allTimeCount
});




}
/// @nodoc
class __$TipStatsModelCopyWithImpl<$Res>
    implements _$TipStatsModelCopyWith<$Res> {
  __$TipStatsModelCopyWithImpl(this._self, this._then);

  final _TipStatsModel _self;
  final $Res Function(_TipStatsModel) _then;

/// Create a copy of TipStatsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayTotal = null,Object? weekTotal = null,Object? allTimeTotal = null,Object? currency = null,Object? todayCount = null,Object? weekCount = null,Object? allTimeCount = null,}) {
  return _then(_TipStatsModel(
todayTotal: null == todayTotal ? _self.todayTotal : todayTotal // ignore: cast_nullable_to_non_nullable
as int,weekTotal: null == weekTotal ? _self.weekTotal : weekTotal // ignore: cast_nullable_to_non_nullable
as int,allTimeTotal: null == allTimeTotal ? _self.allTimeTotal : allTimeTotal // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,todayCount: null == todayCount ? _self.todayCount : todayCount // ignore: cast_nullable_to_non_nullable
as int,weekCount: null == weekCount ? _self.weekCount : weekCount // ignore: cast_nullable_to_non_nullable
as int,allTimeCount: null == allTimeCount ? _self.allTimeCount : allTimeCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
