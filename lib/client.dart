import 'dart:async';
import 'dart:convert';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/error/error.dart';
import 'package:http/http.dart' as http;
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

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(stackHeaders);
    request.headers['Content-Type'] = 'application/json';
    request.headers['sdk'] = 'contentstack-dart-v0.1.0';
    return _client.send(request);
  }

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
      return Error.fromJson(bodyJson);
    }

    return bodyJson;
  }

  @override
  void close() => _client.close();
}

