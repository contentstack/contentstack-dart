// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syncresult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SyncResult _$SyncResultFromJson(Map<String, dynamic> json) {
  return SyncResult(
    json['items'] as List,
    json['skip'] as int,
    json['limit'] as int,
    json['total_count'] as int,
    json['sync_token'] as String,
    json['pagination_token'] as String,
  );
}

Map<String, dynamic> _$SyncResultToJson(SyncResult instance) =>
    <String, dynamic>{
      'items': instance.items,
      'skip': instance.skip,
      'limit': instance.limit,
      'total_count': instance.totalCount,
      'sync_token': instance.syncToken,
      'pagination_token': instance.paginationToken,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    json['type'] as String,
    json['eventAt'] as String,
    json['contentTypeUid'] as String,
    json['data'] as List,
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'type': instance.type,
      'eventAt': instance.eventAt,
      'contentTypeUid': instance.contentTypeUid,
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
