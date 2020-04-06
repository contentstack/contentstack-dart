
// https://flutter.dev/docs/development/data-and-backend/json#serializing-json-inside-model-classes

import 'package:json_annotation/json_annotation.dart';
part 'entrymodel.g.dart';

@JsonSerializable(createFactory: true)
class EntryModel{

  String locale;
  String title;
  String url;
  String description;
  List categories;
  List tags;
  String uid;
  @JsonKey(name: "created_by")
  String createdBy;
  @JsonKey(name: "updated_by")
  String updatedBy;
  @JsonKey(name: "created_at")
  String createdAt;
  @JsonKey(name: "updated_at")
  String updatedAt;
  @JsonKey(name: "_version")
  String version;
  @JsonKey(name: "_in_progress")
  String inProgress;


  EntryModel(this.locale, this.title, this.url, this.description, 
  this.categories, this.tags, this.uid, this.createdBy, this.updatedBy, 
  this.createdAt, this.updatedAt, this.version, this.inProgress);


  factory EntryModel.fromJson(Map<String, dynamic> json) => _$EntryModelFromJson(json);
  Map<String, dynamic> toJson() => _$EntryModelToJson(this);

}