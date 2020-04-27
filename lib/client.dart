import 'dart:async';
import 'dart:convert';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/error/error.dart';
import 'package:http/http.dart' as http;
import 'package:contentstack/src/stack.dart';

class HttpClient extends http.BaseClient {
  final http.Client _client;
  final Stack stack;
  final Map<String, String> stackHeaders;

  factory HttpClient(Map<String, String> headers,
      {http.Client client, Stack stack}) {
    final stackClient = client ?? http.Client();
    return HttpClient._internal(stackClient, headers, stack);
  }

  HttpClient._internal(this._client, this.stackHeaders, this.stack);

  /// Sends an HTTP request and asynchronously returns the response.
  ///
  /// Implementers should call [BaseRequest.finalize] to get the body of the
  /// request as a [ByteStream]. They shouldn't make any assumptions about the
  /// state of the stream; it could have data written to it asynchronously at a
  /// later point, or it could already be closed when it's returned. Any
  /// internal HTTP errors should be wrapped as [ClientException]s.
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    //request.headers.addAll(stackHeaders);
    //request.headers['Content-Type'] = 'application/json';
    //request.headers['sdk'] = 'contentstack-dart-v0.1.0';
    return _client.send(request);
  }

  Future<dynamic> sendRequest(Uri uri) async {
    stackHeaders.addAll(stackHeaders);
    stackHeaders['Content-Type'] = 'application/json';
    stackHeaders['sdk'] = 'contentstack-dart-v0.1.0';
    final response = await http.get(uri, headers: stackHeaders);
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

  ///////////////////////////////////////

  static T fromJson<T, K>(dynamic json) {
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    } else if (T == AssetModel) {
      return AssetModel.fromJson(json) as T;
    } else if (T == EntryModel) {
      return EntryModel.fromJson(json) as T;
    } else if (T == SyncResult) {
      return SyncResult.fromJson(json) as T;
    } else {
      throw Exception("Unknown class");
    }
  }

  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }
    // ignore: prefer_collection_literals
    final List<K> output = List();
    // ignore: prefer_final_in_for_each
    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }
    return output;
  }
}
