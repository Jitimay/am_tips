// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QrCode {

 String get waiterId; String get token; String get url; DateTime get generatedAt; DateTime? get lastUsedAt;
/// Create a copy of QrCode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrCodeCopyWith<QrCode> get copyWith => _$QrCodeCopyWithImpl<QrCode>(this as QrCode, _$identity);

  /// Serializes this QrCode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrCode&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.token, token) || other.token == token)&&(identical(other.url, url) || other.url == url)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,waiterId,token,url,generatedAt,lastUsedAt);

@override
String toString() {
  return 'QrCode(waiterId: $waiterId, token: $token, url: $url, generatedAt: $generatedAt, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class $QrCodeCopyWith<$Res>  {
  factory $QrCodeCopyWith(QrCode value, $Res Function(QrCode) _then) = _$QrCodeCopyWithImpl;
@useResult
$Res call({
 String waiterId, String token, String url, DateTime generatedAt, DateTime? lastUsedAt
});




}
/// @nodoc
class _$QrCodeCopyWithImpl<$Res>
    implements $QrCodeCopyWith<$Res> {
  _$QrCodeCopyWithImpl(this._self, this._then);

  final QrCode _self;
  final $Res Function(QrCode) _then;

/// Create a copy of QrCode
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


/// Adds pattern-matching-related methods to [QrCode].
extension QrCodePatterns on QrCode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrCode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrCode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrCode value)  $default,){
final _that = this;
switch (_that) {
case _QrCode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrCode value)?  $default,){
final _that = this;
switch (_that) {
case _QrCode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String waiterId,  String token,  String url,  DateTime generatedAt,  DateTime? lastUsedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrCode() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String waiterId,  String token,  String url,  DateTime generatedAt,  DateTime? lastUsedAt)  $default,) {final _that = this;
switch (_that) {
case _QrCode():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String waiterId,  String token,  String url,  DateTime generatedAt,  DateTime? lastUsedAt)?  $default,) {final _that = this;
switch (_that) {
case _QrCode() when $default != null:
return $default(_that.waiterId,_that.token,_that.url,_that.generatedAt,_that.lastUsedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QrCode implements QrCode {
  const _QrCode({required this.waiterId, required this.token, required this.url, required this.generatedAt, this.lastUsedAt});
  factory _QrCode.fromJson(Map<String, dynamic> json) => _$QrCodeFromJson(json);

@override final  String waiterId;
@override final  String token;
@override final  String url;
@override final  DateTime generatedAt;
@override final  DateTime? lastUsedAt;

/// Create a copy of QrCode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrCodeCopyWith<_QrCode> get copyWith => __$QrCodeCopyWithImpl<_QrCode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QrCodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrCode&&(identical(other.waiterId, waiterId) || other.waiterId == waiterId)&&(identical(other.token, token) || other.token == token)&&(identical(other.url, url) || other.url == url)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,waiterId,token,url,generatedAt,lastUsedAt);

@override
String toString() {
  return 'QrCode(waiterId: $waiterId, token: $token, url: $url, generatedAt: $generatedAt, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class _$QrCodeCopyWith<$Res> implements $QrCodeCopyWith<$Res> {
  factory _$QrCodeCopyWith(_QrCode value, $Res Function(_QrCode) _then) = __$QrCodeCopyWithImpl;
@override @useResult
$Res call({
 String waiterId, String token, String url, DateTime generatedAt, DateTime? lastUsedAt
});




}
/// @nodoc
class __$QrCodeCopyWithImpl<$Res>
    implements _$QrCodeCopyWith<$Res> {
  __$QrCodeCopyWithImpl(this._self, this._then);

  final _QrCode _self;
  final $Res Function(_QrCode) _then;

/// Create a copy of QrCode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? waiterId = null,Object? token = null,Object? url = null,Object? generatedAt = null,Object? lastUsedAt = freezed,}) {
  return _then(_QrCode(
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
