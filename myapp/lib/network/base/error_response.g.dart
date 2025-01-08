// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      timestamp: json['timestamp'] as String?,
      code: (json['code'] as num?)?.toInt(),
      path: json['path'] as String?,
      msg: json['msg'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'code': instance.code,
      'error': instance.error,
      'msg': instance.msg,
      'path': instance.path,
    };
