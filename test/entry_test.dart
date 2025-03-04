// ignore_for_file: lines_longer_than_80_chars

import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/enums/include.dart';
import 'package:contentstack/src/enums/include_type.dart';
import 'package:dotenv/dotenv.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  final logger = Logger(printer: PrettyPrinter());

  final env = DotEnv(includePlatformEnvironment: true)..load();
  final apiKey = env['apiKey']!;
  final host = env['host'];
  final deliveryToken = env['deliveryToken']!;
  final environment = env['environment']!;
  final contentType = env['contentType']!;
  String? entryUid = '';

  logger.i('credentials loaded..');

  final Stack stack = Stack(apiKey, deliveryToken, environment, host: host);
  final Query query = stack.contentType(contentType).entry().query();
  final Entry entry = stack.contentType(contentType).entry(entryUid: entryUid);

  group('Entry functional testcases', () {
    setUp(() async {
      await query.find().then((response) {
        final entries = response['entries'];
       if(entries != null) {
           for (final item in entries) {
             if (item['title'] == 'source1') {
               entryUid = item['uid'];
               continue;
             }
           }
         } else {
           logger.i('No entries found');
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
      entry
        ..addParam('locale', 'en-us')
        ..addParam('testKey', 'testValue123');
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
          includeReferenceField: IncludeClass(IncludeType.Only,fieldUid));
      expect(true, entry.parameter.containsKey('include[]'));
      expect(true, entry.parameter.containsKey('only'));
    });

    test('test includeReference includeType except', () {
      const List<String> fieldUid = ['title', 'orange', 'mango'];
      entry.includeReference('category',
          includeReferenceField: IncludeClass(IncludeType.Except, fieldUid));
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
    String? _uid = '';
    late Entry entryInstance;

    // If this is called within a test group, callback
    // will run before all tests in that group.
    setUpAll(() async {
      await query.find().then((response) {
        final entries = response['entries'];
        for (final item in entries) {
          if (item['title'] == 'source1') {
            _uid = item['uid'];
            entryInstance = stack.contentType(contentType).entry(entryUid: _uid);
            continue;
          }
        }
      });
    });

    //This function will be called before each test is run.
    // callback may be asynchronous; if so, it must return a
    setUp(() async {
      entryInstance = stack.contentType(contentType).entry(entryUid: _uid);
    });

    // test('find the entry response with locale', () async {
    //   entry.locale('en-us');
    //   await entry.fetch<EntryModel, Null>().then((response) {
    //     expect('en-us', response.locale);
    //   }).catchError((onError) {
    //     prints(onError.toString());
    //   });
    // });

    test('test entry response with version', () async {
      entryInstance
        ..locale('en-us')
        ..addParam('version', '5');
      await entryInstance.fetch<EntryModel, Null>().then((response) {
        expect(response!.version,5);
      });
    });

    test('find the only API call', () async {
      entryInstance.locale('en-us');
      const List<String> fieldUID = ['price', 'title'];
      entryInstance.only(fieldUID);
      await entryInstance.fetch<EntryModel, Null>().then((response) {
        expect(response!.uid != null, true);
      });
    });

    test('find the except API call', () async {
      entryInstance.locale('en-us');
      const List<String> fieldUID = ['title'];
      entryInstance.except(fieldUID);
      // await entryInstance.fetch().then((response) {
      //   // don't know what it is expecting
      //   expect('MEALS', response.title);
      // }).catchError((err) {
      //   expect('Error', err.title);
      // });
      await entryInstance.fetch<EntryModel, Null>().then((response) {
        expect(response!.title, 'source1' );
      });
    });

    test('find the includeReference default API call', () async {
      entryInstance.includeReference('reference');
      await entryInstance.fetch().then((response) {
        expect(response['error_code'],141);
      }).catchError((onError) {
        expect('invalid url requested', onError.message);
      });
    },skip : 'Skipping this test temporarily');

    test('find the includeReference default with list objects', () async {
      const List<String> fieldUID = ['title', 'attendee', 'created_at'];
      entryInstance.includeReference('reference',
          includeReferenceField: IncludeClass(IncludeType.None, fieldUID));
      await entryInstance.fetch().then((response) {
        expect( response['error_code'],141);
      }).catchError((onError) {
        expect('invalid url requested', onError.message);
      });
    },skip : 'Skipping this test temporarily');

    test('find the includeReference with only API call', () async {
      entryInstance.locale('en-us');
      const List<String> fieldUID = ['price', 'orange', 'mango'];
      entryInstance.includeReference('reference',
          includeReferenceField: IncludeClass(IncludeType.Only, fieldUID));
      await entryInstance.fetch().then((response) {
        expect( response['error_code'],141);
      });
    },skip : 'Skipping this test temporarily');

    test('find the includeReference except API call', () async {
      entryInstance.locale('en-us');
      const List<String> fieldUID = ['price', 'orange', 'mango'];
      entryInstance.includeReference('reference',
          includeReferenceField: IncludeClass(IncludeType.Except, fieldUID));
      await entryInstance.fetch().then((response) {
        expect(response['error_message'],"The requested object doesn't exist.");
      }).catchError((error) {
        expect('Invalid reponse.', error.message);
      });
    },skip : 'Skipping this test temporarily');

    test('find the includeContentType except API call', () async {
      entryInstance.includeContentType();
      await entryInstance.fetch().then((response) {
        expect(true, response.containsKey('content_type'));
      });
    });

    test('find the includeReferenceContentTypeUID except API call', () async {
      entryInstance.includeReferenceContentTypeUID();
      await entryInstance.fetch().then((response) {
        final resp = response['entry']['reference'];
        expect(true, resp is List);
      });
    });

    test('test chaining few methods API call', () async {
      entryInstance
        ..includeContentType()
        ..includeReferenceContentTypeUID();
      await entryInstance.fetch().then((response) {
        expect(true, response.containsKey('content_type'));
      });
    });

    test('includeFallback unit testcase match key', () {
      entryInstance.includeFallback();
      expect(true, entryInstance.parameter.containsKey('include_fallback'));
      expect('true', entryInstance.parameter['include_fallback']);
    });

    test('include_embedded_objects unit testcase', () {
      entryInstance.includeEmbeddedItems();
      expect(true,
          entryInstance.parameter.containsKey('include_embedded_items[]'));
    });

    test('include_branching check if include_branch key exists', () {
      entryInstance.includeBranch();
      expect(entryInstance.parameter.containsKey('include_branch'), true);
    });

    test('include_branching unit testcase check true enabled', () {
      entryInstance.includeBranch();
      expect(entryInstance.parameter['include_branch'], 'true');
    });

    test('find the includeReference with multiple strings', () async {
      final Stack stack = Stack(apiKey, deliveryToken, environment, host: host);
      final Entry entry = stack.contentType(contentType).entry(entryUid: _uid);
      const List<String> fieldUID = ['price', 'orange', 'mango'];
      entry.includeReference(fieldUID);
      await entry.fetch().then((response) {
        expect(response != null, true);
      });
    });
  });
}
