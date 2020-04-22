import 'package:contentstack/src/contenttype_query.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

import 'credentials.dart';

void main() {
  
  final Logger log = Logger('Stack');

  group('test functional testing', () {
    contentstack.ContentType contentType;
    setUp(() async {
      final stack = Credential.stack();
      contentType = stack.contentType('application_theme');
    });

    test('test network call for content type', () async {
      Map<String, String> map = {'key': 'value'};
      final response = await contentType.fetch(map);
      //expect(true, contentType.toString());
      log.finest(response);
    });

    test('test ContentTypeQuery instance', () {
      final checkInstance = contentType.query();
      expect(true, checkInstance is ContentTypeQuery);
    });
  });





  group('test contentTypeQuery API testing', () {
    
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
      final allContents = ct.query();
      final response = await allContents.includeCount().find();
      expect(11, response['count']);
    });

    test('test contenttype query', () async {
      final allContents = ct.query();
      await allContents.find(queryParams: {"include_count": "true"}).then((response){
        expect(11, response['count']);
      });
    });


  });

}
