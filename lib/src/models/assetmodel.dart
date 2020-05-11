import 'package:json_annotation/json_annotation.dart';
part 'assetmodel.g.dart';

/// AssetModel refers to the generic class for asset result
@JsonSerializable(createFactory: true)
class AssetModel {
  String uid;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  @JsonKey(name: 'created_by')
  String createdBy;
  @JsonKey(name: 'updated_by')
  String updatedBy;
  @JsonKey(name: 'content_type')
  String contentType;
  @JsonKey(name: 'file_size')
  String fileSize;
  List tags;
  String filename;
  String url;
  @JsonKey(name: '_version')
  int version;
  String title;
  Map<dynamic, dynamic> dimension;
  @JsonKey(name: 'publish_details')
  Map publishDetails;
  AssetModel(
      this.uid,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.contentType,
      this.fileSize,
      this.tags,
      this.filename,
      this.url,
      this.version,
      this.title,
      this.dimension,
      this.publishDetails);
  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssetModelToJson(this);
}
