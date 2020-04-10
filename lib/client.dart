import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:package_info/package_info.dart';
import 'package:contentstack/src/stack.dart';

class HttpClient extends http.BaseClient {
  final http.Client _client;
  Stack stack;
  final Map<String, String> stackHeaders;

  factory HttpClient(Map<String, String> headers,
      {http.Client client, Stack stack}) {
    final stackClient = client ?? http.Client();
    return HttpClient._internal(stackClient, headers, stack);
  }

  HttpClient._internal(this._client, this.stackHeaders, this.stack);

  /// Helps to get request with all the available stack headeers
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(stackHeaders);
    request.headers['Content-Type'] = 'application/json';
    request.headers['sdk'] = 'contentstack-dart-v0.1.0';
    //request.headers['Content-Type'] = 'application/json';

    return _client.send(request);
  }


  /// Creates a request with a HTTP method that is by default [get]
  /// The [url] is string type
  Future<dynamic> sendRequest(String url) async {
    final response = await http.get(Uri.encodeFull(url), headers: stackHeaders);
    Object bodyJson;
    try {
      bodyJson = jsonDecode(response.body);
    } on FormatException {
      final contentType = response.headers['content-type'];
      if (contentType != null && !contentType.contains('application/json')) {
        throw Exception(
            "Returned value was not JSON. Did the uri end with '.json'?");
      }
      rethrow;
    }

    if (response.statusCode != 200) {
      if (bodyJson is Map) {
        final error = bodyJson['error_message'];
        if (error != null) {
          return Error(
              response.statusCode, error.toString());
        }
      }
      return Error(
          response.statusCode, bodyJson.toString());
    }

    return bodyJson;
  }

  @override
  void close() => _client.close();

}

class Error implements Exception {
  final int statusCode;
  final String message;
  Error(this.statusCode, this.message);
  @override
  String toString() => '$message ($statusCode)';
}
