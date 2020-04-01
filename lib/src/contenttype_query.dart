import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

///This call returns comprehensive information of all the content types
///available in a particular stack in your account.
///
class ContentTypeQuery extends BaseQuery{

  final HttpClient _client;
  String _urlPath;

  ContentTypeQuery([this._client]){
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _urlPath = "/${_client.stack.apiVersion}/content_types";
  }

  ///include in response the total count of content types available in your stack
  ContentTypeQuery includeCount(){
    queryParameter['include_count'] = 'true';
    return this;
  }

  ///This call returns comprehensive information of all the content types
  ///available in a particular stack in your account.
  Future find([Map queryParams]) async{
    if (queryParams != null && queryParams.isNotEmpty) {
      queryParameter.addAll(queryParams);
    }
    final uri = Uri.https(_client.stack.endpoint, _urlPath, queryParameter);
    return _client.sendRequest(uri.toString());
  }

}