import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';

@JsonSerializable(createFactory: true)
class Error implements Exception {
  @JsonKey(name: 'error_message')
  final String errorMessage;
  @JsonKey(name: 'error_code')
  final int errorCode;
  final Map errors;
  Error({this.errorMessage, this.errorCode, this.errors});
  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
