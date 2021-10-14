import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/enums/include.dart' as include;
import 'package:contentstack/src/enums/operations.dart';
import 'package:contentstack/src/enums/operator.dart';
import 'package:contentstack/src/enums/reference.dart';
import 'package:contentstack/src/models/entrymodel.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:test/test.dart';

void main() {
  group('testcases for functional base queries', () {
    Query query;
    var apiKey = '', environment = '', deliveryToken = '', host = '';
    Stack stack;

    setUpAll(() async {
      load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey, deliveryToken, environment, host: host);
    });

    setUp(() async {
      query = stack.contentType('room').entry().query();
    });

    test('test environment is available to the url', () {
      final params = query.getQueryUrl();
      expect(true, params.containsKey('environment'));
      final envKey = params['environment'];
      expect(environment, envKey);
    });

    test('test where equals Operation', () async {
      query.where('uid', QueryOperation.equals(value: 'blt8493859348'));
      final contains = query.getQueryUrl().toString();
      expect('{environment: development, query: {"uid":"blt8493859348"}}',
          contains);
    });

    test('test where notEquals operation', () async {
      query.where('attendee', QueryOperation.notEquals(value: '40'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"attendee\":{\"\$ne\":\"40\"}}', contains);
    });

    test('test where includes Operation', () async {
      const includeList = ['abc', 'def', 'uiweu'];
      query.where('uid', QueryOperation.includes(value: includeList));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$in\":[\"abc\",\"def\",\"uiweu\"]}}', contains);
    });

    test('test where excludes Operation', () async {
      const includeList = ['abc', 'def', 'uiweu'];
      query.where('uid', QueryOperation.excludes(value: includeList));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$nin\":[\"abc\",\"def\",\"uiweu\"]}}', contains);
    });

    test('test where exists Operation', () async {
      query.where('uid', QueryOperation.exists(value: true));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$exists\":true}}', contains);
    });

    test('test where isGreaterThan Operation', () async {
      query.where('uid', QueryOperation.isGreaterThan(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$gt\":\"price\"}}', contains);
    });

    test('test where isGreaterThanOrEqual Operation', () async {
      query.where('uid', QueryOperation.isGreaterThanOrEqual(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$gte\":\"price\"}}', contains);
    });

    test('test where isLessThan Operation', () async {
      query.where('uid', QueryOperation.isLessThan(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$lt\":\"price\"}}', contains);
    });

    test('test where isLessThanOrEqual Operation', () async {
      query.where('uid', QueryOperation.isLessThanOrEqual(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$lte\":\"price\"}}', contains);
    });

    test('test where matches Operation', () async {
      query.where('uid', QueryOperation.matches(regex: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$regex\":\"price\"}}', contains);
    });

    test('test limit function parameter contains key', () async {
      query.limit(4);
      final contains = query.getQueryUrl()['limit'];
      expect('4', contains);
    });

    test('functional test query orderByAscending', () async {
      query.orderByAscending('attendee');
      final contains = query.getQueryUrl()['asc'];
      expect('attendee', contains);
    });

    test('test orderByDescending function parameter contains key', () async {
      query.orderByDescending('attendee');
      final contains = query.getQueryUrl()['desc'];
      expect('attendee', contains);
    });

    test('test param function parameter contains key', () async {
      query.param('titleKey', 'titleValue');
      final contains = query.getQueryUrl();
      expect('{environment: development, titleKey: titleValue}',
          contains.toString());
    });

    test('test addParam function parameter contains key', () async {
      query
        ..addParams({'key1': 'value1', 'key2': 'value2', 'key3': 'value3'})
        ..removeHeader('environment');
      final contains = query.getQueryUrl().length;
      expect(4, contains);
    });

    test('test query function parameter contains key', () async {
      query.query('queryKey', 'queryValue');
      final contains = query.getQueryUrl()['query'];
      expect('{\"queryKey\":\"queryValue\"}', contains);
    });

    test('test add param function parameter contains key', () async {
      query.addQuery({'queryKey': 'queryValue', 'queryLove': 'queryDrawing'});
      final contains = query.getQueryUrl()['query'];
      expect('{\"queryKey\":\"queryValue\",\"queryLove\":\"queryDrawing\"}',
          contains);
    });

    test('functional cascade of skip and limit', () async {
      query
        ..skip(4)
        ..limit(3);
      final contains = query.getQueryUrl();
      expect(true, contains.containsKey('limit'));
      expect(true, contains.containsKey('skip'));
    });
  });

  group('functional testcases for the Query class', () {
    Query query;
    var apiKey = '', environment = '', deliveryToken = '', host = '';
    Stack stack;

    setUpAll(() async {
      load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey, deliveryToken, environment, host: host);
    });
    setUp(() async {
      query = stack.contentType('faq').entry().query();
    });

    test('testcase setHeader for the query class', () async {
      query.setHeader('key', 'value');
      await query.find().then((response) {
        expect(3, response['entries'].length);
      });
    });
  });

  group('testcases for API queries', () {
    Query query;
    var apiKey = '', environment = '', deliveryToken = '', host = '';
    Stack stack;

    setUpAll(() async {
      load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey, deliveryToken, environment, host: host);
    });

    setUp(() async {
      query = stack.contentType('room').entry().query();
    });

    test('test length of the entry of respected contentType', () async {
      final response = query.find();
      await response.then((response) {
        expect(29, response['entries'].length);
      });
    });

    test('test where equals API Operation', () async {
      query.where('attendee', QueryOperation.equals(value: 10));
      await query.find().then((response) {
        final int attendee = response['entries'][0]['attendee'];
        expect(10, attendee);
      });
    });

    test('test notContainedIn in Query', () async {
      await query.find().then((response) async {
        final queryLength = response['entries'].length;
        final List<String> arrayValue = ['Room 13', 'Room 14', 'Room 17'];
        query.where('title', QueryOperation.excludes(value: arrayValue));
        await query.find().then((response) {
          final queryMap = response['entries'].length;
          final ninQueryLength = queryLength - arrayValue.length;
          expect(ninQueryLength, queryMap);
        });
      });
    });

    test('test notContainedIn function parameter contains key', () async {
      query.where('attendee', QueryOperation.notEquals(value: 20));
      await query.find<List<EntryModel>, EntryModel>().then((response) {
        expect(28, response.length);
      });
    });

    test('test notEquals in Query', () async {
      query.where('attendee', QueryOperation.notEquals(value: 20));
      await query.find().then((response) {
        expect(28, response['entries'].length);
      });
    });

    test('test includes in Query', () async {
      final includeList = ['Room 13', 'Room 18', 'Room 19'];
      query.where('title', QueryOperation.includes(value: includeList));
      await query.find().then((response) {
        expect(includeList.length, response['entries'].length);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test excludes in Query', () async {
      final includeList = ['Room 13', 'Room 18', 'Room 19'];
      query.where('title', QueryOperation.excludes(value: includeList));
      await query.find().then((response) {
        expect(26, response['entries'].length);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isLessThan in Query', () async {
      query.where('attendee', QueryOperation.isLessThan(value: 50));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        // ignore: prefer_final_in_for_each
        for (var entry in listOfEntry) {
          expect(true, entry['attendee'] < 50);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isLessThanOrEqual in Query', () async {
      query.where('attendee', QueryOperation.isLessThanOrEqual(value: 50));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        // ignore: prefer_final_in_for_each
        for (var entry in listOfEntry) {
          expect(true, entry['attendee'] < 50);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isGreaterThan in Query', () async {
      query.where('attendee', QueryOperation.isGreaterThan(value: 50));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        for (final entry in listOfEntry) {
          expect(true, entry['attendee'] > 50);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isGreaterThanOrEqual in Query', () async {
      query.where('attendee', QueryOperation.isGreaterThanOrEqual(value: 70));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        for (final entry in listOfEntry) {
          expect(true, entry['attendee'] >= 70);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test exists in Query', () async {
      query.where('attendee', QueryOperation.exists(value: true));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        print(listOfEntry.length);
        expect(29, listOfEntry.length);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test matches in Query', () async {
      query.where('title', QueryOperation.matches(regex: 'Room'));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        expect(29, listOfEntry.length);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test whereReference in Query', () async {
      final queryBase = stack.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase.where('title', QueryOperation.equals(value: 'Room 14'));
      query.whereReference('brand', QueryReference.include(query: queryBase));
      await query.find().then((response) {
        expect(
            'Failed to fetch entries. Please try again with valid parameters.',
            response['error_message']);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test whereReference NinQuery', () async {
      final queryBase = stack.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase.where('title', QueryOperation.equals(value: 'Room 14'));
      query.whereReference(
          'fieldUid', QueryReference.notInclude(query: queryBase));
      await query.find().then((response) {
        expect(
            'Failed to fetch entries. Please try again with valid parameters.',
            response['error_message']);
      });
    });

    test('test operator And in Query', () async {
      final queryBase1 = stack.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));

      final stackInstance2 = stack;
      final queryBase2 = stackInstance2.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase2.where('attendee', QueryOperation.equals(value: 20));

      final List<Query> listOfQuery = [queryBase1, queryBase2];
      query.operator(QueryOperator.and(queryObjects: listOfQuery));
      await query.find().then((response) {
        final completeUrl = query.getQueryUrl()['query'];
        //print(response.toString());
        expect('{\"\$and\":[{\"title\":\"Room 13\"},{\"attendee\":20}]}',
            completeUrl);
      }).catchError((onError) {
        expect("Failed host lookup: 'cdn.contentstack.io'", onError.message);
      });
    });

    test('test operator OR in Query', () async {
      final stackInstance1 = stack;
      final queryBase1 = stackInstance1.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));

      final stackInstance2 = stack;
      final queryBase2 = stackInstance2.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase2.where('attendee', QueryOperation.equals(value: 20));

      final List<Query> listOfQuery = [queryBase1, queryBase2];
      query.operator(QueryOperator.or(queryObjects: listOfQuery));
      await query.find().then((response) {
        final completeUrl = query.getQueryUrl()['query'];
        //(response.toString());
        expect('{\"\$or\":[{\"title\":\"Room 13\"},{\"attendee\":20}]}',
            completeUrl);
      }).catchError((onError) {
        expect("Failed host lookup: 'cdn.contentstack.io'", onError.message);
      });
    });

    test('test query skip ', () async {
      var originalLength = 0; // final all the entry length
      const skip = 4; // select how many to entries to skip
      // skipLength will be : (originalLength - skip)
      var skipLength = 0;
      await query.find().then((onResponse) async {
        // Make first call
        originalLength = onResponse['entries'].length;
        query.skip(4); // apply skip
        await query.find().then((response) {
          // Make second call
          skipLength = response['entries'].length;
        });
      });
      expect(skipLength, originalLength - skip);
    });

    test('test query orderByAscending', () async {
      query.orderByAscending('attendee');
      final contains = query.getQueryUrl()['asc'];
      await query.find().then((response) {
        final ascList = response['entries'];
        int oldAttendee;
        int counter = 0;
        for (final item in ascList) {
          if (counter != 0) {
            final newValue = item['attendee'];
            oldAttendee = item['attendee'];
            if (oldAttendee <= newValue) {
              expect(true, true);
            } else {
              expect(true, false);
            }
          }
          counter++;
        }
      });
      expect('attendee', contains);
    });
  });

  group('testcases for entry queryable', () {
    Query query;
    var apiKey = '', environment = '', deliveryToken = '', host = '';
    Stack stack;

    setUpAll(() async {
      load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey, deliveryToken, environment, host: host);
    });

    setUp(() async {
      query = stack.contentType('room').entry().query();
    });

    test('query testcase locale and only base functional test', () {
      query
        ..locale('en-us')
        ..only(['price_in_usd']);
      final url = query.getQueryUrl();
      expect(true, url.containsKey('only[BASE][]'));
      expect('[price_in_usd]', url['only[BASE][]']);
      expect('en-us', url['locale']);
    });

    test('query testcase only base', () {
      query
        ..locale('en-us')
        ..only(['price_in_usd']);
      final result = query.getQueryUrl();
      expect('[price_in_usd]', result['only[BASE][]']);
    });

    test('query testcase locale except base', () {
      query
        ..locale('en-us')
        ..except(['field1', 'field2', 'field3', 'field4']);
      final url = query.getQueryUrl();
      expect('[field1, field2, field3, field4]', url['except[BASE][]']);
    });

    test('query testcase functions for entry Queryable', () {
      const uiFieldList = ['uifield1', 'uifield2', 'uifield3'];
      query
        ..locale('en-us')
        ..except(['field1', 'field2', 'field3', 'field4'])
        ..includeReference('referenceFieldUid',
            includeReferenceField:
                include.Include.none(fieldUidList: uiFieldList))
        ..includeContentType()
        ..includeReferenceContentTypeUID()
        ..addParam('key', 'value');
      final result = query.getQueryUrl();
      expect('en-us', result['locale']);
      expect('[referenceFieldUid, uifield1, uifield2, uifield3]',
          result['include[]']);
      expect('[field1, field2, field3, field4]', result['except[BASE][]']);
      expect('true', result['include_content_type']);
      expect('true', result['include_global_field_schema']);
      expect('true', result['include_reference_content_type_uid']);
      expect('value', result['key']);
    });

    test('query testcase reference only entry queryable', () {
      const uiFieldList = ['uifield1', 'uifield2', 'uifield3'];
      query
        ..locale('en-us')
        ..includeReference('referenceFieldUid',
            includeReferenceField:
                include.Include.only(fieldUidList: uiFieldList));
      final result = query.getQueryUrl();
      expect('referenceFieldUid', result['include[]']);
      expect('{referenceFieldUid: [uifield1, uifield2, uifield3]}',
          result['only']);
    });

    test('query testcase reference except entry queryable', () {
      const uiFieldList = ['uifield1', 'uifield2', 'uifield3'];
      query
        ..locale('en-us')
        ..includeReference('referenceFieldUid',
            includeReferenceField:
                include.Include.except(fieldUidList: uiFieldList));
      final result = query.getQueryUrl();
      expect('referenceFieldUid', result['include[]']);
      expect('{referenceFieldUid: [uifield1, uifield2, uifield3]}',
          result['except']);
    });

    test('includeFallback unit testcase match key', () {
      query
        ..locale('en-us')
        ..includeFallback()
        ..find();
      expect(true, query.queryParameter.containsKey('include_fallback'));
      expect('true', query.queryParameter['include_fallback']);
    });

    test('includeFallback api test', () {
      query
        ..locale('en-gb')
        ..includeFallback();
      query.find().then((response) {
        expect(29, response['entries'].length);
      }).catchError((onError) {
        prints(onError.toString());
      });
    });

    test('include_embedded_objects unit test', () {
      query.includeEmbeddedItems();
      final bool isEmbeddedObj =
          query.queryParameter.containsKey('include_embedded_items[]');
      expect(true, isEmbeddedObj);
    });
  });
}
