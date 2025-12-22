// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Network _$NetworkFromJson(Map<String, dynamic> json) => _Network(
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$NetworkToJson(_Network instance) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'runtimeType': instance.$type,
};

_Unauthorized _$UnauthorizedFromJson(Map<String, dynamic> json) =>
    _Unauthorized(
      message: json['message'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$UnauthorizedToJson(_Unauthorized instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_Server _$ServerFromJson(Map<String, dynamic> json) => _Server(
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ServerToJson(_Server instance) => <String, dynamic>{
  'message': instance.message,
  'statusCode': instance.statusCode,
  'runtimeType': instance.$type,
};

_Timeout _$TimeoutFromJson(Map<String, dynamic> json) => _Timeout(
  message: json['message'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TimeoutToJson(_Timeout instance) => <String, dynamic>{
  'message': instance.message,
  'runtimeType': instance.$type,
};

_Serialization _$SerializationFromJson(Map<String, dynamic> json) =>
    _Serialization(
      message: json['message'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SerializationToJson(_Serialization instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_Cache _$CacheFromJson(Map<String, dynamic> json) => _Cache(
  message: json['message'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$CacheToJson(_Cache instance) => <String, dynamic>{
  'message': instance.message,
  'runtimeType': instance.$type,
};

_Offline _$OfflineFromJson(Map<String, dynamic> json) => _Offline(
  message: json['message'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$OfflineToJson(_Offline instance) => <String, dynamic>{
  'message': instance.message,
  'runtimeType': instance.$type,
};

_Unknown _$UnknownFromJson(Map<String, dynamic> json) => _Unknown(
  message: json['message'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$UnknownToJson(_Unknown instance) => <String, dynamic>{
  'message': instance.message,
  'runtimeType': instance.$type,
};
