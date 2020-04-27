### contentstack example

###### import package

```bash
import 'dart:async';
import 'package:contentstack/contentstack.dart' as contentstack;
```

```bash

void main() {

  # Make call to get single asset by asset uid
  Future<dynamic> fetchAsset() async {
    final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
    await stack.asset('asset_uid').fetch().then((response) {
      print(response.toString());
    }).catchError((error) {
      print(error.message.toString());
    });
  }

  # Make call to get single entry by entry uid
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

  # Make call to apply query on Entry
  Future<dynamic> findQuery() async {
    final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
    final query = stack.contentType('content_type_uid').entry().query();
    await query.find().then((response) {
      print(response.toString());
    }).catchError((error) {
      print(error.message.toString());
    });
  }


  # Make call to apply query on asset
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

```
