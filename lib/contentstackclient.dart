import 'dart:async';
import 'dart:convert';
import 'package:contentstack/src/stack.dart';
import 'package:http/http.dart';


class ContentstackClient {

  /// Auth credential.
  // final String credential;
  final Stack _stack;
  final BaseClient _client;
  String encodedPath;
  var queryParameters;

  /// Creates a new ContentstackClient with [credential] and optional [client].
  ContentstackClient.stack(this._stack, {BaseClient client}) : _client = client ?? Client();

  /// Creates a new anonymous ContentstackClient with optional [client].
  ContentstackClient.anonymous({BaseClient client}) : _stack = null, _client = client ?? Client();
  


  /// Creates a request with a HTTP [method], [url] and optional data.
  /// The [url] can be either a `String` or `Uri`.
  Future<dynamic> send(encodedPath, queryParameter) async {
    /// In case url is type of string => convert it to Uri
    var url = ''; // construct full url using host, uriPath and queryParams 
    Uri uri = url is String ? Uri.parse(url) : url;

    //Uri newuri = Uri.https(_stack.host, encodedPath, queryParameters);

    var request = Request('GET', uri);
    if (_stack != null) {
      throw StackException('Stack can not be null, Please provide Stack Instance');
    }

    // Get & append all the headers to the stackInstance.
    request.headers['Content-Type'] = 'application/json';

    // if (json != null) {
    //   request.headers['Content-Type'] = 'application/json';
    //   request.headers['Content-Type'] = 'application/json';
    //   request.headers['Content-Type'] = 'application/json';
    //   request.body = jsonEncode(json);
    // }

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

    // or checkk by (statusCode < 200 || statusCode > 400)
    if (response.statusCode != 200) {
      if (bodyJson is Map) {
        var error = bodyJson['error'];
        if (error != null) {
          throw ContentstackClientException(response.statusCode, error.toString());
        }
      }

      throw ContentstackClientException(response.statusCode, bodyJson.toString());
    }

    /// convert body map to the respective models.
    /// Or Just return bodyJson at it is.

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


class StackException implements Exception {
  
  final String message;

  StackException(this.message);

  @override
  String toString() => '$message';
}
