import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/base_query.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'credentials.dart';

void main() {
  final Logger logger = Logger('Query');

  group('testcases for functional queries', () {
    contentstack.Query query;
    setUp(() {
      final contentstack.Stack stack = Credential.stack();
      query = stack.contentType('product').entry().query();
    });

    test('test environment is availabe to the url', () {
      final params = query.getQueryUrl();
      expect(true, params.containsKey('environment'));
      final key = params['environment'];
      logger.fine(key);
      expect(Credential.environment, key);
    });

    test('test where function parameter contains key', () async {
      query.where(Where.equals, 'uid', 'blta3b58d6893d8935b');
      final contains = query.getQueryUrl().containsKey('query');
      expect(true, contains);
    });

    test('test notContainedIn function parameter contains key', () async {
      final List<String> arrayValue = ['Roti Maker', 'kids dress'];
      query.where(Where.excludes, 'title', arrayValue);
      // final response = await query.find();
      // logger.fine(response);
      final contains = query.getQueryUrl()['query'];
      expect('{title: {\$nin: [Roti Maker, kids dress]}}', contains);
    });

    test('test skip function parameter contains key', () async {
      query.skip(4);
      final contains = query.getQueryUrl()['query'];
      expect('{skip: 4}', contains);
    });

    test('test limit function parameter contains key', () async {
      query.limit(4);
      final contains = query.getQueryUrl()['query'];
      expect('{limit: 4}', contains);
    });

    test('test orderByAscending function parameter contains key', () async {
      query.orderByAscending('title');
      final contains = query.getQueryUrl()['query'];
      expect('{asc: title}', contains);
    });

    test('test orderByDecending function parameter contains key', () async {
      query.orderByDecending('title');
      final contains = query.getQueryUrl()['query'];
      expect('{desc: title}', contains);
    });

    test('test param function parameter contains key', () async {
      query.param('titleKey', 'titleValue');
      final contains = query.getQueryUrl()['query'];
      expect('{titleKey: titleValue}', contains);
    });

    test('test addParam function parameter contains key', () async {
      query.addParam({'key': 'value', 'love': 'drawing'});
      final contains = query.getQueryUrl()['query'];
      expect('{key: value, love: drawing}', contains);
    });

    test('test query function parameter contains key', () async {
      query.query('queryKey', 'queryValue');
      final contains = query.getQueryUrl()['queryKey'];
      expect('queryValue', contains);
    });

    test('test add param function parameter contains key', () async {
      query.addQuery({'queryKey': 'queryValue', 'queryLove': 'queryDrawing'});
      final contains = query.getQueryUrl()['queryLove'];
      expect('queryDrawing', contains);
    });

    test('test chaining the functions', () async {
      query
        ..skip(4)
        ..limit(3)
        ..addQuery({'queryKey': 'queryValue', 'queryLove': 'queryDrawing'});
      final contains = query.getQueryUrl()['queryLove'];
      expect('queryDrawing', contains);
    });
  });

  group('testcases for API queries', () {
    // Note: Below testcase are not correct (Re-write required)
    contentstack.Query query;
    setUp(() {
      final contentstack.Stack stack = Credential.stack();
      query = stack.contentType('faq').entry().query();
    });

    test('test length of the entry of respected contentType', () async {
      final response = query.find();
      await response.then((response) {
        logger.fine('query response: $response');
        expect(3, response['entries'].length);
      });
    });

    test('test notContainedIn function parameter contains key', () async {
      final List<String> arrayValue = ['MEALS'];
      query.where(Where.equals, 'title', arrayValue);
      await query.find().then((response) {
        final queryMap = response['entries'];
        expect(3, queryMap.length);
      });
    });

    test('test notContainedIn function parameter contains key', () async {
      query.where(Where.equals, 'title', 'MEALS');
      final response = await query.find();
      logger.fine(response);
      expect(3, response['entries'].length);
    });
  });
}
