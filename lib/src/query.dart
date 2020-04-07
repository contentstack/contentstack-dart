import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

class Query extends BaseQuery{

  final String _contentTypeUid;
  final HttpClient _client;
  String _path;


  Query([this._client, this._contentTypeUid]) {
    parameter['environment'] = _client.stackHeaders['environment'];
    if (_contentTypeUid != null && _contentTypeUid.isNotEmpty) {
      _path = "/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries";
    }
  }


  /// find is applicable for querying the entry data.
  Future fetch() async {
    final uri = Uri.https(_client.stack.endpoint, "$_path", parameter);
    return _client.sendRequest(uri.toString());
  }

  // Future<int> successor = future.then((int value) {
  //   // Invoked when the future is completed with a value.
  //   return 42;  // The successor is completed with the value 42.
  // },
  // onError: (e) {
  //   // Invoked when the future is completed with an error.
  //   if (canHandle(e)) {
  //     return 499;  // The successor is completed with the value 499.
  //   } else {
  //     throw e;  // The successor is completed with the error e.
  //   }
  // });

  
}