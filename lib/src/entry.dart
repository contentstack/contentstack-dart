import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/entry_queryable.dart';

///
/// An entry is the actual piece of content created
/// using one of the defined content types.
/// Read more about Entries.
/// https://www.contentstack.com/docs/content-managers/work-with-entries/
///
/// All Entries:
/// The Get all entries call fetches the list of all the entries of a
/// particular content type
///
/// Single Entry:
/// The Get a single entry request fetches a particular entry of a content type
///
class Entry extends EntryQueryable {
  
  final String _uid;
  final String _contentTypeUid;
  final HttpClient _client;
  String _path;

  Entry([this._uid, this._client, this._contentTypeUid]) {
    parameter['environment'] = _client.stackHeaders['environment'];
    if (_contentTypeUid != null && _contentTypeUid.isNotEmpty) {
      _path =
          "/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries";
    }
  }

  Query query() {
    return Query(_client, _contentTypeUid);
  }

  /// It fetch single entry data.
  Future fetch() async {
    if (_uid == null) {
      throwException('Provide entry uid to fetch single entry');
    }
    final uri = Uri.https(_client.stack.endpoint, "$_path/$_uid", parameter);
    return _client.sendRequest(uri.toString());
  }
}
