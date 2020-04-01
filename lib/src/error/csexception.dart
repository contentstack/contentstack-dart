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
    
    final statusCodeString = "HTTP status code $statusCode";
    
    final detailMessage = ''' 
    Contentstack error message $errorMessage 
    Contentstack error code $errorCode
    ''';
    
    final debugDescription = "$statusCodeString $detailMessage";
    return debugDescription; 
  }

  CSException.error(Map<String, dynamic> data, int statusCode, this.errorMessage, this.errorCode){

    try {
      final apiexception = CSException.fromJson(Map<String, dynamic>.of(data));
      apiexception.statusCode = statusCode;
      //return apiexception;
    } catch (e) {
      //return null;
    }

  }

  // static CSException error(Map<String, dynamic> data, int statusCode) {
  //   try {
  //     final apiexception = CSException.fromJson(Map<String, dynamic>.of(data));
  //     apiexception.statusCode = statusCode;
  //     return apiexception;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}




class ContentstackException implements Exception {
  String cause;
  ContentstackException(this.cause);
}

Exception throwException(String exceptionMessge) {
  throw ContentstackException(exceptionMessge);
}