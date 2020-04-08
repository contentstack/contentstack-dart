import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/entry_queryable.dart';
import 'package:test/test.dart';

void main() {

  const String apiKey = "blt12c8ad610ff4ddc2";
  const String deliveryToken = "blt43359585f471685188b2e1ba";
  const String environment = "env1";
  const String entryUid = "blt7801c5d40cbbe979";

  group('Entry functinal testcases', () {
    
    Entry entry;

    setUp(() {
      final Stack stack =
          contentstack.Stack(apiKey, deliveryToken, environment);
      entry = stack.contentType('product').entry(entryUid: entryUid);
    });

    test('test if parameters are not empty', () {
      expect(true, entry.parameter.isNotEmpty);
    });

    test('test locale params using add params', () {
      entry.addParam('locale', 'en-us');
      expect(2, entry.parameter.length);
    });

    test('test the locale', () {
      entry.locale('en-us');
      entry.addParam('testKey', 'testValue123');
      expect(true, entry.parameter.containsKey('locale'));
    });

    test('test the addParams entry query', () {
      entry.addParam('locale', 'en-us');
      entry.addParam('testKey', 'testValue123');
      expect(true, entry.parameter.containsKey('testKey'));
    });

    test('test for version', () {
      entry.addParam('version', "3");
      expect(true, entry.parameter.containsKey('version'));
    });

    test('test only function', () {
      const fieldUid = ['book', 'grocessy', 'kitchen'];
      entry.only(fieldUid);
      expect(true, entry.parameter.containsKey('only[BASE][]'));
    });

    test('test except function', () {
      const List<String> fieldUid = ['book', 'grocessy', 'kitchen'];
      entry.except(fieldUid);
      expect(true, entry.parameter.containsKey('except[BASE][]'));
    });

    test('test includeReference includeType default', () {
      entry.includeReference(IncludeType.none, 'category');
      final doesContain = entry.parameter.containsKey('include[]');
      expect(true, doesContain);
    });

    test('test includeReference includeType only', () {
      const List<String> fieldUid = ['title', 'orange', 'mango'];
      entry.includeReference(IncludeType.only, 'category', fieldUid);
      expect(true, entry.parameter.containsKey('include[]'));
      expect(true, entry.parameter.containsKey('only'));
    });

    test('test includeReference includeType except', () {
      const List<String> fieldUid = ['title', 'orange', 'mango'];
      entry.includeReference(IncludeType.except, 'category', fieldUid);
      expect(true, entry.parameter.containsKey('include[]'));
      expect(true, entry.parameter.containsKey('except'));
    });

    test('test includeContentType', () {
      entry.includeContentType();
      expect(true, entry.parameter.containsKey('include_global_field_schema'));
    });

    test('test includeReferenceContentTypeUID', () {
      entry.includeReferenceContentTypeUID();
      expect(true,
          entry.parameter.containsKey('include_reference_content_type_uid'));
    });
  });

  /////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////

  group('Entry API testcases', () {
    
    Entry entry;
    Stack stack;

    setUp(() {
      stack = contentstack.Stack(apiKey, deliveryToken, environment);
      entry = stack.contentType('product').entry(entryUid: entryUid);
    });

    test('find the entry response with locale', () async {
      entry.locale('en-us');
      final response = await entry.fetch();
      if(response is Error){
        expect(422, response.statusCode);
      }
      expect('en-us', response['entry']['locale']);
    });

    test('test entry response with version', () async {
      entry.locale('en-us');
      entry.addParam('version', '4');
      final response = await entry.fetch();
      if(response is Error){
        expect(422, response.statusCode);
      }else{
        // review the virsion and 
        expect('en-us', response['entry']['locale']);
      }
    });


    test('find the only API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["price", "orange", "mango"];
      entry.only(fieldUID);
      final response = await entry.fetch();
      expect(786, response['entry']['price']);
    });


    test('find the except API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["price", "orange", "mango"];
      entry.except(fieldUID);
      final response = await entry.fetch();
      expect(786, response['entry']['price']);
    });


    test('find the includeReference with only API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["price", "orange", "mango"];
      entry.includeReference(IncludeType.only, 'category', fieldUID);
      final response = await entry.fetch();
      expect(422, response.statusCode);
    });


    test('find the includeReference default API call', () async {
      entry.locale('en-us');
      //const List<String> fieldUID = ["price", "orange", "mango"];
      entry.includeReference(IncludeType.none, 'category');
      final response = await entry.fetch();
      expect(45, response['entry']['discount']);
    });


    test('find the includeReference except API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["price", "orange", "mango"];
      entry.includeReference(IncludeType.except, 'category', fieldUID);
      final response = await entry.fetch();
      expect(422, response.statusCode);
    });

    test('find the includeContentType except API call', () async {
      entry.includeContentType();
      final response = await entry.fetch();
      expect(11, response['content_type']['schema'].length);
    });

    test('find the includeReferenceContentTypeUID except API call', () async {
      final Entry includeEntry = stack.contentType("user").entry(entryUid: 'blt3b0aaebf6f1c3762');
      includeEntry.includeReferenceContentTypeUID();
      final response = await includeEntry.fetch();
      final resp = response['entry']['cart'];
      expect('product', resp[0]['_content_type_uid']);
    });

    test('test chaining few methods API call', () async {
      final Entry includeEntry = stack.contentType("user").entry(entryUid: 'blt3b0aaebf6f1c3762');
      // ignore: avoid_single_cascade_in_expression_statements
      includeEntry..includeContentType()..includeReferenceContentTypeUID();
      final response = await includeEntry.fetch();
      final resp = response['entry']['cart'];
      expect('product', resp[0]['_content_type_uid']);
    });

  
  });
}
