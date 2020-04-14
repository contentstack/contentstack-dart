import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

class Query extends BaseQuery {

  final HttpClient _client;
  final String _contentTypeUid;
  String _path;

  Query([this._client, this._contentTypeUid]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _path = "/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries";
  }

  Map getQueryUrl(){
    queryParameter['query'] = parameter.toString();
    return queryParameter;
  }

  Future find() async {
    getQueryUrl();
    final uri = Uri.https(_client.stack.endpoint, "$_path", queryParameter);
    return _client.sendRequest(uri.toString());
  }
}