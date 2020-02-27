import 'package:json_annotation/json_annotation.dart';
part 'syncresult.g.dart';

@JsonSerializable()
class SyncResult {
  
  final List items;
  final String skip;
  final String limit;
  final String total_count;
  final String sync_token;

  SyncResult(this.items, this.skip, this.limit, this.total_count, this.sync_token);

  factory SyncResult.fromJson(Map<String, dynamic> json) => _$SyncResultFromJson(json);
  
  Map<String, dynamic> toJson() => _$SyncResultToJson(this);
}




@JsonSerializable()
class Items{

  final String type;
  final String event_at;
  final String content_type_uid;
  final List data;

  Items(this.type, this.event_at, this.content_type_uid, this.data);

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