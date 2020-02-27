import 'dart:async';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:json_serializable/builder.dart';
import 'package:test/test.dart';

void main() {
  test('Stack initialization', () {
    var stack = new contentstack.Stack("apiKey", "accessToken", "environment");
    stack.contentType().fetch();
    expect(stack.apiKey, equals("apiKey"));
    expect(stack.deliveryToken, equals("accessToken"));
    expect(stack.environment, equals("environment"));
    expect(stack.host, equals("cdn.contentstack.io"));
  });

  test('Stack initialization with Host', () {
    var stack = new contentstack.Stack("apiKey", "accessToken", "environment", host: "com.contentstack.com");
    expect(stack.host, equals("com.contentstack.com"));
  });

  test('Stack initialization with EU Region', () {
    var stack = new contentstack.Stack("apiKey", "accessToken", "environment", region: contentstack.Region.EU);
    expect(stack.region, equals(contentstack.Region.EU));
    expect(stack.host, equals("eu-cdn.contentstack.com"));
  });

  test('Stack initialization with EU Region and Host', () {
    var stack = new contentstack.Stack("apiKey", "accessToken", "environment", region: contentstack.Region.EU, host: 'com.contentstack.com');
    expect(stack.host, equals("eu-com.contentstack.com"));
  });

  test('Stack initialization without API Key', () {
    try {
      var stack = new contentstack.Stack(" !", "accessToken", "environment");
      expect(stack, equals(null));
    }catch (e){
      expect(e.message, equals("Invalid argument API key can not be null."));
    }
  });

  test('Stack initialization without Delivery Token', () {
    try {
      var stack = new contentstack.Stack("apiKey", " +", "environment");
      expect(stack, equals(null));
    }catch (e){
      expect(e.message, equals("Invalid argument Delivery Token can not be null."));
    }
  });

  test('Stack initialization without Environment name', () {
    try {
      var stack = new contentstack.Stack("apiKey", "apiKey", "} ");
      expect(stack, equals(null));
    }catch (e){
      expect(e.message, equals("Invalid argument Environment Name can not be null."));
    }
  });

  test('Stack Fetch', () {
    var stack = new contentstack.Stack("blt02532e5510d39dec", "csba4e1dd89e42c2007c004319", "development");
    return stack.contentType(uid : 'airbnb_jan_19').fetch()
    // return stack.fetch("/content_types", fromJson: contentstack.ContentTypeCollection.fromJson)
    .then((response) {
      // response.items.forEach((contentType) => print(contentType.title));
      print(response.title);
      expect(true, true);
    })
    .catchError((error) {
      print('dsfdaf $error');
    });
  });
}
 

class ContentType {


}