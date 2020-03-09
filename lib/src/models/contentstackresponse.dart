
import 'package:json_annotation/json_annotation.dart';
import '../contenttype.dart';

@JsonSerializable(createFactory: true)
class ContentstackResponse {
  
  final List<ContentType> content_types;

  ContentstackResponse({this.content_types});

}