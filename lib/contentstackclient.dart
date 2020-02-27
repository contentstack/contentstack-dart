import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';


class ContentstackClient {

  /// Auth credential.
  final String credential;
  final BaseClient _client;
  var queryParams = [];
  var stackHeaders = [];

  /// Creates a new ContentstackClient with [credential] and optional [client].
  ///
  /// For credential you can either use Firebase app's secret or
  /// an authentication token.
  /// See: <https://firebase.google.com/docs/reference/rest/database/user-auth>.
  ContentstackClient(this.credential, {BaseClient client}) : _client = client ?? Client();

  /// Creates a new anonymous ContentstackClient with optional [client].
  ContentstackClient.anonymous({BaseClient client}) : credential = null, _client = client ?? Client();


  /// Creates a request with a HTTP [method], [url] and optional data.
  /// The [url] can be either a `String` or `Uri`.
  Future<dynamic> send(url, {json}) async {
    Uri uri = url is String ? Uri.parse(url) : url;

    var request = Request('GET', uri);
    if (credential != null) {
      request.headers['Authorization'] = 'Bearer $credential';
    }

    if (json != null) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(json);
    }

    var streamedResponse = await _client.send(request);
    var response = await Response.fromStream(streamedResponse);

    Object bodyJson;
    try {
      bodyJson = jsonDecode(response.body);
    } on FormatException {
      var contentType = response.headers['content-type'];
      if (contentType != null && !contentType.contains('application/json')) {
        throw Exception(
            "Returned value was not JSON. Did the uri end with '.json'?");
      }
      rethrow;
    }

    if (response.statusCode != 200) {
      if (bodyJson is Map) {
        var error = bodyJson['error'];
        if (error != null) {
          throw ContentstackClientException(response.statusCode, error.toString());
        }
      }

      throw ContentstackClientException(response.statusCode, bodyJson.toString());
    }

    return bodyJson;
  }

  /// Closes the client and cleans up any associated resources.
  void close() => _client.close();
}

class ContentstackClientException implements Exception {
  final int statusCode;
  final String message;

  ContentstackClientException(this.statusCode, this.message);

  @override
  String toString() => '$message ($statusCode)';
}
