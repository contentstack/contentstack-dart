import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/query_params.dart';
import 'package:contentstack/src/sync/publishtype.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'credentials.dart';

void main() {
  final Logger log = Logger('Stack');
  group('functional testcases for stack', () {
    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });

    test('check stack credentials', () {
      expect(stack.apiKey, Credential.apiKey);
      expect(stack.deliveryToken, Credential.deliveryToken);
      expect(stack.environment, Credential.environment);
      expect(stack.host, equals("cdn.contentstack.io"));
    });

    test('Stack initialization with Host', () {
      final stack = contentstack.Stack("apiKey", "accessToken", "environment",
          host: "com.contentstack.com");
      expect(stack.host, equals("com.contentstack.com"));
    });

    test('Stack initialization with EU Region', () {
      final stack = contentstack.Stack("apiKey", "accessToken", "environment",
          region: contentstack.Region.eu);
      expect(stack.region, equals(contentstack.Region.eu));
      expect(stack.host, equals("eu-cdn.contentstack.com"));
    });

    test('Stack initialization with EU Region and Host', () {
      final stack = contentstack.Stack("apiKey", "accessToken", "environment",
          region: contentstack.Region.eu, host: 'com.contentstack.com');
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

    test('stack initialization without Delivery Token', () {
      try {
        final stack = contentstack.Stack("apiKey", " +", "environment");
        expect(stack, equals(null));
      } catch (e) {
        expect(e.message, equals("Must not be null"));
      }
    });

    test('stack initialization without Environment name', () {
      try {
        final stack = contentstack.Stack("apiKey", "apiKey", "} ");
        expect(stack, equals(null));
      } catch (e) {
        expect(e.message, equals("Must not be null"));
      }
    });

    test('stack fetch getContentTypes', () async {
      final queryParameters = {'include_count': 'true'};
      final resp = await stack.getContentTypes(queryParameters);
      if (resp is Map) {
        expect(true, resp.containsKey('content_types'));
      }
      log.fine(resp);
    });

    test('testcases setHeader', () {
      final result = stack..setHeader('header1', 'headerValue');
      final finalResult = result..stackHeader['header1'];
      expect(true, finalResult.stackHeader.containsKey('header1'));
    });

    test('testcases setHeader', () {
      stack
        ..setHeader('header1', 'headerValue1')
        ..setHeader('header2', 'headerValue2')
        ..removeHeader('header2');
      expect(false, stack.stackHeader.containsKey('header2'));
    });
  });

  group('Group of testcases for ContentType', () {
    contentstack.Stack stack;

    setUp(() {
      stack = Credential.stack();
    });

    test('test contenttype urlPath', () {
      final contentType = stack.contentType('application_theme');
      expect('/v3/content_types/application_theme', contentType.urlPath);
    });

    test('testcases instance of the  contenttype', () {
      final contentType = stack.contentType('application_theme');
      expect(true, contentType is contentstack.ContentType);
    });

    test('testcases contenttype fetch uid', () async {
      final contentType = stack.contentType('application_theme');
      await contentType.fetch().then((response) {
        expect('application_theme', response['content_type']['uid']);
      });
    });

    test('testcases content_type_uid is missing', () async {
      try {
        final contentType = stack.contentType('application_theme');
        contentType.urlPath = null;
        await contentType.fetch().then((response) {}).catchError((error) {});
      } catch (e) {
        expect(e.message, equals("content_type_uid is missing"));
      }
    });

    test('testcases queryParams.isNotEmpty', () async {
      final contentType = stack.contentType('application_theme');
      final params = {'keyOne': 'valueOne', 'keyTwo': 'valueTwo'};
      await contentType.fetch(params).then((response) {
        expect(15, response['content_type']['schema'].length);
      }).catchError((error) {
        expect('response', error.toString());
      });
    });
  });

  group('testcases for API Synchronization', () {
    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });

    test('sync initialisation response', () async {
      final response = stack.sync(locale: 'en-us');
      await response.then((response) {
        log.fine('Data set success $response');
        expect(true, response['items'] is List);
        expect(true, response['skip'] is int);
        expect(true, response['limit'] is int);
        expect(true, response['total_count'] is int);
      });
    });

    test('sync token response', () async {
      final response = stack.syncToken('blta2662861c53ebf7cab51e7');
      await response.then((response) {
        final syncResult = contentstack.SyncResult.fromJson(response);
        expect(true, syncResult is contentstack.SyncResult);
        expect(true, syncResult.toJson() is Map);
        //expect('bltbf04c67021273a169e6099', syncResult.syncToken);
      });
    });

//    test('pagination token response', () async {
//      final response = stack.paginationToken('blt4a508e188c98d4c94c3616');
//      await response.then((response) {
//        //log.fine('Data set success $response');
//        expect('blt52d57c3323c29c6455e5fa', response['sync_token']);
//      });
//    });

    test('sync with multiple params assetPublished', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.assetPublished());
      await response.then((response) {
        //log.fine('Data set success $response');
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params assetUnpublished', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.assetUnpublished());
      await response.then((response) {
        //log.fine('Data set success $response');
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params assetDeleted', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.assetDeleted());
      await response.then((response) {
        log.fine('Data set success $response');
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params entryPublished', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.entryPublished());
      await response.then((response) {
        log.fine('Data set success $response');
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params entryUnpublished', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.entryUnpublished());
      await response.then((response) {
        log.fine('Data set success $response');
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params entryDeleted', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.entryDeleted());
      await response.then((response) {
        log.fine('Data set success $response');
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params contentTypeDeleted', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.contentTypeDeleted());
      await response.then((response) {
        log.fine('Data set success $response');
        expect(100, response['items'].length);
      });
    });
  });

  group('testcase for httpclient coverage', () {
    //    test('client code coverage test for send function', () async{
//      final Map<String, String> mapHeaders = {
//        'api_key' : 'test_api_key',
//        'access_token' : 'test_access_token',
//        'delivery_token' : 'test_delivery_token',
//      };
//      BaseClient client;
//      try{
//        final httpClient = HttpClient(mapHeaders, client: client, stack: stack);
//        final httpResp = await httpClient.sendRequest('https://cdn.contentstack.io');
//        httpResp.then((onResponse){
//          log.fine(onResponse.toString());
//        }).catchError((onError){
//          log.fine(onError.toString());
//        });
//        //expect(3, );
//      }catch(e){
//        expect(e.message.toString(), "Returned value was not JSON. Did the uri end with \'.json\'?");
//      }
//
//
//    });

//    test('client code coverage close instance', () async{
//      final Map<String, String> mapHeaders = {
//        'api_key' : 'test_api_key',
//        'access_token' : 'test_access_token',
//        'delivery_token' : 'test_delivery_token',
//      };
//      BaseClient client;
//      try{
//        final httpClient = HttpClient(mapHeaders, client: client, stack: stack);
//        httpClient.close();
//        final response = await httpClient.sendRequest('https://cdn.contentstack.io');
//        response.then((onError){}).then((response){});
//        expect(true, httpClient.stackHeaders.containsKey('delivery_token'));
//      }catch(e){
//        expect(e.message.toString(), "Returned value was not JSON. Did the uri end with \'.json\'?");
//      }
//    });
    test('test query_params', () {
      final params = URLQueryParams();
      params.append('key', 'value');
      final url = params.toUrl('cdn.contentstack.io/');
      expect("cdn.contentstack.io?key=value", url);
    });

    test('query_params', () {
      final params = URLQueryParams();
      params
        ..append('key', 'value')
        ..append('key1', 'value1')
        ..remove('key');
      final url = params.toUrl('cdn.contentstack.io');
      expect('cdn.contentstack.io?key1=value1', url);
    });
  });
}
