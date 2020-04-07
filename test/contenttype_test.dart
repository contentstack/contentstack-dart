import 'package:contentstack/src/contenttype_query.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

void main() {
  
  final Logger log = Logger('Stack');

  group('test functional testing', () {
    contentstack.ContentType contentType;
    setUp(() async {
      final stack = contentstack.Stack(
          'blt12c8ad610ff4ddc2', 'blt43359585f471685188b2e1ba', 'env1');
      contentType = stack.contentType('product');
    });

    test('test network call for content type', () async {
      final response = await contentType.fetch();
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
      final stack = contentstack.Stack(
          'blt12c8ad610ff4ddc2', 'blt43359585f471685188b2e1ba', 'env1');
      ct = stack.contentType();
    });

    test('test for all the contenttypes available', () async {
      final allContents = ct.query();
      final response = await allContents.find();
      expect(5, response['content_types'].length);
    });

    test('test include_count is available', () async {
      final allContents = ct.query();
      final response = await allContents.includeCount().find();
      expect(5, response['count']);
    });
  });

}
