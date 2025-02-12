import 'package:json_annotation/json_annotation.dart';
part 'syncresult.g.dart';

/// SyncResult refers to the generic class for sync response
@JsonSerializable(createFactory: true)
class SyncResult {
  /// list of items available in sync result
  final List? items;

  /// skip count in sync result
  final int? skip;

  /// limit for result items in sync result
  final int? limit;

  /// Total items count in sync result
  @JsonKey(name: 'total_count')
  final int? totalCount;

  /// Sync Token for the sync result
  @JsonKey(name: 'sync_token')
  final String? syncToken;

  /// Pagination Token for the sync result
  @JsonKey(name: 'pagination_token')
  final String? paginationToken;
  SyncResult(this.items, this.skip, this.limit, this.totalCount, this.syncToken,
      this.paginationToken);
  factory SyncResult.fromJson(Map<String, dynamic> json) =>
      _$SyncResultFromJson(json);
  Map<String, dynamic> toJson() => _$SyncResultToJson(this);
}

/// Total items available in sync result
@JsonSerializable()
class Items {
  final String? type;
  final String? eventAt;
  final String? contentTypeUid;
  final List? data;
  Items(this.type, this.eventAt, this.contentTypeUid, this.data);
  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

/// Data inside sync result's items that contains uid, locale, title etc
@JsonSerializable()
class Data {
  final String? uid;
  final String? locale;
  final String? title;
  Data(this.uid, this.locale, this.title);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
