import 'dart:async';
import 'package:http/http.dart' as http;


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
}

