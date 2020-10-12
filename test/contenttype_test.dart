import 'package:contentstack/src/contenttype_query.dart';
import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:logger/logger.dart';
import 'credentials.dart';

void main() {
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  group('testcase contenttype functional testing', () {
    contentstack.ContentType contentType;
    setUp(() async {
      final stack = Credential.stack();
      contentType = stack.contentType('application_theme');
    });

    test('test network call for content type', () async {
      final map = {'key': 'value'};
      final response = await contentType.fetch(map);
      //expect(true, contentType.toString());
      logger.i(response);
    });

    test('test ContentTypeQuery instance', () {
      final checkInstance = contentType.query();
      expect(true, checkInstance is ContentTypeQuery);
    });
  });

  group('testcases contentTypeQuery functional', () {
    contentstack.ContentType ct;
    setUp(() {
      final stack = Credential.stack();
      ct = stack.contentType();
    });

    test('test for all the contenttypes available', () async {
      final allContents = ct.query();
      final response = await allContents.find();
      expect(11, response['content_types'].length);
    });

    test('test include_count is available', () async {
      final allContents = ct.query()..includeCount();
      await allContents.find().then((response) {
        expect(11, response['count']);
      }).catchError((error) {
        expect('invalid response', error.message);
      });
    });

    test('test contenttype query', () async {
      final allContents = ct.query()..includeGlobalField();
      await allContents
          .find(queryParams: {'include_count': 'true'}).then((response) {
        expect(11, response['count']);
      });
    });
  });
}
