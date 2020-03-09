import 'dart:developer';
import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:test/test.dart';

void main() {

  const apiKey = 'blt02f7b45378b008ee';
  const deliveryToken = 'bltb327f978f247e1c8';
  const environment = 'dev';
  final stack = contentstack.Stack(apiKey, deliveryToken, environment);



  test('check stack credentials', () {
    expect(stack.stackHeader['api_key'], apiKey);
    expect(stack.stackHeader['access_token'], deliveryToken);
    expect(stack.stackHeader['environment'], environment);
    expect('stack.host', equals("cdn.contentstack.io"));
  });

  test('Stack initialization', () {
    stack.contentType('news').fetch();
    expect('stack.host', equals("cdn.contentstack.io"));
  });

  test('Stack initialization with Host', () {
    final stack = contentstack.Stack("apiKey", "accessToken", "environment", host: "com.contentstack.com");
    expect('stack.host', equals("com.contentstack.com"));
  });

  test('Stack initialization with EU Region', () {
    final stack = contentstack.Stack("apiKey", "accessToken", "environment", region: contentstack.Region.EU);
    expect(stack.region, equals(contentstack.Region.EU));
    expect('stack.host', equals("eu-cdn.contentstack.com"));
  });

  test('Stack initialization with EU Region and Host', () {
    final stack = contentstack.Stack("apiKey", "accessToken", "environment", region: contentstack.Region.EU, host: 'com.contentstack.com');
    expect('stack.host', equals("eu-com.contentstack.com"));
  });

  test('Stack initialization without API Key', () {
    try {
      final stack = contentstack.Stack(" !", "accessToken", "environment");
      expect(stack, equals(null));
    }catch (e){
      expect(e.message, equals("Invalid argument API key can not be null."));
    }
  });

  test('Stack initialization without Delivery Token', () {
    try {
      final stack = contentstack.Stack("apiKey", " +", "environment");
      expect(stack, equals(null));
    }catch (e){
      expect(e.message, equals("Invalid argument Delivery Token can not be null."));
    }
  });

  test('Stack initialization without Environment name', () {
    try {
      final stack = contentstack.Stack("apiKey", "apiKey", "} ");
      expect(stack, equals(null));
    }catch (e){
      expect(e.message, equals("Invalid argument Environment Name can not be null."));
    }
  });

  test('Stack Fetch', () {
    final stack = contentstack.Stack("blt02532e5510d39dec", "csba4e1dd89e42c2007c004319", "development");
    return stack.contentType('airbnb_jan_19').fetch();
    // return stack.fetch("/content_types", fromJson: contentstack.ContentTypeCollection.fromJson)
//    .then((response) {
//      // response.items.forEach((contentType) => print(contentType.title));
//      //print(response.title);
//      expect(true, true);
//    })
//    .catchError((error) {
//      log('dsfdaf $error');
//    });
  });



  //-------------------------------------------------------------------------
                 //ContentType//
  //-------------------------------------------------------------------------


  group('ContentType testcases', () {

    test('Future.value() returns the value', () async {
      var stack = contentstack.Stack('apiKey', 'deliveryToke', 'environment', host: 'cdn.contentstack.io', apiVersion: 'v3');
      expect(apiKey, 'apiKey');
    });

    test('Future.value() returns the value', () async {
      var value = await Future.value(10);
      expect(value, equals(10));
    });

  });

  test('contenttype initialisation', () {
    stack.contentType('news').fetch();
    expect('stack.host', equals("cdn.contentstack.io"));
  });


  test('test client', () {
    final stack = contentstack.Stack('blt8473847', 'deliveryToken', 'developpment');
    final contentType = stack.contentType('news');
    final entry = contentType.entry('blt8378026266').version(3).locale('en-love').find();
    log(entry.toString());
  });


  test('test client', () {
    final stack = contentstack.Stack('blt8473847', 'deliveryToken', 'developpment');
    final contentType = stack.contentType('news');
    final entry = contentType.entry('blt8378026266').version(3).locale('en-love').find();
    log(entry.toString());
  });

}
 
