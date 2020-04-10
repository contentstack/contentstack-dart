import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/base_query.dart';
//import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main(){

  const String apiKey = "bltc12b8d966127fa01";
  const String deliveryToken = "cse3ab6095485b70ab2713ed60";
  const String environment = "env1";
  contentstack.Query query;
  //final Logger logger = Logger('Query');

  group('testcases for functional queries', (){

    setUp(() {
      final contentstack.Stack stack =
          contentstack.Stack(apiKey, deliveryToken, environment);
      query = stack.contentType('product').entry().query();
    });


    test('test environment is availabe to the url', (){
      final params = query.getQueryUrl();
      expect(true, params.containsKey('environment'));
      final key = params['environment'];
      expect(environment, key);
    });


    test('test where function parameter contains key', () async {
      query.where(Where.equals, 'uid', 'blta3b58d6893d8935b');
      final conatins = query.getQueryUrl().containsKey('query');
      expect(true, conatins);
    });


    test('test notContainedIn function parameter contains key', () async {
      final List<String> arrayValue = ['Roti Maker','kids dress'];
      query.where(Where.excludes, 'title', arrayValue);
      // final response = await query.find();
      // logger.fine(response);
      final conatins = query.getQueryUrl()['query'];
      expect('{title: {\$nin: [Roti Maker, kids dress]}}', conatins);
    });


    test('test skip function parameter contains key', () async {
      query.skip(4);
      final conatins = query.getQueryUrl()['query'];
      expect('{skip: 4}', conatins);
    });


    test('test limit function parameter contains key', () async {
      query.limit(4);
      final conatins = query.getQueryUrl()['query'];
      expect('{limit: 4}', conatins);
    });


    test('test orderByAscending function parameter contains key', () async {
      query.orderByAscending('title');
      final conatins = query.getQueryUrl()['query'];
      expect('{asc: title}', conatins);
    });


    test('test orderByDecending function parameter contains key', () async {
      query.orderByDecending('title');
      final conatins = query.getQueryUrl()['query'];
      expect('{desc: title}', conatins);
    });


    test('test param function parameter contains key', () async {
      query.param('titleKey', 'titleValue');
      final conatins = query.getQueryUrl()['query'];
      expect('{titleKey: titleValue}', conatins);
    });


    test('test addParam function parameter contains key', () async {
      query.addParam({'key':'value', 'love': 'drawing'});
      final conatins = query.getQueryUrl()['query'];
      expect('{key: value, love: drawing}', conatins);
    });


    test('test query function parameter contains key', () async {
      query.query('queryKey', 'queryValue');
      final conatins = query.getQueryUrl()['queryKey'];
      expect('queryValue', conatins);
    });

    test('test add param function parameter contains key', () async {
      query.addQuery({'queryKey':'queryValue', 'queryLove': 'queryDrawing'});
      final conatins = query.getQueryUrl()['queryLove'];
      expect('queryDrawing', conatins);
    });


    test('test chaining the functions', () async {
      query..skip(4)..limit(3)..addQuery({'queryKey':'queryValue', 'queryLove': 'queryDrawing'});
      final conatins = query.getQueryUrl()['queryLove'];
      expect('queryDrawing', conatins);
    });


  });





  group('testcases for API queries', (){

    setUp(() {
      final contentstack.Stack stack =
          contentstack.Stack(apiKey, deliveryToken, environment);
      query = stack.contentType('product').entry().query();
    });

//    test('test without any parameter', () async {
//      final response = query.find();
//      await response.then((response) {
//        logger.fine('Data set success $response');
//        expect(27, response['entries'].length);
//      }).catchError((error) {
//        logger.fine('Data set Error!!! $error');
//        expect(422, error['error_code']);
//      });
//    });
//
//
//    test('test notContainedIn function parameter contains key', () async {
//      final List<String> arrayValue = ['Roti Maker','kids dress'];
//      query.where(Where.excludes, 'title', arrayValue);
//      final response = await query.find();
//      logger.fine(response);
//      expect('not completed yet', response['queries']);
//    });
//
//
//    test('test notContainedIn function parameter contains key', () async {
//      final List<String> arrayValue = ['Roti Maker','kids dress'];
//      query.where(Where.excludes, 'title', arrayValue);
//      final response = await query.find();
//      logger.fine(response);
//      expect('not completed yet', response['queries']);
//    });

  });

}