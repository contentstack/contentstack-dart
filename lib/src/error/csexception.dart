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

  static CSException error(Object data, int statusCode) {
    try {
      var apiexception = CSException.fromJson(data);
      apiexception.statusCode = statusCode;
      return apiexception;
    } catch (e) {
      return null;
    }
  }
}