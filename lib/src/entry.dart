import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/base_query.dart';

class Entry extends BaseQuery {
  final String _uid;
  final String _contentTypeUid;
  final HttpClient _client;
  String _urlPath;

  Entry([this._uid, this._client, this._contentTypeUid]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    if (_contentTypeUid != null && _contentTypeUid.isNotEmpty) {
      _urlPath =
          "/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries";
    }
  }

  Entry locale(String locale) {
    queryParameter['locale'] = locale;
    return this;
  }

  Entry version(int version) {
    queryParameter['version'] = version.toString();
    return this;
  }

  Entry environment(String environment) {
    queryParameter['environment'] = environment;
    return this;
  }

  Entry query() {
    return this;
  }

  /// It fetch single entry data.
  Future fetch() async {
    if (_uid == null) {
      throwException('Provide entry uid to fetch single entry');
    }
    //https://cdn.contentstack.io/v3/content_types/product/entries/entry_uid?version=4&environment=production&locale=en-us
    final uri =
        Uri.https(_client.stack.endpoint, "$_urlPath/$_uid", queryParameter);
    return _client.sendRequest(uri.toString());
  }

//  Uri _uri(String path, {Map<String, dynamic> params}) => Uri(
//    scheme: 'https',
//    host: "",
//    path: 'v3/stack/$path',
//    queryParameters: params,
//  );

//  Future<T> fetchEntry<T extends Entry>(
//      String id,
//      T Function(Map<String, dynamic>) fromJson, {
//        Map<String, dynamic> params,
//      }) async {
//    final response = await _client.get(_uri('/entries/$id', params: params));
//    if (response.statusCode != 200) {
//      throw Exception('getEntry failed');
//    }
//    return null;
//  }

}
