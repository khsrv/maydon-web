// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AppFailure _$AppFailureFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'network':
          return _Network.fromJson(
            json
          );
                case 'unauthorized':
          return _Unauthorized.fromJson(
            json
          );
                case 'server':
          return _Server.fromJson(
            json
          );
                case 'timeout':
          return _Timeout.fromJson(
            json
          );
                case 'serialization':
          return _Serialization.fromJson(
            json
          );
                case 'cache':
          return _Cache.fromJson(
            json
          );
                case 'offline':
          return _Offline.fromJson(
            json
          );
                case 'unknown':
          return _Unknown.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'AppFailure',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$AppFailure {

 String? get message;
/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppFailureCopyWith<AppFailure> get copyWith => _$AppFailureCopyWithImpl<AppFailure>(this as AppFailure, _$identity);

  /// Serializes this AppFailure to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFailure&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AppFailureCopyWith<$Res>  {
  factory $AppFailureCopyWith(AppFailure value, $Res Function(AppFailure) _then) = _$AppFailureCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$AppFailureCopyWithImpl<$Res>
    implements $AppFailureCopyWith<$Res> {
  _$AppFailureCopyWithImpl(this._self, this._then);

  final AppFailure _self;
  final $Res Function(AppFailure) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppFailure].
extension AppFailurePatterns on AppFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Network value)?  network,TResult Function( _Unauthorized value)?  unauthorized,TResult Function( _Server value)?  server,TResult Function( _Timeout value)?  timeout,TResult Function( _Serialization value)?  serialization,TResult Function( _Cache value)?  cache,TResult Function( _Offline value)?  offline,TResult Function( _Unknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Network() when network != null:
return network(_that);case _Unauthorized() when unauthorized != null:
return unauthorized(_that);case _Server() when server != null:
return server(_that);case _Timeout() when timeout != null:
return timeout(_that);case _Serialization() when serialization != null:
return serialization(_that);case _Cache() when cache != null:
return cache(_that);case _Offline() when offline != null:
return offline(_that);case _Unknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Network value)  network,required TResult Function( _Unauthorized value)  unauthorized,required TResult Function( _Server value)  server,required TResult Function( _Timeout value)  timeout,required TResult Function( _Serialization value)  serialization,required TResult Function( _Cache value)  cache,required TResult Function( _Offline value)  offline,required TResult Function( _Unknown value)  unknown,}){
final _that = this;
switch (_that) {
case _Network():
return network(_that);case _Unauthorized():
return unauthorized(_that);case _Server():
return server(_that);case _Timeout():
return timeout(_that);case _Serialization():
return serialization(_that);case _Cache():
return cache(_that);case _Offline():
return offline(_that);case _Unknown():
return unknown(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Network value)?  network,TResult? Function( _Unauthorized value)?  unauthorized,TResult? Function( _Server value)?  server,TResult? Function( _Timeout value)?  timeout,TResult? Function( _Serialization value)?  serialization,TResult? Function( _Cache value)?  cache,TResult? Function( _Offline value)?  offline,TResult? Function( _Unknown value)?  unknown,}){
final _that = this;
switch (_that) {
case _Network() when network != null:
return network(_that);case _Unauthorized() when unauthorized != null:
return unauthorized(_that);case _Server() when server != null:
return server(_that);case _Timeout() when timeout != null:
return timeout(_that);case _Serialization() when serialization != null:
return serialization(_that);case _Cache() when cache != null:
return cache(_that);case _Offline() when offline != null:
return offline(_that);case _Unknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? message,  int? statusCode)?  network,TResult Function( String? message)?  unauthorized,TResult Function( String? message,  int? statusCode)?  server,TResult Function( String? message)?  timeout,TResult Function( String? message)?  serialization,TResult Function( String? message)?  cache,TResult Function( String? message)?  offline,TResult Function( String? message)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Network() when network != null:
return network(_that.message,_that.statusCode);case _Unauthorized() when unauthorized != null:
return unauthorized(_that.message);case _Server() when server != null:
return server(_that.message,_that.statusCode);case _Timeout() when timeout != null:
return timeout(_that.message);case _Serialization() when serialization != null:
return serialization(_that.message);case _Cache() when cache != null:
return cache(_that.message);case _Offline() when offline != null:
return offline(_that.message);case _Unknown() when unknown != null:
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? message,  int? statusCode)  network,required TResult Function( String? message)  unauthorized,required TResult Function( String? message,  int? statusCode)  server,required TResult Function( String? message)  timeout,required TResult Function( String? message)  serialization,required TResult Function( String? message)  cache,required TResult Function( String? message)  offline,required TResult Function( String? message)  unknown,}) {final _that = this;
switch (_that) {
case _Network():
return network(_that.message,_that.statusCode);case _Unauthorized():
return unauthorized(_that.message);case _Server():
return server(_that.message,_that.statusCode);case _Timeout():
return timeout(_that.message);case _Serialization():
return serialization(_that.message);case _Cache():
return cache(_that.message);case _Offline():
return offline(_that.message);case _Unknown():
return unknown(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? message,  int? statusCode)?  network,TResult? Function( String? message)?  unauthorized,TResult? Function( String? message,  int? statusCode)?  server,TResult? Function( String? message)?  timeout,TResult? Function( String? message)?  serialization,TResult? Function( String? message)?  cache,TResult? Function( String? message)?  offline,TResult? Function( String? message)?  unknown,}) {final _that = this;
switch (_that) {
case _Network() when network != null:
return network(_that.message,_that.statusCode);case _Unauthorized() when unauthorized != null:
return unauthorized(_that.message);case _Server() when server != null:
return server(_that.message,_that.statusCode);case _Timeout() when timeout != null:
return timeout(_that.message);case _Serialization() when serialization != null:
return serialization(_that.message);case _Cache() when cache != null:
return cache(_that.message);case _Offline() when offline != null:
return offline(_that.message);case _Unknown() when unknown != null:
return unknown(_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Network implements AppFailure {
  const _Network({this.message, this.statusCode, final  String? $type}): $type = $type ?? 'network';
  factory _Network.fromJson(Map<String, dynamic> json) => _$NetworkFromJson(json);

@override final  String? message;
 final  int? statusCode;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkCopyWith<_Network> get copyWith => __$NetworkCopyWithImpl<_Network>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Network&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,statusCode);

@override
String toString() {
  return 'AppFailure.network(message: $message, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$NetworkCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$NetworkCopyWith(_Network value, $Res Function(_Network) _then) = __$NetworkCopyWithImpl;
@override @useResult
$Res call({
 String? message, int? statusCode
});




}
/// @nodoc
class __$NetworkCopyWithImpl<$Res>
    implements _$NetworkCopyWith<$Res> {
  __$NetworkCopyWithImpl(this._self, this._then);

  final _Network _self;
  final $Res Function(_Network) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? statusCode = freezed,}) {
  return _then(_Network(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Unauthorized implements AppFailure {
  const _Unauthorized({this.message, final  String? $type}): $type = $type ?? 'unauthorized';
  factory _Unauthorized.fromJson(Map<String, dynamic> json) => _$UnauthorizedFromJson(json);

@override final  String? message;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnauthorizedCopyWith<_Unauthorized> get copyWith => __$UnauthorizedCopyWithImpl<_Unauthorized>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnauthorizedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unauthorized&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.unauthorized(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnauthorizedCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$UnauthorizedCopyWith(_Unauthorized value, $Res Function(_Unauthorized) _then) = __$UnauthorizedCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$UnauthorizedCopyWithImpl<$Res>
    implements _$UnauthorizedCopyWith<$Res> {
  __$UnauthorizedCopyWithImpl(this._self, this._then);

  final _Unauthorized _self;
  final $Res Function(_Unauthorized) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Unauthorized(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Server implements AppFailure {
  const _Server({this.message, this.statusCode, final  String? $type}): $type = $type ?? 'server';
  factory _Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);

@override final  String? message;
 final  int? statusCode;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerCopyWith<_Server> get copyWith => __$ServerCopyWithImpl<_Server>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Server&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,statusCode);

@override
String toString() {
  return 'AppFailure.server(message: $message, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$ServerCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$ServerCopyWith(_Server value, $Res Function(_Server) _then) = __$ServerCopyWithImpl;
@override @useResult
$Res call({
 String? message, int? statusCode
});




}
/// @nodoc
class __$ServerCopyWithImpl<$Res>
    implements _$ServerCopyWith<$Res> {
  __$ServerCopyWithImpl(this._self, this._then);

  final _Server _self;
  final $Res Function(_Server) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? statusCode = freezed,}) {
  return _then(_Server(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Timeout implements AppFailure {
  const _Timeout({this.message, final  String? $type}): $type = $type ?? 'timeout';
  factory _Timeout.fromJson(Map<String, dynamic> json) => _$TimeoutFromJson(json);

@override final  String? message;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeoutCopyWith<_Timeout> get copyWith => __$TimeoutCopyWithImpl<_Timeout>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeoutToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Timeout&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.timeout(message: $message)';
}


}

/// @nodoc
abstract mixin class _$TimeoutCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$TimeoutCopyWith(_Timeout value, $Res Function(_Timeout) _then) = __$TimeoutCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$TimeoutCopyWithImpl<$Res>
    implements _$TimeoutCopyWith<$Res> {
  __$TimeoutCopyWithImpl(this._self, this._then);

  final _Timeout _self;
  final $Res Function(_Timeout) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Timeout(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Serialization implements AppFailure {
  const _Serialization({this.message, final  String? $type}): $type = $type ?? 'serialization';
  factory _Serialization.fromJson(Map<String, dynamic> json) => _$SerializationFromJson(json);

@override final  String? message;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SerializationCopyWith<_Serialization> get copyWith => __$SerializationCopyWithImpl<_Serialization>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SerializationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Serialization&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.serialization(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SerializationCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$SerializationCopyWith(_Serialization value, $Res Function(_Serialization) _then) = __$SerializationCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$SerializationCopyWithImpl<$Res>
    implements _$SerializationCopyWith<$Res> {
  __$SerializationCopyWithImpl(this._self, this._then);

  final _Serialization _self;
  final $Res Function(_Serialization) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Serialization(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Cache implements AppFailure {
  const _Cache({this.message, final  String? $type}): $type = $type ?? 'cache';
  factory _Cache.fromJson(Map<String, dynamic> json) => _$CacheFromJson(json);

@override final  String? message;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacheCopyWith<_Cache> get copyWith => __$CacheCopyWithImpl<_Cache>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacheToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cache&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.cache(message: $message)';
}


}

/// @nodoc
abstract mixin class _$CacheCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$CacheCopyWith(_Cache value, $Res Function(_Cache) _then) = __$CacheCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$CacheCopyWithImpl<$Res>
    implements _$CacheCopyWith<$Res> {
  __$CacheCopyWithImpl(this._self, this._then);

  final _Cache _self;
  final $Res Function(_Cache) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Cache(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Offline implements AppFailure {
  const _Offline({this.message, final  String? $type}): $type = $type ?? 'offline';
  factory _Offline.fromJson(Map<String, dynamic> json) => _$OfflineFromJson(json);

@override final  String? message;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineCopyWith<_Offline> get copyWith => __$OfflineCopyWithImpl<_Offline>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfflineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Offline&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.offline(message: $message)';
}


}

/// @nodoc
abstract mixin class _$OfflineCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$OfflineCopyWith(_Offline value, $Res Function(_Offline) _then) = __$OfflineCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$OfflineCopyWithImpl<$Res>
    implements _$OfflineCopyWith<$Res> {
  __$OfflineCopyWithImpl(this._self, this._then);

  final _Offline _self;
  final $Res Function(_Offline) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Offline(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _Unknown implements AppFailure {
  const _Unknown({this.message, final  String? $type}): $type = $type ?? 'unknown';
  factory _Unknown.fromJson(Map<String, dynamic> json) => _$UnknownFromJson(json);

@override final  String? message;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnknownCopyWith<_Unknown> get copyWith => __$UnknownCopyWithImpl<_Unknown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UnknownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unknown&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppFailure.unknown(message: $message)';
}


}

/// @nodoc
abstract mixin class _$UnknownCopyWith<$Res> implements $AppFailureCopyWith<$Res> {
  factory _$UnknownCopyWith(_Unknown value, $Res Function(_Unknown) _then) = __$UnknownCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$UnknownCopyWithImpl<$Res>
    implements _$UnknownCopyWith<$Res> {
  __$UnknownCopyWithImpl(this._self, this._then);

  final _Unknown _self;
  final $Res Function(_Unknown) _then;

/// Create a copy of AppFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_Unknown(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
