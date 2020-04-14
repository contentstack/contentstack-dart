import 'package:json_annotation/json_annotation.dart';
part 'assetmodel.g.dart';

@JsonSerializable(createFactory: true)
class AssetModel{
  String title;
  String abcd;

  AssetModel(this.title, this.abcd);
  factory AssetModel.fromJson(Map<String, dynamic> json) => _$AssetModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssetModelToJson(this);
}
