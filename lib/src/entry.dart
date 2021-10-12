import 'dart:async';

import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/entry_queryable.dart';

import '../constant.dart';

/// An `Entry` is the actual piece of content created using one of
/// the defined `contenttypes`. Learn more about Entries.
/// Read more for details of [Entry](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#entries)
class Entry extends EntryQueryable {
  final HttpClient _client;
  final String _contentTypeUid;
  String _path;
  final String _uid;

  ///
  /// An `Entry` is the actual piece of content created using one of
  /// the defined `contenttypes`. Learn more about Entries.
  /// Read more for details of [Entry](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#entries)
  Entry([this._uid, this._client, this._contentTypeUid]) {
    parameter['environment'] = _client.stackHeaders['environment'];
    if (_contentTypeUid != null && _contentTypeUid.isNotEmpty) {
      _path =
          '/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries';
    }
  }

  /// The Get a `single entry` request fetches a particular
  /// entry of a content type.
  ///
  /// Example:
  ///
  /// ```dart
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// final contentstack.Stack stack =
  /// contentstack.Stack('apiKey', 'deliveryToken', 'environment');
  /// entry = stack.contentType('contentType').entry(entryUid: 'entryUid');
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
  /// ```
  ///
  Future<T> fetch<T, K>() async {
    if (_uid == null) {
      throw Exception('Provide entry uid to fetch single entry');
    }
    _validateLivePreview();
    final uri = Uri.https(_client.stack.endpoint, '$_path/$_uid', parameter);
    return _client.sendRequest<T, K>(uri);
  }

  void _validateLivePreview() {
    if (_client.stack.livePreview['enable']) {
      ifLivePreviewEnable(_client);
      if (_contentTypeUid == _client.stack.livePreview['content_type_uid']) {
        parameter['live_preview'] = 'init';
        if (_client.stack.livePreview.containsKey('live_preview')) {
          parameter['live_preview'] = _client.stack.livePreview['live_preview'];
        }
      }
    }
  }

  /// Applies query on entries
  Query query() {
    return Query(_client, _contentTypeUid);
  }
}
