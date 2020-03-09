
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Entry{

  String locale;
  String title;
  String url;
  String description;
  String categories;
  String tags;
  String uid;
  String created_by;
  String updated_by;
  String created_at;
  String updated_at;
  String _version;
  String _in_progress;
  String publish_details;

}