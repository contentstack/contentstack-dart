// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csexception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CSException _$CSExceptionFromJson(Map<String, dynamic> json) {
  return CSException(
    json['error_message'] as String,
    json['error_code'] as int,
  )..statusCode = json['statusCode'] as int;
}

Map<String, dynamic> _$CSExceptionToJson(CSException instance) =>
    <String, dynamic>{
      'error_message': instance.errorMessage,
      'error_code': instance.errorCode,
      'statusCode': instance.statusCode,
    };
