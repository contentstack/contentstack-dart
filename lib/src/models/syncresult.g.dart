// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syncresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncResult _$SyncResultFromJson(Map<String, dynamic> json) {
  return SyncResult(
    json['items'] as List,
    json['skip'] as String,
    json['limit'] as String,
    json['total_count'] as String,
    json['sync_token'] as String,
  );
}

Map<String, dynamic> _$SyncResultToJson(SyncResult instance) =>
    <String, dynamic>{
      'items': instance.items,
      'skip': instance.skip,
      'limit': instance.limit,
      'total_count': instance.total_count,
      'sync_token': instance.sync_token,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    json['type'] as String,
    json['event_at'] as String,
    json['content_type_uid'] as String,
    json['data'] as List,
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'type': instance.type,
      'event_at': instance.event_at,
      'content_type_uid': instance.content_type_uid,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['uid'] as String,
    json['locale'] as String,
    json['title'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'uid': instance.uid,
      'locale': instance.locale,
      'title': instance.title,
    };
