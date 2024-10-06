import 'package:contentstack/contentstack.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/query_params.dart';
import 'package:dotenv/dotenv.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  final logger = Logger(printer: PrettyPrinter());

  var env = DotEnv(includePlatformEnvironment: true)..load();
  final apiKey = env['apiKey']!;
  final host = env['host'];
  final deliveryToken = env['deliveryToken']!;
  final environment = env['environment']!;
  final branch = 'development';
  logger.i('credentials loaded..');
  final Stack stack =
      Stack(apiKey, deliveryToken, environment, host: host, branch: branch);

  group('functional testcases for stack', () {
    test('check stack credentials', () {
      expect(stack.apiKey, apiKey);
      expect(stack.deliveryToken, deliveryToken);
      expect(stack.environment, environment);
      expect(stack.host, host);
      expect(stack.branch, branch);
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
        print('Error from Stack initialization without API Key : $e');
      }
    });

    test('stack initialization without Delivery Token', () {
      try {
        final stack = contentstack.Stack('apiKey', ' +', 'environment');
        expect(stack, equals(null));
      } catch (e) {
        print('Error from stack initialization without Delivery Token : $e');
      }
    });

    test('stack initialization without Environment name', () {
      try {
        final stack = contentstack.Stack('apiKey', 'apiKey', '} ');
        expect(stack, equals(null));
      } catch (e) {
        print('Error from stack initialization without Environment name : $e');
      }
    });

    // test('stack fetch getContentTypes', () async {
    //   final queryParameters = {'include_count': 'true'};
    //   final resp = await stack.getContentTypes(queryParameters);
    //   if (resp is Map) {
    //     expect(true, resp.containsKey('content_types'));
    //   }
    //   //logger.i(resp);
    // });

    test('testcases setHeader', () {
      final result = stack..setHeader('header1', 'headerValue');
      final finalResult = result..headers!['header1'];
      expect(true, finalResult.headers!.containsKey('header1'));
    });

    test('testcases setHeader', () {
      stack
        ..setHeader('header1', 'headerValue1')
        ..setHeader('header2', 'headerValue2')
        ..removeHeader('header2');
      expect(false, stack.headers!.containsKey('header2'));
    });
  });

  group('Group of testcases for ContentType', () {
    test('test content type urlPath', () {
      final contentType = stack.contentType('application_theme');
      expect('/v3/content_types/application_theme', contentType.urlPath);
    });

    test('testcases instance of the  content type', () {
      final contentType = stack.contentType('application_theme');
      expect(true, contentType is contentstack.ContentType);
    });

    test('testcases content type fetch uid', () async {
      final contentType = stack.contentType('application_theme');
      await contentType.fetch().then((response) {
        expect(response['error_code'] != null, true);
      });
    });

    test('testcases content_type_uid is missing', () async {
      try {
        final contentType = stack.contentType('application_theme');
        // ignore: cascade_invocations
        contentType.urlPath = null;
        await contentType.fetch().then((response) {}).catchError((error) {
          expect(error.message, equals('content_type_uid is missing'));
        });
      } catch (e) {
        print('Error from testcases content_type_uid is missing : $e');
      }
    });

    test('testcases queryParams.isNotEmpty', () async {
      final contentType = stack.contentType('application_theme');
      final params = {'keyOne': 'valueOne', 'keyTwo': 'valueTwo'};
      await contentType.fetch(params).then((response) {
        expect(15, response['content_type']['schema'].length);
      }).catchError((error) {
        expect(error != null, true);
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

    test('global fields without params', () {
      var response = stack.globalField();
      print(response);
    });

    test('Global fields with parameters', () {
      var response = stack.globalField('sso', false);
      print(response);
    });

    test('Global fields with parameters', () {
      var response = stack.globalField('sso', true);
      print(response);
    });
  });
}
