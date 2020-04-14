import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';

@JsonSerializable(createFactory: true)
class Error implements Exception {
  
  @JsonKey(name: "error_message")
  final String errorMessage;
  @JsonKey(name: "error_code")
  final int errorCode;
  int statusCode;

  Error({this.errorMessage, this.errorCode});

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
