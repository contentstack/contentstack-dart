
import 'package:json_annotation/json_annotation.dart';
import 'contenttype.dart';
part 'contentstackresponse.g.dart';

@JsonSerializable(createFactory: true)
class ContentstackResponse {
  
  final List<ContentType> content_types;

  ContentstackResponse({this.content_types});

  static ContentstackResponse fromJson(Map<String, dynamic> json) => _$ContentstackResponseFromJson(json);
}