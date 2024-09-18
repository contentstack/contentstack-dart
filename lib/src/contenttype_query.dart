import 'dart:async';

import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

/// This call returns comprehensive information of all the content types
/// available in a particular stack in your account.
/// [ContentType](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#all-content-types).
class ContentTypeQuery extends BaseQuery {
  final HttpClient? _client;
  late String _urlPath;

  ContentTypeQuery([this._client]) {
    queryParameter['environment'] = _client!.stackHeaders!['environment'];
    _urlPath = '/${_client!.stack!.apiVersion}/content_types';
  }

  /// This call returns comprehensive information of all the content types
  /// available in a particular stack in your account.
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final contentTypeQuery = stack.contentType().query()
  /// final response = contentTypeQuery.includeCount().find();
  /// print(response);
  /// ```
  ///
  Future<T?> find<T, K>({Map<String, String>? queryParams}) async {
    if (queryParams != null && queryParams.isNotEmpty) {
      queryParameter.addAll(queryParams);
    }
    final uri = Uri.https(_client!.stack!.endpoint!, _urlPath, queryParameter);
    return _client!.sendRequest<T, K>(uri);
  }

  ///
  /// This method includes the includeCount method facilitate to
  /// find the total count of content types available in your stack
  ///
  /// Example:
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final contentTypeQuery = stack.contentType().query()
  /// final response = contentTypeQuery.includeCount().find();
  /// print(response);
  /// ```
  ///
  void includeCount() {
    queryParameter['include_count'] = 'true';
  }

  /// This method includes the Global field's schema
  /// along with the content type schema
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final contentTypeQuery = stack.contentType().query()
  /// final response = contentTypeQuery.includeGlobalField().find();
  /// print(response);
  /// ```
  void includeGlobalField() {
    queryParameter['include_global_field_schema'] = 'true';
  }
}
