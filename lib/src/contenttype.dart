import 'dart:async';

import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/contenttype_query.dart';

///
/// Content type lets you define the structure or blueprint
/// of a page or a section of your digital property.
/// It is a form-like page that gives Content Managers
/// an interface to input and upload content.
/// * Read more about [ContentTypes](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#content-types).
///
class ContentType {
  final String _contentTypeUid;
  final HttpClient _client;
  String urlPath;
  final Map<String, String> _queryParameter = <String, String>{};

  ContentType([this._contentTypeUid, this._client]) {
    _queryParameter['environment'] = _client.stackHeaders['environment'];
    if (_contentTypeUid != null && _contentTypeUid.isNotEmpty) {
      urlPath = '/${_client.stack.apiVersion}/content_types/$_contentTypeUid';
    }
  }


  ///
  /// This function provide option to  get single entry as well as
  /// all the entries. [entryUid] is Optional, If [entryUid]
  /// Provided it fetches related entry of a respected content type
  /// Read more about single entry:
  /// https://www.contentstack.com/docs/developers/apis/content-delivery-api/#single-entry
  ///
  /// if [entryUid] not provided ,Get all entries call fetches the list of
  /// all the entries of a particular content type.
  /// It also returns the content of each entry in JSON format.
  /// You can also specify the environment
  /// and locale of which you wish to get the entries.
  /// /// Read more about entries:
  /// https://www.contentstack.com/docs/developers/apis/content-delivery-api/#all-entries
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final contentType = stack.contentType('content_type_uid');
  /// final entry = contentType.entry(entryUid: 'entry_uid');
  ///
  /// ```
  ///
  Entry entry({String entryUid}) {
    return Entry(entryUid, _client, _contentTypeUid);
  }

  ///
  /// This call returns information of a specific content type.
  /// It returns the content type schema, but does not include its entries.
  /// [queryParams] query parameters
  ///
  /// Example:
  ///
  /// ```dart
  /// final contentType = stack.contentType("content_type_uid");
  /// final Map<String, dynamic> queryParameter = <String,dynamic>{};
  /// queryParameter["include_snippet_schema"] = true;
  /// queryParameter["limit"] = 3;
  /// final response = contentType.fetch(queryParameter);
  /// print(response);
  /// ```
  ///
  Future<T> fetch<T, K>([Map<String, dynamic> queryParams]) {
    if (urlPath == null) {
      throw Exception('content_type_uid is missing');
    }
    if (queryParams != null && queryParams.isNotEmpty) {
      _queryParameter.addAll(queryParams);
    }
    final uri = Uri.https(_client.stack.endpoint, urlPath, _queryParameter);
    return _client.sendRequest<T, K>(uri);
  }

  ///
  /// Query on ContentType
  /// This call returns comprehensive information of all the content types
  /// available in a particular stack in your account
  ///
  /// Example:
  ///
  /// ```dart
  /// final contentTypeQuery = stack.contentType().query();
  /// final response = contentTypeQuery.find();
  /// print(response);
  /// ```
  ///
  ContentTypeQuery query() {
    return ContentTypeQuery(_client);
  }
}
