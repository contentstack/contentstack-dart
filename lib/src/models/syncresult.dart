import 'package:json_annotation/json_annotation.dart';
part 'syncresult.g.dart';

@JsonSerializable(createFactory: true)
class SyncResult {
  final List items;
  final int skip;
  final int limit;
  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'sync_token')
  final String syncToken;
  @JsonKey(name: 'pagination_token')
  final String paginationToken;
  SyncResult(this.items, this.skip, this.limit, this.totalCount, this.syncToken,
      this.paginationToken);
  factory SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);
  Map<String, dynamic> toJson() => _$SyncResultToJson(this);
}

@JsonSerializable()
class Items {
  final String type;
  final String eventAt;
  final String contentTypeUid;
  final List data;
  Items(this.type, this.eventAt, this.contentTypeUid, this.data);
  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Data {
  final String uid;
  final String locale;
  final String title;
  Data(this.uid, this.locale, this.title);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
