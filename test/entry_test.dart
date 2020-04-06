import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/entry_queryable.dart';
import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

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

    test('test includeReference includeType none', () {
      entry.includeReference(IncludeType.none, 'category');
      expect(true, entry.parameter.containsKey('include[]'));
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

    setUp(() {
      final Stack stack =
          contentstack.Stack(apiKey, deliveryToken, environment);
      entry = stack.contentType('product').entry(entryUid: entryUid);
    });

    test('find the entry response with version', () async {
      entry.addParam('version', "3");
      expect(true, entry.parameter.containsKey('version'));
    });
  });
}
