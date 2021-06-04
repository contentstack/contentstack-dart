import 'package:logger/logger.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/query_params.dart';
import 'package:contentstack/src/sync/publishtype.dart';

void main() {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  load();
  final apiKey = env['apiKey'];
  final host = env['host'];
  //final branch = 'development';
  final deliveryToken = env['deliveryToken'];
  final environment = env['environment'];
  final Stack stack = Stack(
    apiKey,
    deliveryToken,
    environment,
    host: host,
    //branch: 'development',
  );

  group('functional testcases for stack', () {
    test('check stack credentials', () {
      expect(stack.apiKey, apiKey);
      expect(stack.deliveryToken, deliveryToken);
      expect(stack.environment, environment);
      expect(stack.host, host);
      //expect(stack.branch, branch);
    });

    test('Stack initialization with Host', () {
      final stack = contentstack.Stack('apiKey', 'accessToken', 'environment',
          host: 'com.contentstack.com');
      expect(stack.host, equals('com.contentstack.com'));
    });

    test('Stack initialization with EU Region', () {
      final stack = contentstack.Stack('apiKey', 'accessToken', 'environment',
          region: contentstack.Region.eu);
      expect(stack.region, equals(contentstack.Region.eu));
      expect(stack.host, equals('eu-cdn.contentstack.com'));
    });

    test('Stack initialization with EU Region and Host', () {
      final stack = contentstack.Stack('apiKey', 'accessToken', 'environment',
          region: contentstack.Region.eu, host: 'com.contentstack.com');
      expect(stack.host, equals('eu-com.contentstack.com'));
    });

    test('Stack initialization without API Key', () {
      try {
        final stack = contentstack.Stack(' !', 'accessToken', 'environment');
        expect(stack, equals(null));
      } catch (e) {
        expect(e.message, equals('Must not be null'));
      }
    });

    test('stack initialization without Delivery Token', () {
      try {
        final stack = contentstack.Stack('apiKey', ' +', 'environment');
        expect(stack, equals(null));
      } catch (e) {
        expect(e.message, equals('Must not be null'));
      }
    });

    test('stack initialization without Environment name', () {
      try {
        final stack = contentstack.Stack('apiKey', 'apiKey', '} ');
        expect(stack, equals(null));
      } catch (e) {
        expect(e.message, equals('Must not be null'));
      }
    });

    test('stack fetch getContentTypes', () async {
      final queryParameters = {'include_count': 'true'};
      final resp = await stack.getContentTypes(queryParameters);
      if (resp is Map) {
        expect(true, resp.containsKey('content_types'));
      }
      //logger.i(resp);
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
        // ignore: cascade_invocations
        contentType.urlPath = null;
        await contentType.fetch().then((response) {}).catchError((error) {});
      } catch (e) {
        expect(e.message, equals('content_type_uid is missing'));
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
    test('sync initialisation response', () async {
      final response = stack.sync<SyncResult, Null>(locale: 'en-us');
      await response.then((response) {
        expect(123, response.totalCount);
        expect(null, response.syncToken);
        //expect('bltd0057e4d71a3c73edb67f0', response.paginationToken);
        logger.d(response.paginationToken);
      });
    });

    test('sync token response', () async {
      final response =
          stack.syncToken<SyncResult, Null>('blta2662861c53ebf7cab51e7');
      await response.then((response) {
        expect(34, response.totalCount);
      });
    });

    test('pagination token response', () async {
      final response =
          stack.paginationToken<SyncResult, Null>('blt233312100c58dbf9a56bfa');
      await response.then((response) {
        logger.d(response.syncToken);
        //expect('blt6f2199c246a2d93fb743f6', response.syncToken);
      });
    });

    test('sync with multiple params assetPublished', () async {
      final response = stack.sync<SyncResult, Null>(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.assetPublished());
      await response.then((response) {
        expect(100, response.limit);
      });
    });

    test('sync with multiple params assetUnpublished', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.assetUnpublished());
      await response.then((response) {
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params assetDeleted', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.assetDeleted());
      await response.then((response) {
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params entryPublished', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.entryPublished());
      await response.then((response) {
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params entryUnpublished', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.entryUnpublished());
      await response.then((response) {
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params entryDeleted', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.entryDeleted());
      await response.then((response) {
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params contentTypeDeleted', () async {
      final response = stack.sync(
          fromDate: '12-01-2020',
          locale: 'en-us',
          publishType: PublishType.contentTypeDeleted());
      await response.then((response) {
        expect(100, response['items'].length);
      });
    });

    test('sync with multiple params content_type_uid', () async {
      await stack.sync(contentTypeUid: 'testuid').then((response) {
        final error = contentstack.Error.fromJson(response);
        expect(true, error.toJson() is Map);
        expect(error.errorMessage, response['error_message']);
      });
    });
  });

  group('testcase for URLQueryParams', () {
    test('test query_params', () {
      final params = URLQueryParams()..append('key', 'value');
      final url = params.toUrl('cdn.contentstack.io/');
      expect('cdn.contentstack.io?key=value', url);
    });

    test('query_params', () {
      final params = URLQueryParams()
        ..append('key', 'value')
        ..append('key1', 'value1')
        ..remove('key');
      final url = params.toUrl('cdn.contentstack.io');
      expect('cdn.contentstack.io?key1=value1', url);
    });
  });
}
