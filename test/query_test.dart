// ignore_for_file: lines_longer_than_80_chars

import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/enums/include.dart';
import 'package:contentstack/src/enums/include_type.dart';
import 'package:contentstack/src/enums/operations.dart';
import 'package:contentstack/src/enums/operations_type.dart';
import 'package:contentstack/src/enums/operator.dart';
import 'package:contentstack/src/enums/operator_type.dart';
import 'package:contentstack/src/enums/reference.dart';
import 'package:contentstack/src/enums/reference_type.dart';
import 'package:dotenv/dotenv.dart';
import 'package:test/test.dart';

void main() {
  group('testcases for functional base queries', () {
    late Query query;
    String? apiKey = '', environment = '', deliveryToken = '', host = '';
    late Stack stack;

    setUpAll(() async {
      final env = DotEnv(includePlatformEnvironment: true)..load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey!, deliveryToken!, environment!, host: host);
    });

    setUp(() async {
      query = stack.contentType('source').entry().query();
    });

    test('test environment is available to the url', () {
      final params = query.getQueryUrl();
      expect(true, params.containsKey('environment'));
      final envKey = params['environment'];
      expect(environment, envKey);
    });

    test('test where equals Operation', () async {
      query.where('uid', QueryOperation(QueryOperationType.Equals, 'theFakeUid'));
      final contains = query.getQueryUrl().toString();
      expect(
          '{environment: development, query: {"uid":"theFakeUid"}}', contains);
    });

    test('test where notEquals operation', () async {
      query.where('number', QueryOperation(QueryOperationType.NotEquals, '40'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"number\":{\"\$ne\":\"40\"}}', contains);
    });

    test('test where includes Operation', () async {
      const includeList = ['abc', 'def', 'sample'];
      query.where('uid', QueryOperation(QueryOperationType.Includes, includeList));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$in\":[\"abc\",\"def\",\"sample\"]}}', contains);
    });

    test('test where excludes Operation', () async {
      const includeList = ['abc', 'def', 'sample'];
      query.where('uid', QueryOperation(QueryOperationType.Excludes, includeList));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$nin\":[\"abc\",\"def\",\"sample\"]}}', contains);
    });

    test('test where exists Operation', () async {
      query.where('uid', QueryOperation(QueryOperationType.Exists, true));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$exists\":true}}', contains);
    });

    test('test where isGreaterThan Operation', () async {
      query.where('uid', QueryOperation(QueryOperationType.IsGreaterThan ,'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$gt\":\"price\"}}', contains);
    });

    test('test where isGreaterThanOrEqual Operation', () async {
      query.where('uid', QueryOperation(QueryOperationType.IsGreaterThanOrEqual ,'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$gte\":\"price\"}}', contains);
    });

    test('test where isLessThan Operation', () async {
      query.where('uid', QueryOperation(QueryOperationType.IsLessThan, 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$lt\":\"price\"}}', contains);
    });

    test('test where isLessThanOrEqual Operation', () async {
      query.where('uid', QueryOperation(QueryOperationType.IsLessThanOrEqual, 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$lte\":\"price\"}}', contains);
    });

    test('test where matches Operation', () async {
      query.where('uid', QueryOperation(QueryOperationType.Matches, 'price'));
      final contains = query.getQueryUrl()['query'];
      expect('{\"uid\":{\"\$regex\":\"price\"}}', contains);
    });

    test('test limit function parameter contains key', () async {
      query.limit(4);
      final contains = query.getQueryUrl()['limit'];
      expect('4', contains);
    });

    test('functional test query orderByAscending', () async {
      query.orderByAscending('number');
      final contains = query.getQueryUrl()['asc'];
      expect('number', contains);
    });

    test('test orderByDescending function parameter contains key', () async {
      query.orderByDescending('number');
      final contains = query.getQueryUrl()['desc'];
      expect('number', contains);
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
    late Query query;
    String? apiKey = '', environment = '', deliveryToken = '', host = '';
    late Stack stack;

    setUpAll(() async {
      final env = DotEnv(includePlatformEnvironment: true)..load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey!, deliveryToken!, environment!, host: host);
    });
    setUp(() async {
      query = stack.contentType('source').entry().query();
    });

    test('testcase setHeader for the query class', () async {
      // query.setHeader('key', 'value');
      await query.find().then((response) {
        expect(response['entries'].length, 8);
      });
    });
  });

  group('testcases for API queries', () {
    late Query query;
    String? apiKey = '', environment = '', deliveryToken = '', host = '';
    late Stack stack;

    setUpAll(() async {
      final env = DotEnv(includePlatformEnvironment: true)..load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey!, deliveryToken!, environment!, host: host);
    });

    setUp(() async {
      query = stack.contentType('source').entry().query();
    });

    test('test length of the entry of respected contentType', () async {
      final response = query.find();
      await response.then((response) {
        expect(response['entries'].length, 8);
      });
    });

    test('test where equals API Operation', () async {
      query.where('number', QueryOperation(QueryOperationType.Equals, 4));
      await query.find().then((response) {
        expect(response != null, true);
      });
    });

    test('test notContainedIn in Query', () async {
      await query.find().then((response) async {
        final List<String> arrayValue = ['source1', 'source4', 'source2'];
        query.where('title', QueryOperation(QueryOperationType.Excludes, arrayValue));
        await query.find().then((response) {
          final queryMap = response['entries'].length;
          expect(queryMap != null, true);
        });
      });
    });

    test('test notContainedIn function parameter contains key', () async {
      query.where('number', QueryOperation(QueryOperationType.NotEquals, 4));
      await query.find().then((response) {
        expect(response!.length, 1);
      });
    });

    test('test notEquals in Query', () async {
      query.where('number', QueryOperation(QueryOperationType.NotEquals, 20));
      await query.find().then((response) {
        expect(response['entries'].length, 8);
      });
    });

    test('test includes in Query', () async {
      final includeList = ['source1', 'source4', 'source2'];
      query.where('title', QueryOperation(QueryOperationType.Includes, includeList));
      await query.find().then((response) {
        expect(response['entries'] != null, true);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test excludes in Query', () async {
      final includeList = ['source1', 'source4', 'source2'];
      query.where('title', QueryOperation(QueryOperationType.Excludes, includeList));
      await query.find().then((response) {
        expect(response['entries'].length, 5);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isLessThan in Query', () async {
      query.where('number', QueryOperation(QueryOperationType.IsLessThan, 50));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        // ignore: prefer_final_in_for_each
        for (var entry in listOfEntry) {
          expect(true, entry['number'] < 50);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isLessThanOrEqual in Query', () async {
      query.where('number', QueryOperation(QueryOperationType.IsLessThanOrEqual, 50));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        // ignore: prefer_final_in_for_each
        for (var entry in listOfEntry) {
          expect(true, entry['number'] < 50);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isGreaterThan in Query', () async {
      query.where('number', QueryOperation(QueryOperationType.IsGreaterThan, 50));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        for (final entry in listOfEntry) {
          expect(true, entry['number'] > 50);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test isGreaterThanOrEqual in Query', () async {
      query.where('number', QueryOperation(QueryOperationType.IsGreaterThanOrEqual, 70));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        for (final entry in listOfEntry) {
          expect(true, entry['number'] >= 70);
        }
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test exists in Query', () async {
      query.where('number', QueryOperation(QueryOperationType.Exists, true));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        expect(listOfEntry.length, 8);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test matches in Query', () async {
      query.where('title', QueryOperation(QueryOperationType.Matches, 'Room'));
      await query.find().then((response) {
        final List listOfEntry = response['entries'];
        expect(0, listOfEntry.length);
      }).catchError((onError) {
        expect('Error Occurred', onError.message);
      });
    });

    test('test whereReference in Query', () async {
      final queryBase = stack.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase.where('title', QueryOperation(QueryOperationType.Equals, 'Room 14'));
      query.whereReference('brand', QueryReference(QueryReferenceType.Include, queryBase));
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
      queryBase.where('title', QueryOperation(QueryOperationType.Equals, 'Room 14'));
      query.whereReference(
          'fieldUid', QueryReference(QueryReferenceType.NotInclude, queryBase));
      await query.find().then((response) {
        expect(
            'Failed to fetch entries. Please try again with valid parameters.',
            response['error_message']);
      });
    });

    test('test operator And in Query', () async {
      final queryBase1 = stack.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase1.where('title', QueryOperation(QueryOperationType.Equals, 'Room 13'));

      final stackInstance2 = stack;
      final queryBase2 = stackInstance2.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase2.where('number', QueryOperation(QueryOperationType.Equals, 20));

      final List<Query> listOfQuery = [queryBase1, queryBase2];
      query.operator(QueryOperator(QueryOperatorType.And, listOfQuery));
      await query.find().then((response) {
        final completeUrl = query.getQueryUrl()['query'];
        //print(response.toString());
        expect('{\"\$and\":[{\"title\":\"Room 13\"},{\"number\":20}]}',
            completeUrl);
      }).catchError((onError) {
        expect("Failed host lookup: 'cdn.contentstack.io'", onError.message);
      });
    });

    test('test operator OR in Query', () async {
      final stackInstance1 = stack;
      final queryBase1 = stackInstance1.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase1.where('title', QueryOperation(QueryOperationType.Equals, 'Room 13'));

      final stackInstance2 = stack;
      final queryBase2 = stackInstance2.contentType('room').entry().query();
      // ignore: cascade_invocations
      queryBase2.where('number', QueryOperation(QueryOperationType.Equals, 20));

      final List<Query> listOfQuery = [queryBase1, queryBase2];
      query.operator(QueryOperator(QueryOperatorType.Or, listOfQuery));
      await query.find().then((response) {
        final completeUrl = query.getQueryUrl()['query'];
        expect('{\"\$or\":[{\"title\":\"Room 13\"},{\"number\":20}]}',
            completeUrl);
      }).catchError((onError) {
        expect("Failed host lookup: 'cdn.contentstack.io'", onError.message);
      });
    });

    test('test query skip ', () async {
      await query.find().then((onResponse) async {
        query.skip(4);
        await query.find().then((response) {
          expect(response['entries'].length, 4);
        });
      });
    });

    test('test query orderByAscending', () async {
      query.orderByAscending('number');
      final contains = query.getQueryUrl()['asc'];
      await query.find().then((response) {
        final ascList = response['entries'];
        int? oldnumber;
        int counter = 0;
        for (final item in ascList) {
          if (counter != 0) {
            final newValue = item['number'];
            oldnumber = item['number'];
            if (oldnumber! <= newValue) {
              expect(true, true);
            } else {
              expect(true, false);
            }
          }
          counter++;
        }
      });
      expect('number', contains);
    });
  });

  // these tests are working irrespective of the stack used
  // they need to be checked and updated
  group('testcases for entry queryable', () {
    late Query query;
    String? apiKey = '', environment = '', deliveryToken = '', host = '';
    late Stack stack;

    setUpAll(() async {
      final env = DotEnv(includePlatformEnvironment: true)..load();
      apiKey = env['apiKey'];
      host = env['host'];
      deliveryToken = env['deliveryToken'];
      environment = env['environment'];
      stack = Stack(apiKey!, deliveryToken!, environment!, host: host);
    });

    setUp(() async {
      query = stack.contentType('source').entry().query();
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
      const uiFieldList = ['demo1', 'demo2', 'demo3'];
      query
        ..locale('en-us')
        ..except(['field1', 'field2', 'field3', 'field4'])
        ..includeReference('referenceFieldUid',
            includeReferenceField:
                IncludeClass(IncludeType.None, uiFieldList))
        ..includeContentType()
        ..includeReferenceContentTypeUID()
        ..addParam('key', 'value');
      final result = query.getQueryUrl();
      expect('en-us', result['locale']);
      expect('[referenceFieldUid, demo1, demo2, demo3]', result['include[]']);
      expect('[field1, field2, field3, field4]', result['except[BASE][]']);
      expect('true', result['include_content_type']);
      expect('true', result['include_global_field_schema']);
      expect('true', result['include_reference_content_type_uid']);
      expect('value', result['key']);
    });

    test('query testcase reference only entry queryable', () {
      const uiFieldList = ['demo1', 'demo2', 'demo3'];
      query
        ..locale('en-us')
        ..includeReference('referenceFieldUid',
            includeReferenceField:
                IncludeClass(IncludeType.Only, uiFieldList));
      final result = query.getQueryUrl();
      expect('referenceFieldUid', result['include[]']);
      expect('{referenceFieldUid: [demo1, demo2, demo3]}', result['only']);
    });

    test('query testcase reference except entry queryable', () {
      const uiFieldList = ['demo1', 'demo2', 'demo3'];
      query
        ..locale('en-us')
        ..includeReference('referenceFieldUid',
            includeReferenceField:
                IncludeClass(IncludeType.Except, uiFieldList));
      final result = query.getQueryUrl();
      expect('referenceFieldUid', result['include[]']);
      expect('{referenceFieldUid: [demo1, demo2, demo3]}', result['except']);
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

    test('include_branching check if include_branch key exists', () {
      query.includeBranch();
      expect(query.queryParameter.containsKey('include_branch'), true);
    });

    test('include_branching unit testcase check true enabled', () {
      query.includeBranch();
      expect(query.queryParameter['include_branch'], 'true');
    });
  });
}
