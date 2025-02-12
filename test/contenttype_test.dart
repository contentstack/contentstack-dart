import 'package:contentstack/contentstack.dart';
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
  final contentTypeUid = env['contentType'];
  final Stack stack = Stack(apiKey, deliveryToken, environment, host: host);
  final ContentType contentType = stack.contentType(contentTypeUid);
  logger.i('credentials loaded..');
  group('testcase content type functional testing', () {
    test('test network call for content type', () async {
      final map = {'key': 'value'};
      final response = await contentType.fetch(map);
      expect(response['content_type']['schema'].length, 12);
    });

    test('test ContentTypeQuery instance', () {
      final checkInstance = contentType.query();
      expect(true, checkInstance is ContentTypeQuery);
    });
  });

  group('testcases contentTypeQuery functional', () {
    test('test for all the content types available', () async {
      final allContents = contentType.query();
      final response = await allContents.find();
      expect(response['content_types'].length,10);
    });

    test('test include_count is available', () async {
      final allContents = contentType.query()..includeCount();
      await allContents.find().then((response) {
        expect(response['count'],10);
      }).catchError((error) {
        expect('invalid response', error.message);
      });
    });

    test('test contenttype query', () async {
      final allContents = contentType.query()..includeGlobalField();
      await allContents
          .find(queryParams: {'include_count': 'true'}).then((response) {
        expect(response['count'],10);
      });
    });
  });
}
