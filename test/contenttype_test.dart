import 'package:contentstack/contentstack.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  final logger = Logger(printer: PrettyPrinter());

  load();
  final apiKey = env['apiKey'];
  final host = env['host'];
  final deliveryToken = env['deliveryToken'];
  final environment = env['environment'];
  final Stack stack = Stack(apiKey, deliveryToken, environment, host: host);
  final ContentType contentType = stack.contentType('application_theme');
  logger.i('credentials loaded..');
  group('testcase content type functional testing', () {
    test('test network call for content type', () async {
      final map = {'key': 'value'};
      final response = await contentType.fetch(map);
      expect(15, response['content_type']['schema'].length);
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
      expect(12, response['content_types'].length);
    });

    test('test include_count is available', () async {
      final allContents = contentType.query()..includeCount();
      await allContents.find().then((response) {
        expect(12, response['count']);
      }).catchError((error) {
        expect('invalid response', error.message);
      });
    });

    test('test contenttype query', () async {
      final allContents = contentType.query()..includeGlobalField();
      await allContents
          .find(queryParams: {'include_count': 'true'}).then((response) {
        expect(12, response['count']);
      });
    });
  });
}
