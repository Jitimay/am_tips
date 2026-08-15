// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Tip {

 String get id; String get waiterId; int get amount; String get currency; TipStatus get status; String? get message; int? get rating; String? get transactionReference; String? get paymentProvider; bool get isAnonymous; String? get customerName;// null if anonymous
 DateTime get createdAt; DateTime? get updatedAt;
/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipCopyWith<Tip> get copyWith => _$TipCopyWithImpl<Tip>(this as Tip, _$identity);

  /// Serializes this Tip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tip&&(identical(other.id, id) || other.id == id)&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.paymentProvider, paymentProvider) || other.paymentProvider == paymentProvider)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,waiterId,amount,currency,status,message,rating,transactionReference,paymentProvider,isAnonymous,customerName,createdAt,updatedAt);

@override
String toString() {
  return 'Tip(id: $id, waiterId: $waiterId, amount: $amount, currency: $currency, status: $status, message: $message, rating: $rating, transactionReference: $transactionReference, paymentProvider: $paymentProvider, isAnonymous: $isAnonymous, customerName: $customerName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TipCopyWith<$Res>  {
  factory $TipCopyWith(Tip value, $Res Function(Tip) _then) = _$TipCopyWithImpl;
@useResult
$Res call({
 String id, String waiterId, int amount, String currency, TipStatus status, String? message, int? rating, String? transactionReference, String? paymentProvider, bool isAnonymous, String? customerName, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$TipCopyWithImpl<$Res>
    implements $TipCopyWith<$Res> {
  _$TipCopyWithImpl(this._self, this._then);

  final Tip _self;
  final $Res Function(Tip) _then;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? waiterId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? message = freezed,Object? rating = freezed,Object? transactionReference = freezed,Object? paymentProvider = freezed,Object? isAnonymous = null,Object? customerName = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TipStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [Tip].
extension TipPatterns on Tip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tip value)  $default,){
final _that = this;
switch (_that) {
case _Tip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tip value)?  $default,){
final _that = this;
switch (_that) {
case _Tip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String waiterId,  int amount,  String currency,  TipStatus status,  String? message,  int? rating,  String? transactionReference,  String? paymentProvider,  bool isAnonymous,  String? customerName,  DateTime createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tip() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String waiterId,  int amount,  String currency,  TipStatus status,  String? message,  int? rating,  String? transactionReference,  String? paymentProvider,  bool isAnonymous,  String? customerName,  DateTime createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Tip():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String waiterId,  int amount,  String currency,  TipStatus status,  String? message,  int? rating,  String? transactionReference,  String? paymentProvider,  bool isAnonymous,  String? customerName,  DateTime createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Tip() when $default != null:
return $default(_that.id,_that.waiterId,_that.amount,_that.currency,_that.status,_that.message,_that.rating,_that.transactionReference,_that.paymentProvider,_that.isAnonymous,_that.customerName,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tip implements Tip {
  const _Tip({required this.id, required this.waiterId, required this.amount, required this.currency, required this.status, this.message, this.rating, this.transactionReference, this.paymentProvider, this.isAnonymous = false, this.customerName, required this.createdAt, this.updatedAt});
  factory _Tip.fromJson(Map<String, dynamic> json) => _$TipFromJson(json);

@override final  String id;
@override final  String waiterId;
@override final  int amount;
@override final  String currency;
@override final  TipStatus status;
@override final  String? message;
@override final  int? rating;
@override final  String? transactionReference;
@override final  String? paymentProvider;
@override@JsonKey() final  bool isAnonymous;
@override final  String? customerName;
// null if anonymous
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipCopyWith<_Tip> get copyWith => __$TipCopyWithImpl<_Tip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tip&&(identical(other.id, id) || other.id == id)&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.paymentProvider, paymentProvider) || other.paymentProvider == paymentProvider)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,waiterId,amount,currency,status,message,rating,transactionReference,paymentProvider,isAnonymous,customerName,createdAt,updatedAt);

@override
String toString() {
  return 'Tip(id: $id, waiterId: $waiterId, amount: $amount, currency: $currency, status: $status, message: $message, rating: $rating, transactionReference: $transactionReference, paymentProvider: $paymentProvider, isAnonymous: $isAnonymous, customerName: $customerName, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TipCopyWith<$Res> implements $TipCopyWith<$Res> {
  factory _$TipCopyWith(_Tip value, $Res Function(_Tip) _then) = __$TipCopyWithImpl;
@override @useResult
$Res call({
 String id, String waiterId, int amount, String currency, TipStatus status, String? message, int? rating, String? transactionReference, String? paymentProvider, bool isAnonymous, String? customerName, DateTime createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$TipCopyWithImpl<$Res>
    implements _$TipCopyWith<$Res> {
  __$TipCopyWithImpl(this._self, this._then);

  final _Tip _self;
  final $Res Function(_Tip) _then;

/// Create a copy of Tip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? waiterId = null,Object? amount = null,Object? currency = null,Object? status = null,Object? message = freezed,Object? rating = freezed,Object? transactionReference = freezed,Object? paymentProvider = freezed,Object? isAnonymous = null,Object? customerName = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_Tip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TipStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
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
mixin _$TipStats {

 int get todayTotal; int get weekTotal; int get allTimeTotal; String get currency; int get todayCount; int get weekCount; int get allTimeCount;
/// Create a copy of TipStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TipStatsCopyWith<TipStats> get copyWith => _$TipStatsCopyWithImpl<TipStats>(this as TipStats, _$identity);

  /// Serializes this TipStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TipStats&&(identical(other.todayTotal, todayTotal) || other.todayTotal == todayTotal)&&(identical(other.weekTotal, weekTotal) || other.weekTotal == weekTotal)&&(identical(other.allTimeTotal, allTimeTotal) || other.allTimeTotal == allTimeTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.todayCount, todayCount) || other.todayCount == todayCount)&&(identical(other.weekCount, weekCount) || other.weekCount == weekCount)&&(identical(other.allTimeCount, allTimeCount) || other.allTimeCount == allTimeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayTotal,weekTotal,allTimeTotal,currency,todayCount,weekCount,allTimeCount);

@override
String toString() {
  return 'TipStats(todayTotal: $todayTotal, weekTotal: $weekTotal, allTimeTotal: $allTimeTotal, currency: $currency, todayCount: $todayCount, weekCount: $weekCount, allTimeCount: $allTimeCount)';
}


}

/// @nodoc
abstract mixin class $TipStatsCopyWith<$Res>  {
  factory $TipStatsCopyWith(TipStats value, $Res Function(TipStats) _then) = _$TipStatsCopyWithImpl;
@useResult
$Res call({
 int todayTotal, int weekTotal, int allTimeTotal, String currency, int todayCount, int weekCount, int allTimeCount
});




}
/// @nodoc
class _$TipStatsCopyWithImpl<$Res>
    implements $TipStatsCopyWith<$Res> {
  _$TipStatsCopyWithImpl(this._self, this._then);

  final TipStats _self;
  final $Res Function(TipStats) _then;

/// Create a copy of TipStats
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


/// Adds pattern-matching-related methods to [TipStats].
extension TipStatsPatterns on TipStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TipStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TipStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TipStats value)  $default,){
final _that = this;
switch (_that) {
case _TipStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TipStats value)?  $default,){
final _that = this;
switch (_that) {
case _TipStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int todayTotal,  int weekTotal,  int allTimeTotal,  String currency,  int todayCount,  int weekCount,  int allTimeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TipStats() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int todayTotal,  int weekTotal,  int allTimeTotal,  String currency,  int todayCount,  int weekCount,  int allTimeCount)  $default,) {final _that = this;
switch (_that) {
case _TipStats():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int todayTotal,  int weekTotal,  int allTimeTotal,  String currency,  int todayCount,  int weekCount,  int allTimeCount)?  $default,) {final _that = this;
switch (_that) {
case _TipStats() when $default != null:
return $default(_that.todayTotal,_that.weekTotal,_that.allTimeTotal,_that.currency,_that.todayCount,_that.weekCount,_that.allTimeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TipStats implements TipStats {
  const _TipStats({required this.todayTotal, required this.weekTotal, required this.allTimeTotal, required this.currency, required this.todayCount, required this.weekCount, required this.allTimeCount});
  factory _TipStats.fromJson(Map<String, dynamic> json) => _$TipStatsFromJson(json);

@override final  int todayTotal;
@override final  int weekTotal;
@override final  int allTimeTotal;
@override final  String currency;
@override final  int todayCount;
@override final  int weekCount;
@override final  int allTimeCount;

/// Create a copy of TipStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TipStatsCopyWith<_TipStats> get copyWith => __$TipStatsCopyWithImpl<_TipStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TipStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TipStats&&(identical(other.todayTotal, todayTotal) || other.todayTotal == todayTotal)&&(identical(other.weekTotal, weekTotal) || other.weekTotal == weekTotal)&&(identical(other.allTimeTotal, allTimeTotal) || other.allTimeTotal == allTimeTotal)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.todayCount, todayCount) || other.todayCount == todayCount)&&(identical(other.weekCount, weekCount) || other.weekCount == weekCount)&&(identical(other.allTimeCount, allTimeCount) || other.allTimeCount == allTimeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,todayTotal,weekTotal,allTimeTotal,currency,todayCount,weekCount,allTimeCount);

@override
String toString() {
  return 'TipStats(todayTotal: $todayTotal, weekTotal: $weekTotal, allTimeTotal: $allTimeTotal, currency: $currency, todayCount: $todayCount, weekCount: $weekCount, allTimeCount: $allTimeCount)';
}


}

/// @nodoc
abstract mixin class _$TipStatsCopyWith<$Res> implements $TipStatsCopyWith<$Res> {
  factory _$TipStatsCopyWith(_TipStats value, $Res Function(_TipStats) _then) = __$TipStatsCopyWithImpl;
@override @useResult
$Res call({
 int todayTotal, int weekTotal, int allTimeTotal, String currency, int todayCount, int weekCount, int allTimeCount
});




}
/// @nodoc
class __$TipStatsCopyWithImpl<$Res>
    implements _$TipStatsCopyWith<$Res> {
  __$TipStatsCopyWithImpl(this._self, this._then);

  final _TipStats _self;
  final $Res Function(_TipStats) _then;

/// Create a copy of TipStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayTotal = null,Object? weekTotal = null,Object? allTimeTotal = null,Object? currency = null,Object? todayCount = null,Object? weekCount = null,Object? allTimeCount = null,}) {
  return _then(_TipStats(
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
