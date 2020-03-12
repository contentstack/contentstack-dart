import 'dart:async';
import 'package:http/http.dart' as http;
// ignore: directives_ordering
import 'dart:convert';

class HttpClient extends http.BaseClient {
  final http.Client _client;
  final Map<String, String> stackHeaders;

  factory HttpClient(Map<String, String> headers, {http.Client client})  {
    final stackClient = client ?? http.Client();
    return HttpClient._internal(stackClient, headers);
  }

  HttpClient._internal(this._client, this.stackHeaders);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // Adding all the stack Headers
    request.headers.addAll(stackHeaders);
    request.headers['Content-Type'] = 'application/json';
    request.headers['sdk'] = 'contentstack-dart-v0.1.0';
    request.headers['Content-Type'] = 'application/json';
    return _client.send(request);
  }


  /// Creates a request with a HTTP [method], [url] and optional data.
  /// The [url] can be either a `String` or `Uri`.
  Future<dynamic> sendRequest(String url) async {
    final  response = await http.get(Uri.encodeFull(url), headers: stackHeaders);
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
          throw ContentstackClientException(response.statusCode, error.toString());
        }
      }

      throw ContentstackClientException(response.statusCode, bodyJson.toString());
    }

    return bodyJson;
  }

  /// Closes the client and cleans up any associated resources.
  @override
  void close() => _client.close();
}

class ContentstackClientException implements Exception {
  final int statusCode;
  final String message;

  ContentstackClientException(this.statusCode, this.message);

  @override
  String toString() => '$message ($statusCode)';


}

