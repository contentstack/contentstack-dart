import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

class Query extends BaseQuery{

  final HttpClient client;

  Query(this.client);

  /// find is applicable for querying the entry data.
//  Future find() async {
//    //https://cdn.contentstack.io/v3/content_types/product/entries?environment=production&locale=en-us
//    final uri =
//    Uri.https(_client.stack.endpoint, "/$_urlPath", queryParameter);
//    return _client.sendRequest(uri.toString());
//  }

  
}