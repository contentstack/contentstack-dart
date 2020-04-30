import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/enums/operations.dart';
import 'package:contentstack/src/enums/operator.dart';
import 'package:contentstack/src/enums/reference.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'credentials.dart';

void main() {
  final Logger logger = Logger('Query');
  group('testcases for functional base queries', () {
    contentstack.Query query;
    setUp(() {
      final contentstack.Stack stack = Credential.stack();
      query = stack.contentType('room').entry().query();
    });

    test('test environment is availabe to the url', () {
      final params = query.getQueryUrl();
      expect(true, params.containsKey('environment'));
      final key = params['environment'];
      logger.fine(key);
      expect(Credential.environment, key);
    });

    test('test where equals Operation', () async {
      query.where('uid', QueryOperation.equals(value: 'blt8493859348'));
      final contains = query.getQueryUrl().toString();
      expect('{environment: development, query: {"uid":"blt8493859348"}}', contains);
    });

    test('test where notEquals operation', () async {
      query.where('attendee', QueryOperation.notEquals(value: '40'));
      final contains = query.getQueryUrl()['query'];
      expect("{\"attendee\":{\"\$ne\":\"40\"}}", contains);
    });

    test('test where includes Operation', () async {
      const includeList = ['abc', 'def', 'uiweu'];
      query.where('uid', QueryOperation.includes(value: includeList));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$in\":[\"abc\",\"def\",\"uiweu\"]}}", contains);
    });

    test('test where excludes Operation', () async {
      const includeList = ['abc', 'def', 'uiweu'];
      query.where('uid', QueryOperation.excludes(value: includeList));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$nin\":[\"abc\",\"def\",\"uiweu\"]}}", contains);
    });

    test('test where exists Operation', () async {
      query.where('uid', QueryOperation.exists(value: true));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$exists\":true}}", contains);
    });

    test('test where isGreaterThan Operation', () async {
      query.where('uid', QueryOperation.isGreaterThan(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$gt\":\"price\"}}", contains);
    });

    test('test where isGreaterThanOrEqual Operation', () async {
      query.where('uid', QueryOperation.isGreaterThanOrEqual(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$gte\":\"price\"}}", contains);
    });

    test('test where isLessThan Operation', () async {
      query.where('uid', QueryOperation.isLessThan(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$lt\":\"price\"}}", contains);
    });

    test('test where isLessThanOrEqual Operation', () async {
      query.where('uid', QueryOperation.isLessThanOrEqual(value: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$lte\":\"price\"}}", contains);
    });

    test('test where matches Operation', () async {
      query.where('uid', QueryOperation.matches(regex: 'price'));
      final contains = query.getQueryUrl()['query'];
      expect("{\"uid\":{\"\$regex\":\"price\"}}", contains);
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

    test('test orderByDecending function parameter contains key', () async {
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
      query..addParams({'key1': 'value1', 'key2': 'value2', 'key3': 'value3'})
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
      expect('{\"queryKey\":\"queryValue\",\"queryLove\":\"queryDrawing\"}', contains);
    });

    test('functional cascade of skip and limit', () async {
      query
        ..skip(4)
        ..limit(3);
      final contains = query.getQueryUrl();
      expect(
          '{environment: development, skip: 4, limit: 3}', contains.toString());
    });
  });

  group('functional testcases for the Query class', () {
    contentstack.Query query;
    setUp(() {
      final contentstack.Stack stack = Credential.stack();
      query = stack.contentType('faq').entry().query();
    });

    test('testcase setHeader for the query class', () async {
      query.setHeader('key', 'value');
      await query.find().then((response) {
        //print(response.toString());
        logger.fine(response);
      }).catchError((onError) {
        //print(onError.toString());
        logger.fine(onError);
      });
    });
  });




  group('testcases for API queries', () {
    // Note: Below testcase are not correct (Re-write required)
    contentstack.Query query;
    contentstack.Stack stack;

    setUp(() {
      stack = Credential.stack();
      query = stack.contentType('room').entry().query();
    });

    test('test length of the entry of respected contentType', () async {
      final response = query.find();
      await response.then((response) {
        logger.fine('query response: $response');
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
      // first get all the entries available,
      // find the length
      await query.find().then((response) async {
        // queryLength is total length of entry
        final queryLength = response['entries'].length;
        // arrayValue that should be removed from the entries
        // find the length
        final List<String> arrayValue = ["Room 13", "Room 14", "Room 17"];
        query.where('title', QueryOperation.excludes(value: arrayValue));
        await query.find().then((response) {
          final queryMap = response['entries'].length;
          // check the length of the query now.
          final ninQueryLength = queryLength - arrayValue.length;
          expect(ninQueryLength, queryMap);
        });
      });
    });



    test('test notContainedIn function parameter contains key', () async {
      query.where('attendee', QueryOperation.notEquals(value: 20));
      await query.find().then((response){
        logger.fine(response);
        expect(28, response['entries'].length);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });

    test('test notEquals in Query', () async {
      query.where('attendee', QueryOperation.notEquals(value: 20));
      await query.find().then((response){
        logger.fine(response);
        expect(28, response['entries'].length);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });

    test('test includes in Query', () async {
      final includeList = ["Room 13", "Room 18", "Room 19"];
      query.where('title', QueryOperation.includes(value: includeList));
      await query.find().then((response){
        //logger.fine(response);
        expect(includeList.length, response['entries'].length);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test excludes in Query', () async {
      final includeList = ["Room 13", "Room 18", "Room 19"];
      query.where('title', QueryOperation.excludes(value: includeList));
      await query.find().then((response){
        //logger.fine(response);
        expect(26, response['entries'].length);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });

    test('test isLessThan in Query', () async {
      query.where('attendee', QueryOperation.isLessThan(value: 50));
      await query.find().then((response){
        //logger.fine(response);
        final List listOfEntry = response['entries'];
        // ignore: prefer_final_in_for_each
        for (var entry in listOfEntry){
          expect(true, entry['attendee']<50);
        }
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test isLessThanOrEqual in Query', () async {
      query.where('attendee', QueryOperation.isLessThanOrEqual(value: 50));
      await query.find().then((response){
        //logger.fine(response);
        final List listOfEntry = response['entries'];
        // ignore: prefer_final_in_for_each
        for (var entry in listOfEntry){
          expect(true, entry['attendee']<50);
        }
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test isGreaterThan in Query', () async {
      query.where('attendee', QueryOperation.isGreaterThan(value: 50));
      await query.find().then((response){
        //logger.fine(response);
        final List listOfEntry = response['entries'];
        for (final entry in listOfEntry){
          expect(true, entry['attendee']>50);
        }
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test isGreaterThanOrEqual in Query', () async {
      query.where('attendee', QueryOperation.isGreaterThanOrEqual(value: 70));
      await query.find().then((response){
        //logger.fine(response);
        final List listOfEntry = response['entries'];
        for (final entry in listOfEntry){
          //print(entry['attendee']);
          expect(true, entry['attendee']>=70);
        }
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test exists in Query', () async {
      query.where('attendee', QueryOperation.exists(value: true));
      await query.find().then((response){
        //logger.fine(response);
        final List listOfEntry = response['entries'];
        // ignore: avoid_print
        print(listOfEntry.length);
        expect(29, listOfEntry.length);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test matches in Query', () async {
      query.where('title', QueryOperation.matches(regex: 'Room'));
      await query.find().then((response){
        //logger.fine(response);
        final List listOfEntry = response['entries'];
        //print(listOfEntry.length);
        expect(29, listOfEntry.length);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test whereReference in Query', () async {
      final stackInstance = Credential.stack();
      final queryBase = stackInstance.contentType('room').entry().query();
      queryBase.where('title', QueryOperation.equals(value: 'Room 14'));
      query.whereReference('brand', QueryReference.include(query: queryBase));
      await query.find().then((response){
        final queryUrl = query.getQueryUrl()['query'];
        expect("{\"brand\":{\"\$in_query\":{\"title\":\"Room 14\"}}}", queryUrl);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test whereReference NinQuery', () async {
      final stackInstance = Credential.stack();
      final queryBase = stackInstance.contentType('room').entry().query();
      queryBase.where('title', QueryOperation.equals(value: 'Room 14'));
      query.whereReference('fieldUid', QueryReference.notInclude(query: queryBase));
      await query.find().then((response){
        final queryUrl = query.getQueryUrl()['query'];
        expect("{\"fieldUid\":{\"\$nin_query\":{\"title\":\"Room 14\"}}}", queryUrl);
      }).catchError((onError){
        expect('Error Occured', onError.message);
      });
    });


    test('test operator And in Query', () async {
      final stackInstance1 = Credential.stack();
      final queryBase1 = stackInstance1.contentType('room').entry().query();
      queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));

      final stackInstance2 = Credential.stack();
      final queryBase2 = stackInstance2.contentType('room').entry().query();
      queryBase2.where('attendee', QueryOperation.equals(value: 20));

      final List<contentstack.Query> listOfQuery = [queryBase1, queryBase2];
      query.operator(QueryOperator.and(queryObjects: listOfQuery));
      await query.find().then((response){
        logger.fine(response);
        final completeUrl = query.getQueryUrl()['query'];
        //print(response.toString());
        expect("{\"\$and\":[{\"title\":\"Room 13\"},{\"attendee\":20}]}", completeUrl);
      }).catchError((onError){
        expect("Failed host lookup: 'cdn.contentstack.io'", onError.message);
      });
    });


    test('test operator OR in Query', () async {
      final stackInstance1 = Credential.stack();
      final queryBase1 = stackInstance1.contentType('room').entry().query();
      queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));

      final stackInstance2 = Credential.stack();
      final queryBase2 = stackInstance2.contentType('room').entry().query();
      queryBase2.where('attendee', QueryOperation.equals(value: 20));

      final List<contentstack.Query> listOfQuery = [queryBase1, queryBase2];
      query.operator(QueryOperator.or(queryObjects: listOfQuery));
      await query.find().then((response){
        logger.fine(response);
        final completeUrl = query.getQueryUrl()['query'];
        //(response.toString());
        expect("{\"\$or\":[{\"title\":\"Room 13\"},{\"attendee\":20}]}", completeUrl);
      }).catchError((onError){
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
          // ignore: avoid_print
          print(item['attendee']);
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
}
