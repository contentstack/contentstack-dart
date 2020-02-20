// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiexception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIException _$APIExceptionFromJson(Map<String, dynamic> json) {
  return APIException(
    json['error_message'] as String,
    json['error_code'] as int,
  )..statusCode = json['statusCode'] as int;
}

Map<String, dynamic> _$APIExceptionToJson(APIException instance) =>
    <String, dynamic>{
      'error_message': instance.errorMessage,
      'error_code': instance.errorCode,
      'statusCode': instance.statusCode,
    };
