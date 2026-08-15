// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_code_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QrCodeModel {

@JsonKey(name: 'waiter_id') String get waiterId; String get token; String get url;@JsonKey(name: 'generated_at') DateTime get generatedAt;@JsonKey(name: 'last_used_at') DateTime? get lastUsedAt;
/// Create a copy of QrCodeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrCodeModelCopyWith<QrCodeModel> get copyWith => _$QrCodeModelCopyWithImpl<QrCodeModel>(this as QrCodeModel, _$identity);

  /// Serializes this QrCodeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrCodeModel&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.token, token) || other.token == token)&&(identical(other.url, url) || other.url == url)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,waiterId,token,url,generatedAt,lastUsedAt);

@override
String toString() {
  return 'QrCodeModel(waiterId: $waiterId, token: $token, url: $url, generatedAt: $generatedAt, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class $QrCodeModelCopyWith<$Res>  {
  factory $QrCodeModelCopyWith(QrCodeModel value, $Res Function(QrCodeModel) _then) = _$QrCodeModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'waiter_id') String waiterId, String token, String url,@JsonKey(name: 'generated_at') DateTime generatedAt,@JsonKey(name: 'last_used_at') DateTime? lastUsedAt
});




}
/// @nodoc
class _$QrCodeModelCopyWithImpl<$Res>
    implements $QrCodeModelCopyWith<$Res> {
  _$QrCodeModelCopyWithImpl(this._self, this._then);

  final QrCodeModel _self;
  final $Res Function(QrCodeModel) _then;

/// Create a copy of QrCodeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? waiterId = null,Object? token = null,Object? url = null,Object? generatedAt = null,Object? lastUsedAt = freezed,}) {
  return _then(_self.copyWith(
waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QrCodeModel].
extension QrCodeModelPatterns on QrCodeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrCodeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrCodeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrCodeModel value)  $default,){
final _that = this;
switch (_that) {
case _QrCodeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrCodeModel value)?  $default,){
final _that = this;
switch (_that) {
case _QrCodeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'waiter_id')  String waiterId,  String token,  String url, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(name: 'last_used_at')  DateTime? lastUsedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrCodeModel() when $default != null:
return $default(_that.waiterId,_that.token,_that.url,_that.generatedAt,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'waiter_id')  String waiterId,  String token,  String url, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(name: 'last_used_at')  DateTime? lastUsedAt)  $default,) {final _that = this;
switch (_that) {
case _QrCodeModel():
return $default(_that.waiterId,_that.token,_that.url,_that.generatedAt,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'waiter_id')  String waiterId,  String token,  String url, @JsonKey(name: 'generated_at')  DateTime generatedAt, @JsonKey(name: 'last_used_at')  DateTime? lastUsedAt)?  $default,) {final _that = this;
switch (_that) {
case _QrCodeModel() when $default != null:
return $default(_that.waiterId,_that.token,_that.url,_that.generatedAt,_that.lastUsedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QrCodeModel implements QrCodeModel {
  const _QrCodeModel({@JsonKey(name: 'waiter_id') required this.waiterId, required this.token, required this.url, @JsonKey(name: 'generated_at') required this.generatedAt, @JsonKey(name: 'last_used_at') this.lastUsedAt});
  factory _QrCodeModel.fromJson(Map<String, dynamic> json) => _$QrCodeModelFromJson(json);

@override@JsonKey(name: 'waiter_id') final  String waiterId;
@override final  String token;
@override final  String url;
@override@JsonKey(name: 'generated_at') final  DateTime generatedAt;
@override@JsonKey(name: 'last_used_at') final  DateTime? lastUsedAt;

/// Create a copy of QrCodeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrCodeModelCopyWith<_QrCodeModel> get copyWith => __$QrCodeModelCopyWithImpl<_QrCodeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QrCodeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrCodeModel&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.token, token) || other.token == token)&&(identical(other.url, url) || other.url == url)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,waiterId,token,url,generatedAt,lastUsedAt);

@override
String toString() {
  return 'QrCodeModel(waiterId: $waiterId, token: $token, url: $url, generatedAt: $generatedAt, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class _$QrCodeModelCopyWith<$Res> implements $QrCodeModelCopyWith<$Res> {
  factory _$QrCodeModelCopyWith(_QrCodeModel value, $Res Function(_QrCodeModel) _then) = __$QrCodeModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'waiter_id') String waiterId, String token, String url,@JsonKey(name: 'generated_at') DateTime generatedAt,@JsonKey(name: 'last_used_at') DateTime? lastUsedAt
});




}
/// @nodoc
class __$QrCodeModelCopyWithImpl<$Res>
    implements _$QrCodeModelCopyWith<$Res> {
  __$QrCodeModelCopyWithImpl(this._self, this._then);

  final _QrCodeModel _self;
  final $Res Function(_QrCodeModel) _then;

/// Create a copy of QrCodeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? waiterId = null,Object? token = null,Object? url = null,Object? generatedAt = null,Object? lastUsedAt = freezed,}) {
  return _then(_QrCodeModel(
waiterId: null == waiterId ? _self.waiterId : waiterId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,generatedAt: null == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
