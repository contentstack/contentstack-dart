// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) {
  return Error(
    errorMessage: json['error_message'] as String,
    errorCode: json['error_code'] as int,
    errors: json['errors'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'error_message': instance.errorMessage,
      'error_code': instance.errorCode,
      'errors': instance.errors,
    };
