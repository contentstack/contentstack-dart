import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/enums/include.dart';
import 'package:dotenv/dotenv.dart' show load, env;

void main() {
  load();
  final apiKey = env['apiKey'];
  final host = env['host'];
  final deliveryToken = env['deliveryToken'];
  final environment = env['environment'];
  var entryUid;
  final Stack stack = Stack(apiKey, deliveryToken, environment, host: host);
  final Query query = stack.contentType('faq').entry().query();
  final Entry entry = stack.contentType('faq').entry(entryUid: entryUid);

  group('Entry functinal testcases', () {
    test('test find entryUid', () async {
      await query.find().then((response) {
        final entries = response['entries'];
        for (final item in entries) {
          if (item['title'] == 'MEALS') {
            entryUid = item['uid'];
            continue;
          }
        }
      });
    });

    test('test if parameters are not empty', () {
      expect(true, entry.parameter.isNotEmpty);
    });

    test('test locale params using add params', () {
      entry.addParam('locale', 'en-us');
      expect(2, entry.parameter.length);
    });

    test('test the locale', () {
      entry
        ..locale('en-us')
        ..addParam('testKey', 'testValue123');
      expect(true, entry.parameter.containsKey('locale'));
    });

    test('test the addParams entry query', () {
      entry..addParam('locale', 'en-us')..addParam('testKey', 'testValue123');
      expect(true, entry.parameter.containsKey('testKey'));
    });

    test('test for version', () {
      entry.addParam('version', '3');
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
      entry.includeReference('category');
      final doesContain = entry.parameter.containsKey('include[]');
      expect(true, doesContain);
    });

    test('test includeReference includeType only', () {
      const List<String> fieldUid = ['title', 'orange', 'mango'];
      entry.includeReference('category',
          includeReferenceField: Include.only(fieldUidList: fieldUid));
      expect(true, entry.parameter.containsKey('include[]'));
      expect(true, entry.parameter.containsKey('only'));
    });

    test('test includeReference includeType except', () {
      const List<String> fieldUid = ['title', 'orange', 'mango'];
      entry.includeReference('category',
          includeReferenceField: Include.except(fieldUidList: fieldUid));
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
    test('test find entryUid', () async {
      await query.find().then((response) {
        final entries = response['entries'];
        for (final item in entries) {
          if (item['title'] == 'MEALS') {
            entryUid = item['uid'];
          }
        }
      });
    });

    test('find the entry response with locale', () async {
      entry.locale('en-us');
      await entry.fetch<EntryModel, Null>().then((response) {
        expect('en-us', response.locale);
      }).catchError((onError) {
        prints(onError.toString());
      });
    });

    test('test entry response with version', () async {
      entry
        ..locale('en-us')
        ..addParam('version', '1');
      await entry.fetch<EntryModel, Null>().then((response) {
        expect(1, response.version);
      });
    });

    test('find the only API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ['price', 'title'];
      entry.only(fieldUID);
      await entry.fetch<EntryModel, Null>().then((response) {
        expect('blt3ffedc5e2cef6d8c', response.uid);
      });
    });

    test('find the except API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ['title'];
      entry.except(fieldUID);
      await entry.fetch<EntryModel, Null>().then((response) {
        expect('MEALS', response.title);
      });
    });

    test('find the includeReference default API call', () async {
      entry.includeReference('categories');
      await entry.fetch().then((response) {
        expect(141, response['error_code']);
      }).catchError((onError) {
        expect('invalid url requested', onError.message);
      });
    });

    test('find the includeReference default with list objects', () async {
      const List<String> fieldUID = ['title', 'attendee', 'created_at'];
      entry.includeReference('categories',
          includeReferenceField: Include.none(fieldUidList: fieldUID));
      await entry.fetch().then((response) {
        expect(141, response['error_code']);
      }).catchError((onError) {
        expect('invalid url requested', onError.message);
      });
    });

    test('find the includeReference with only API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ['price', 'orange', 'mango'];
      entry.includeReference('categories',
          includeReferenceField: Include.only(fieldUidList: fieldUID));
      await entry.fetch().then((response) {
        expect(141, response['error_code']);
      });
    });

    test('find the includeReference except API call', () async {
      entry.locale('en-us');
      const List<String> fieldUID = ['price', 'orange', 'mango'];
      entry.includeReference('categories',
          includeReferenceField: Include.except(fieldUidList: fieldUID));
      await entry.fetch().then((response) {
        expect(
            "The requested object doesn't exist.", response['error_message']);
      }).catchError((error) {
        expect('Invalid reponse.', error.message);
      });
    });

    test('find the includeContentType except API call', () async {
      entry.includeContentType();
      await entry.fetch().then((response) {
        expect(true, response.containsKey('content_type'));
      });
    });

    test('find the includeReferenceContentTypeUID except API call', () async {
      entry.includeReferenceContentTypeUID();
      await entry.fetch().then((response) {
        final resp = response['entry']['faq_group'];
        expect(true, resp is List);
      });
    });

    test('test chaining few methods API call', () async {
      entry
        ..includeContentType()
        ..includeReferenceContentTypeUID();
      await entry.fetch().then((response) {
        expect(true, response.containsKey('content_type'));
      });
    });

    test('includeFallback unit testcase match key', () {
      entry.includeFallback();
      expect(true, entry.parameter.containsKey('include_fallback'));
      expect('true', entry.parameter['include_fallback']);
    });
  });
}
