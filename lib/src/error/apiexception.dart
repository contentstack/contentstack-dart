import 'package:json_annotation/json_annotation.dart';
part 'apiexception.g.dart';
@JsonSerializable(createFactory: true)
class APIException implements Exception {
  @JsonKey(name: "error_message")
  final String errorMessage;
  @JsonKey(name: "error_code")
  final int errorCode;
  int statusCode;

  APIException(this.errorMessage, this.errorCode);

  factory APIException.fromJson(Map<String, dynamic> json) => _$APIExceptionFromJson(json);

  @override
  String toString() {
    var statusCodeString = "HTTP status code $statusCode";
    var detailMessage = ''' 
    Contentstack error message ${this.errorMessage}
        Contentstack error code ${this.errorCode}
        ''';// Contentstack error ${(this.errorInfo != null) ? self.errorInfo!.debugDescription : "")}
    var debugDescription =
    '''
    $statusCodeString
    $detailMessage
    ''';
    return debugDescription; 
  }

  static APIException error(Object data, int statusCode) {
    try {
      var apiexception = APIException.fromJson(data);
      apiexception.statusCode = statusCode;
      return apiexception;
    } catch (e) {
      return null;
    }
  }
}