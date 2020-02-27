

class Error implements Exception{

  final String errorCode;
  final String errorMessage;

  Error(this.errorCode, this.errorMessage);

  @override
  String toString() => '$errorMessage ($errorCode)';

}