// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assetmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetModel _$AssetModelFromJson(Map<String, dynamic> json) {
  return AssetModel(
    json['uid'] as String?,
    json['created_at'] as String?,
    json['updated_at'] as String?,
    json['created_by'] as String?,
    json['updated_by'] as String?,
    json['content_type'] as String?,
    json['file_size'] as String?,
    json['tags'] as List?,
    json['filename'] as String?,
    json['url'] as String?,
    json['_version'] as int?,
    json['title'] as String?,
    json['dimension'] as Map<String, dynamic>?,
    json['publish_details'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$AssetModelToJson(AssetModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'content_type': instance.contentType,
      'file_size': instance.fileSize,
      'tags': instance.tags,
      'filename': instance.filename,
      'url': instance.url,
      '_version': instance.version,
      'title': instance.title,
      'dimension': instance.dimension,
      'publish_details': instance.publishDetails,
    };
