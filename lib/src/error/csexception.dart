import 'package:json_annotation/json_annotation.dart';
part 'csexception.g.dart';

@JsonSerializable(createFactory: true)
class CSException implements Exception {
  
  @JsonKey(name: "error_message")
  final String errorMessage;
  @JsonKey(name: "error_code")
  final int errorCode;
  int statusCode;

  CSException(this.errorMessage, this.errorCode);

  factory CSException.fromJson(Map<String, dynamic> json) => _$CSExceptionFromJson(json);
  Map<String, dynamic> toJson() => _$CSExceptionToJson(this);
  
}




class ContentstackException implements Exception {
  String cause;
  ContentstackException(this.cause);
}

Exception throwException(String exceptionMessge) {
  throw ContentstackException(exceptionMessge);
}