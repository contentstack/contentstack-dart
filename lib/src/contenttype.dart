import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/contenttype_query.dart';

/// Content type defines the structure or schema of a
/// page or a section of your web or mobile property.
/// To create content for your application, you are
/// required to first create a content type,
/// and then create entries using the content type.
/// Read more about Content Types.
/// https://www.contentstack.com/docs/developers/apis/content-delivery-api/#content-types
class ContentType {
  final String _contentTypeUid;
  final HttpClient _client;
  String _urlPath;
  final Map<String, String> _queryParameter = <String, String>{};

  ContentType([this._contentTypeUid, this._client]) {
    _queryParameter['environment'] = _client.stackHeaders['environment'];
    if (_contentTypeUid != null && _contentTypeUid.isNotEmpty) {
      _urlPath = "/${_client.stack.apiVersion}/content_types/$_contentTypeUid";
    }
  }

  /// This function provide option to  get single entry as well as all the entries.
  ///  [uid] is Optional
  /// If [uid]  Provided, Get a single entry request fetches a particular entry of a content type
  /// Read more about single entry:
  /// https://www.contentstack.com/docs/developers/apis/content-delivery-api/#single-entry

  /// if [uid] not provided ,Get all entries call fetches the list of all the entries of a particular content type.
  /// It also returns the content of each entry in JSON format. You can also specify the environment
  /// and locale of which you wish to get the entries.
  /// /// Read more about entries:
  /// https://www.contentstack.com/docs/developers/apis/content-delivery-api/#all-entries
  Entry entry([String uid]) {
    if (uid != null && uid.isNotEmpty) {
      return Entry(uid, _client, _contentTypeUid);
    }
    return Entry();
  }

  /// Query on ContentType
  /// This call returns comprehensive information of all the content types
  /// available in a particular stack in your account
  ContentTypeQuery query() {
    return ContentTypeQuery(_client);
  }

  ///
  /// This call returns information of a specific content type.
  /// It returns the content type schema, but does not include its entries.
  /// [queryParams] query parameters
  ///
  /// Example:
  /// var contentType = stack.contentType("content_type_uid");
  /// final Map<String, dynamic> queryParameter = <String,dynamic>{};
  /// queryParameter["include_snippet_schema"] = true;
  /// queryParameter["limit"] = 3;
  /// var response = contentType.fetch(queryParameter);
  ///
  Future fetch([Map queryParams]) async{
    if(_urlPath == null){
      throw Exception('content_type_uid is missing');
    }
    if (queryParams != null && queryParams.isNotEmpty) {
      _queryParameter.addAll(queryParams);
    }
    final uri = Uri.https(_client.stack.endpoint, _urlPath, _queryParameter);
    return _client.sendRequest(uri.toString());
  }
}
