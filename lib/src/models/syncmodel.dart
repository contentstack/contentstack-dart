import 'package:json_annotation/json_annotation.dart';
part 'syncmodel.g.dart';

@JsonSerializable(createFactory: true)
class SyncModel {
  final List items;
  final int skip;
  final int limit;
  @JsonKey(name: "total_count")
  final String totalCount;
  @JsonKey(name: "sync_token")
  final String syncToken;

  SyncModel(this.items, this.skip, this.limit, this.totalCount, this.syncToken);
  factory SyncModel.fromJson(Map<String, dynamic> json) => _$SyncModelFromJson(json);
  Map<String, dynamic> toJson() => _$SyncModelToJson(this);
}

@JsonSerializable()
class Items{
  final String type;
  final String eventAt;
  final String contentTypeUid;
  final List data;

  Items(this.type, this.eventAt, this.contentTypeUid, this.data);
  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}



@JsonSerializable()
class Data{
  final String uid;
  final String locale;
  final String title;

  Data(this.uid, this.locale, this.title);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}