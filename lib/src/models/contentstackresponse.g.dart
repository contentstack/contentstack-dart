// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contentstackresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentstackResponse _$ContentstackResponseFromJson(Map<String, dynamic> json) {
  return ContentstackResponse(
    content_types: (json['content_types'] as List)
        ?.map((e) =>
            e == null ? null : ContentType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContentstackResponseToJson(
        ContentstackResponse instance) =>
    <String, dynamic>{
      'content_types': instance.content_types,
    };
