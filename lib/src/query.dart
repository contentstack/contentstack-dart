import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

class Query extends BaseQuery{

  final String _contentTypeUid;
  final HttpClient _client;
  String _path;


  Query([this._client, this._contentTypeUid]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _path = "/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries";
  }


  /// find is applicable for querying the entry data.
  Future find() async {
    queryParameter['query'] = parameter.toString();
    final uri = Uri.https(_client.stack.endpoint, "$_path", queryParameter);
    return _client.sendRequest(uri.toString());
  }

  
}