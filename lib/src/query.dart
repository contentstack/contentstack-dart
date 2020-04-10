import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

class Query extends BaseQuery {

  // Query._internal(this._client, this._contentTypeUid);
  // factory Query([this._client, this._contentTypeUid]) {
  //   return Query._internal( _client, _contentTypeUid);
  // }

  Query([this._client, this._contentTypeUid]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _path = "/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries";
  }

  final HttpClient _client;
  final String _contentTypeUid;
  String _path;

  Map getQueryUrl(){
    queryParameter['query'] = parameter.toString();
    return queryParameter;
  }

  /// find is applicable for querying the entry data.
  Future find() async {
    getQueryUrl();
    final uri = Uri.https(_client.stack.endpoint, "$_path", queryParameter);
    return _client.sendRequest(uri.toString());
  }
}