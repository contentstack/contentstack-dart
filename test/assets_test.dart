import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/asset_query.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:test/test.dart';

void main() {
  load();
  final apiKey = env['apiKey'];
  final host = env['host'];
  final deliveryToken = env['deliveryToken'];
  final environment = env['environment'];
  final Stack stack = Stack(apiKey, deliveryToken, environment, host: host);

  group('testcases for asset the functional implementation', () {
    var assetUid = '';
    setUp(() async {
      final AssetQuery assetQuery = stack.assetQuery();
      await assetQuery.find().then((response) {
        prints('response $response');
        final List assets = response['assets'];
        for (final item in assets) {
          if (item['title'] == 'images_(2).jpg') {
            assetUid = item['uid'];
            prints(assetUid);
          }
        }
      });
    });

    test('test for asset uid', () async {
      final AssetQuery assetQuery = stack.assetQuery();
      await assetQuery.find().then((response) {
        prints('response $response');
        final List assets = response['assets'];
        for (final item in assets) {
          if (item['title'] == 'images_(2).jpg') {
            assetUid = item['uid'];
            prints(assetUid);
          }
        }
      }).catchError((error) {
        prints('error ${error.toString()}');
      });
    });
    test('testcase asset title', () async {
      final asset = stack.asset(assetUid)..environment('development');
      await asset.fetch<AssetModel, void>().then((response) {
        expect('images_(2).jpg', response.title);
      });
    });

    test('testcase asset environment', () async {
      final asset = stack.asset(assetUid)..environment('development');
      final params = asset.assetParameter;
      expect('{environment: development}', params.toString());
    });

    test('testcase asset environment', () async {
      final asset = stack.asset(assetUid)..includeFallback();
      expect(asset.assetParameter.containsKey('include_fallback'), true);
    });

    test('testcase asset fetch version', () async {
      final asset = stack.asset(assetUid)..version(4);
      await asset.fetch().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset fetch dimension of the asset', () async {
      final asset = stack.asset(assetUid);
      await asset.fetch().then((response) {
        expect(assetUid, response['asset']['uid']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset set to model', () async {
      try {
        final asset = stack.asset(assetUid)..includeDimension();
        await asset.fetch().then((response) {
          final model = contentstack.AssetModel.fromJson(response['asset']);
          expect('{height: 171, width: 294}', model.dimension.toString());
        });
      } catch (e) {
        expect(e.toString(), equals('Provide asset uid to fetch single entry'));
      }
    });

    test('include_fallback unit test', () {
      final asset = stack.asset(assetUid)..includeFallback();
      expect(asset.assetParameter.containsKey('include_fallback'), true);
    });
  });

  group('testcases for asset query', () {
    test('test asset environment', () async {
      final asset = stack.assetQuery()..environment('development');
      await asset.find().then((response) {
        expect('images_(2).jpg', response['assets'][7]['filename']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset fetch version', () async {
      final asset = stack.assetQuery()..version(4);
      await asset.find().then((response) {
        expect(0, response['assets'].length);
      });
    });

    test('testcase asset fetch dimension of the asset', () async {
      final asset = stack.assetQuery()..includeDimension();
      await asset.find().then((response) {
        expect(response['assets'][2]['dimension'], isNotNull);
      });
    });

    test('testcase asset query query on asset', () async {
      final asset = stack.assetQuery()
        ..includeCount()
        ..relativeUrls();
      await asset.find<List<AssetModel>, AssetModel>().then((response) {
        expect(response[7].url.contains('.jpg'), true);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset find chaining the functions', () async {
      final asset = stack.assetQuery()
        ..version(4)
        ..relativeUrls()
        ..includeDimension();
      await asset.find().then((response) {
        expect(0, response['assets'].length);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('includeFallback unit testcase match key', () {
      final asset = stack.assetQuery()..includeFallback();
      expect(true, asset.queryParameter.containsKey('include_fallback'));
      expect('true', asset.queryParameter['include_fallback']);
    });

    test('testcase asset include fallback', () async {
      final asset = stack.assetQuery()..includeFallback();
      await asset.find().then((response) {
        expect(8, response['assets'].length);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset include fallback with locale', () async {
      final asset = stack.assetQuery()
        ..includeFallback()
        ..param('locale', 'en-us');
      await asset.find().then((response) {
        expect(8, response['assets'].length);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('include_branching check if include_branch key exists', () {
      final asset = stack.assetQuery()..includeBranch();
      expect(asset.queryParameter.containsKey('include_branch'), true);
    });

    test('include_branching unit testcase check true enabled', () {
      final asset = stack.assetQuery()..includeBranch();
      expect(asset.queryParameter['include_branch'], 'true');
    });
  });
}
