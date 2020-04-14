// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrymodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryModel _$EntryModelFromJson(Map<String, dynamic> json) {
  return EntryModel(
    json['locale'] as String,
    json['title'] as String,
    json['url'] as String,
    json['description'] as String,
    json['categories'] as List,
    json['tags'] as List,
    json['uid'] as String,
    json['created_by'] as String,
    json['updated_by'] as String,
    json['created_at'] as String,
    json['updated_at'] as String,
    json['_version'] as int,
    json['_in_progress'] as String,
  );
}

Map<String, dynamic> _$EntryModelToJson(EntryModel instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'title': instance.title,
      'url': instance.url,
      'description': instance.description,
      'categories': instance.categories,
      'tags': instance.tags,
      'uid': instance.uid,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      '_version': instance.version,
      '_in_progress': instance.inProgress,
    };
