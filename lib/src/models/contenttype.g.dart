// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contenttype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentType _$ContentTypeFromJson(Map<String, dynamic> json) {
  return ContentType(
    json['uid'] as String,
  )
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..schema = (json['schema'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList()
    ..createdAt = json['created_at'] as String
    ..updatedAt = json['updated_at'] as String;
}

Map<String, dynamic> _$ContentTypeToJson(ContentType instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'schema': instance.schema,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

ContentTypeCollection _$ContentTypeCollectionFromJson(
    Map<String, dynamic> json) {
  return ContentTypeCollection(
    items: (json['content_types'] as List)
        ?.map((e) =>
            e == null ? null : ContentType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContentTypeCollectionToJson(
        ContentTypeCollection instance) =>
    <String, dynamic>{
      'content_types': instance.items,
    };
