import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() {

  final Logger log = Logger('Stack');
  contentstack.Stack  stack;
  const apiKey = 'blt12c8ad610ff4ddc2';
  const deliveryToken = 'blt43359585f471685188b2e1ba';
  const environment = 'env1';

  setUp(() {
    stack = contentstack.Stack(apiKey, deliveryToken, environment);
  });

  test('check stack credentials', () {
    expect(stack.apiKey, apiKey);
    expect(stack.deliveryToken, deliveryToken);
    expect(stack.environment, environment);
    expect(stack.host, equals("cdn.contentstack.io"));
  });

  test('Stack initialization with Host', () {
    final stack = contentstack.Stack(
        "apiKey", "accessToken", "environment", host: "com.contentstack.com");
    expect(stack.host, equals("com.contentstack.com"));
  });

  test('Stack initialization with EU Region', () {
    final stack = contentstack.Stack(
        "apiKey", "accessToken", "environment", region: contentstack.Region.eu);
    expect(stack.region, equals(contentstack.Region.eu));
    expect(stack.host, equals("eu-cdn.contentstack.com"));
  });

  test('Stack initialization with EU Region and Host', () {
    final stack = contentstack.Stack(
        "apiKey", "accessToken", "environment", region: contentstack.Region.eu,
        host: 'com.contentstack.com');
    expect(stack.host, equals("eu-com.contentstack.com"));
  });

  test('Stack initialization without API Key', () {
    try {
      final stack = contentstack.Stack(" !", "accessToken", "environment");
      expect(stack, equals(null));
    } catch (e) {
      expect(e.message, equals("Must not be null"));
    }
  });

  test('Stack initialization without Delivery Token', () {
    try {
      final stack = contentstack.Stack("apiKey", " +", "environment");
      expect(stack, equals(null));
    } catch (e) {
      expect(e.message, equals("Must not be null"));
    }
  });

  test('Stack initialization without Environment name', () {
    try {
      final stack = contentstack.Stack("apiKey", "apiKey", "} ");
      expect(stack, equals(null));
    } catch (e) {
      expect(e.message, equals("Must not be null"));
    }
  });

  test('stack fetch getContentTypes', () async{
    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
    final queryParameters = {'include_count': 'true'};
   final resp =  await stack.getContentTypes(queryParameters);
   if( resp is Map){
     expect(true, resp.containsKey('content_types'));
   }
    log.fine(resp);
  });

//  test('stack get single content type', () {
//    final stack = contentstack.Stack(apiKey, deliveryToken, environment);
//    return stack.contentType('content_type').fetch();
//  });


  //-------------------------------------------------------------------------
  //ContentType//
  //-------------------------------------------------------------------------

  group('Group of testcases for ContentType', () {

    const apiKey = 'blt12c8ad610ff4ddc2';
    const deliveryToken = 'blt43359585f471685188b2e1ba';
    const environment = 'env1';

    setUp(() {
    });

    test('test client', () {
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final contentType = stack.contentType('news');
      log.fine(contentType.toString());
    });

    test('Returns instance of the  contentstack', () {
      bool isTypeOfContentType = false;
      final stack = contentstack.Stack(apiKey, deliveryToken, environment);
      final contentType = stack.contentType('contentTypeId');
      if (contentType is contentstack.ContentType) {
        isTypeOfContentType = true;
      }
      expect(true, isTypeOfContentType);
    });

  });



  group('Group of testcases for Synchronization', () {

    contentstack.Stack  stack;
    const apiKey = 'blt477ba55f9a67bcdf';
    const deliveryToken = 'cs7731f03a2feef7713546fde5';
    const environment = 'web';

    setUp(() {
      stack = contentstack.Stack(apiKey, deliveryToken, environment);
    });

//    test('sync initialisation response', () {
//      final syncResult = stack.sync(contentTypeUid: '', fromDate: "");
//      expect('actual', syncResult);
//    });
//
//    test('sync token response', () {
//      final syncResult = stack.syncToken('syncToken');
//      expect('actual', syncResult);
//    });
//
//    test('pagination token response', () {
//      final syncResult = stack.paginationToken('paginationToken');
//      expect('actual', syncResult);
//    });
//
//    test('sync with multiple params', () async {
//      final syncResult = await stack.sync();
//      expect('actual', syncResult);
//    });

  });


}