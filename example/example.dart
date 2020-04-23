import 'dart:async';
import 'package:contentstack/contentstack.dart' as contentstack;

void main() {

  Future<dynamic> fetchAsset() async {
    final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
    await stack.asset('asset_uid').fetch().then((response) {
      print(response.toString());
    }).catchError((error) {
      print(error.message.toString());
    });
  }

  Future<dynamic> fetchEntry() async {
    final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
    final entry =
        stack.contentType('content_type_uid').entry(entryUid: 'entry_uid');
    await entry.fetch().then((response) {
      print(response.toString());
    }).catchError((error) {
      print(error.message.toString());
    });
  }

  Future<dynamic> findQuery() async {
    final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
    final query = stack.contentType('content_type_uid').entry().query();
    await query.find().then((response) {
      print(response.toString());
    }).catchError((error) {
      print(error.message.toString());
    });
  }


  Future<dynamic> findAssetQuery() async {
   final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
   final assetQuery = stack.assetQuery();
   assetQuery..includeDimension()..relativeUrls();
   await assetQuery.find().then((response) {
    print(response.toString());
   }).catchError((error) {
    print(error.message.toString());
   });
  }

}
