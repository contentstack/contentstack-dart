import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'package:contentstack/src/models/assetmodel.dart';
import 'credentials.dart';

void main() {
  group('testcases for asset the functional implementation', () {
    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });

    test('testcase asset title', () async {
      final asset = stack.asset(Credential.assetUid)
        ..environment('development');
      await asset.fetch<AssetModel, void>().then((response) {
        expect('images_(2).jpg', response.title);
      });
    });

    test('testcase asset environment', () async {
      final asset = stack.asset(Credential.assetUid)
        ..environment('development');
      final params = asset.assetParameter;
      expect('{environment: development}', params.toString());
    });

    test('testcase asset fetch version', () async {
      final asset = stack.asset(Credential.assetUid)..version(4);
      await asset.fetch().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset fetch dimension of the asset', () async {
      final asset = stack.asset(Credential.assetUid);
      await asset.fetch().then((response) {
        expect('bltb2291d913f97e9cb', response['asset']['uid']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset set to model', () async {
      try {
        final asset = stack.asset(Credential.assetUid)..includeDimension();
        await asset.fetch().then((response) {
          final model = contentstack.AssetModel.fromJson(response['asset']);
          expect('{height: 171, width: 294}', model.dimension.toString());
        });
      } catch (e) {
        expect(e.message, equals('Provide asset uid to fetch single entry'));
      }
    });
  });

  group('testases for asset query', () {
    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });

    test('test asset environment', () async {
      final asset = stack.assetQuery()..environment('development');
      await asset.find().then((response) {
        expect('if_icon-72-lightning_316154_(1).png',
            response['assets'][7]['filename']);
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
        expect(50, response['assets'][7]['dimension']['height']);
      });
    });

    test('testcase assetquery query on asset', () async {
      final asset = stack.assetQuery()
        ..includeCount()
        ..relativeUrls();
      await asset.find<List<AssetModel>, AssetModel>().then((response) {
        expect(
            '/v3/assets/bltc94709340b84bdd2/bltbac3c14819c8da59/5e9007ed16db9607e2b7e0d2/if_icon-72-lightning_316154_(1).png',
            response[7].url);
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
      var language = 'en-us';
      final asset = stack.assetQuery()..includeFallback();
      await asset.find().then((response) {
        expect(9, response['assets'].length);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test('testcase asset include fallback with locale', () async {
      var language = 'en-us';
      final asset = stack.assetQuery()
        ..includeFallback()
        ..param('locale', 'en-us');
      await asset.find().then((response) {
        expect(8, response['assets'].length);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });
  });
}
