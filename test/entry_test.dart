import 'dart:math';

import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/entry_queryable.dart';
import 'package:test/test.dart';
import 'credentials.dart';

void main() {

  group('Entry functinal testcases', () {
    
    Entry entry;

    setUp(() {
      final Stack stack = Credential.stack();
      entry = stack.contentType('faq').entry(entryUid: Credential.entryUid);
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
      stack = Credential.stack();
      entry = stack.contentType('faq').entry(entryUid: Credential.entryUid);
    });

    test('find the entry response with locale', () async {
      entry.locale('en-us');
      await entry.fetch().then((response){
        expect('en-us', response['entry']['locale']);
      }).catchError((onError){
        prints(onError.toString());
      });

    });


    test('test entry response with version', () async {
      entry.locale('en-us');
      entry.addParam('version', '1');
      await entry.fetch().then((response){
        if(response is Error){
          expect(141, response.errorCode);
        }else{
          expect(1, response['entry']['_version']);
        }
      }).catchError((onError){
        expect('', onError.toString());
      });

    });


    test('find the only API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["price", "orange", "mango"];
      entry.only(fieldUID);
      await entry.fetch().then((response){
        expect('MEALS', response['entry']['title']);
      }).catchError((onError){
        expect('0923', '23i');
      });

    });


    test('find the except API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["title"];
      entry.except(fieldUID);
      await entry.fetch().then((response){
        if(response is Map){
          final entryModel = EntryModel.fromJson(response['entry']);
          expect(true, entryModel is EntryModel);
          expect('MEALS', entryModel.title);
        }
      });


    });


    test('find the includeReference with only API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["price", "orange", "mango"];
      entry.includeReference(IncludeType.only, 'category', fieldUID);
      final response = await entry.fetch();
      if(response is Error){
        expect(141, response.errorCode);
        final isJson = Error().toJson();
        expect(true, isJson is Map);
      }
    });


    test('find the includeReference default API call', () async {
      entry.locale('en-us');
      entry.includeReference(IncludeType.none, 'category');
      await entry.fetch().then((response){
        expect('/meals', response['entry']['url']);
      }).catchError((onError){
        expect('invalid url requested', onError.message);
      });
      //expect(45, response['entry']['discount']);
    });


    test('find the includeReference except API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ["price", "orange", "mango"];
      entry.includeReference(IncludeType.except, 'category', fieldUID);
      final response = await entry.fetch();
      if(response is Error){
        expect(141, response.errorCode);
      }
    });

    test('find the includeContentType except API call', () async {
      entry.includeContentType();
      await entry.fetch().then((response){
        expect(true, response['content_type']['schema'] is List);
      }).catchError((onError){
        expect(null, onError.toString());
      });

    });

    test('find the includeReferenceContentTypeUID except API call', () async {
      entry.includeReferenceContentTypeUID();
      await entry.fetch().then((response){
        final resp = response['entry']['faq_group'];
        expect(true, resp is List);
      });
    });

    test('test chaining few methods API call', () async {
      entry..includeContentType()..includeReferenceContentTypeUID();
      await entry.fetch().then((response){
        expect(true, response.containsKey('content_type'));
      });

    });

  
  });
}
