import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/entry_queryable.dart';

/// An entry is the actual piece of content created using one of
/// the defined content types. Learn more about Entries.
/// Read more for details of [Entry](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#entries)
class Entry extends EntryQueryable {
  Entry([this._uid, this._client, this._contentTypeUid]) {
    parameter['environment'] = _client.stackHeaders['environment'];
    if (_contentTypeUid != null && _contentTypeUid.isNotEmpty) {
      _path =
          '/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries';
    }
  }

  final HttpClient _client;
  final String _contentTypeUid;
  String _path;
  final String _uid;

  /// Applies query on entries
  Query query() {
    return Query(_client, _contentTypeUid);
  }

  ///
  /// Include the fallback locale publish content,
  /// if specified locale content is not publish.
  ///
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry();
  /// entry.includeFallback()
  ///
  void includeFallback() {
    parameter['include_fallback'] = 'true';
  }

  /// The Get a single entry request fetches a particular entry of a content type.
  ///
  /// Example:
  ///
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// final contentstack.Stack stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// entry = stack.contentType('faq').entry(entryUid: Credential.entryUid);
  /// entry.includeReference('categories');
  ///      await entry.fetch().then((response) {
  ///        if(response is Error){
  ///          print(response.errorMessage);
  ///        }else{
  ///          print(response.toString());
  ///        }
  ///      }).catchError((onError) {
  ///        expect('invalid url requested', onError.message);
  ///      });
  ///
  Future<T> fetch<T, K>() async {
    if (_uid == null) {
      throw Exception('Provide entry uid to fetch single entry');
    }
    final uri = Uri.https(_client.stack.endpoint, '$_path/$_uid', parameter);
    return _client.sendRequest<T, K>(uri);
  }
}
