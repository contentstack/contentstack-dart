import 'package:json_annotation/json_annotation.dart';
import '../stack.dart';
part 'contenttype.g.dart';


@JsonSerializable(createFactory: true)
class ContentType {

  Stack _stack;
  String uid;
  String title;
  String description;
  List<Map<String, dynamic>> schema;

  ContentType(this.uid);  

  @JsonKey(name:'created_at')
  String createdAt;
  @JsonKey(name:'updated_at')
  String updatedAt;
  
  void set stack(Stack stack) => _stack = stack;
  
  Stack get stack => _stack;

  static ContentType fromJson(Map<String, dynamic> json) => _$ContentTypeFromJson(json);

  Future<ContentType> fetch() {
    return this.stack.fetch('/content_types/${this.uid}', fromJson: ContentType.fromJson);
  }



}

@JsonSerializable(createFactory: true)
class ContentTypeCollection {
  @JsonKey(name:'content_types')
  final List<ContentType> items;
  ContentTypeCollection({this.items});

  static ContentTypeCollection fromJson(Map<String, dynamic> json) => _$ContentTypeCollectionFromJson(json);
   
}