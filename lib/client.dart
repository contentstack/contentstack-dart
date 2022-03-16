import 'dart:async';
import 'dart:convert';

import 'package:contentstack/constant.dart';
import 'package:contentstack/contentstack.dart';
import 'package:http/http.dart' as http;

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

  @override
  void close() => _client.close();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request);
  }

  Future<T> sendRequest<T, K>(Uri uri) async {
    stackHeaders[CONTENT_TYPE] = CONTENT_TYPE_VALUE;
    stackHeaders[X_USER_AGENT] = X_USER_AGENT_VALUE;
    final response = await http
        .get(uri, headers: stackHeaders)
        .timeout(const Duration(seconds: TIMEOUT));
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
    if (response.statusCode == 200) {
      final Map bodyJson = json.decode(utf8.decode(response.bodyBytes));
      if (T == EntryModel && bodyJson.containsKey('entry')) {
        return fromJson<T, K>(bodyJson['entry']);
      } else if (K == EntryModel && bodyJson.containsKey('entries')) {
        return fromJson<T, K>(bodyJson['entries']);
      } else if (T == AssetModel && bodyJson.containsKey('asset')) {
        return fromJson<T, K>(bodyJson['asset']);
      } else if (K == AssetModel && bodyJson.containsKey('assets')) {
        return fromJson<T, K>(bodyJson['assets']);
      } else if (T == SyncResult && bodyJson.containsKey('items')) {
        return fromJson<T, K>(bodyJson);
      } else {
        return fromJson<T, K>(bodyJson);
      }
    } else {
      // Response code other than 200 considered error
      return bodyJson;
    }
  }

  /// Generic objects as well as List of generic objects
  /// (from a JSON list response).
  /// First, you need to have a function that checks the type  of the
  /// generic object and returns the result of the corresponding fromJson call
  /// code taken from:
  /// https://stackoverflow.com/questions/56271651/how-to-pass-a-generic-type-as-a-parameter-to-a-future-in-flutter
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
      return json;
    }
  }

  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    final output = <K>[];
    // ignore: prefer_final_in_for_each
    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }
    return output;
  }
}
