import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'credentials.dart';

void main() {
  group('testcases for asset the functional implementation', () {
    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });

    test("testcase asset environment", () async {
      final asset = stack.asset(Credential.assetUid);
      asset.environment('development');
      await asset.fetch().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      });
    });

    test("testcase asset environment", () async {
      final asset = stack.asset(Credential.assetUid);
      asset.environment('development');
      final params = asset.assetParameter;
      expect("{environment: development}", params.toString());
    });

    test("testcase asset fetch version", () async {
      final asset = stack.asset(Credential.assetUid);
      asset.version(4);
      await asset.fetch().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset fetch dimension of the asset", () async {
      final asset = stack.asset(Credential.assetUid);
      await asset.fetch().then((response) {
        expect(171, response['asset']['dimension']['height']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset set to model", () async {
      try {
        final asset = stack.asset(Credential.assetUid);
        await asset.fetch().then((response) {
          final model = contentstack.AssetModel.fromJson(response['asset']);
          expect(171, model.dimension);
        });
      } catch (e) {
        expect(e.message, equals("Provide asset uid to fetch single entry"));
      }
    });
  });

  group('testases for asset query', () {
    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });

    test("test asset environment", () async {
      final asset = stack.assetQuery();
      asset.environment('development');
      await asset.find().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset fetch version", () async {
      final asset = stack.assetQuery();
      asset.version(4);
      await asset.find().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      });
    });

    test("testcase asset fetch dimension of the asset", () async {
      final asset = stack.assetQuery();
      asset.includeDimension();
      await asset.find().then((response) {
        expect(171, response['asset']['dimension']['height']);
      });
    });

    test("testcase assetquery query on asset", () async {
      final asset = stack.assetQuery();
      asset.relativeUrls();
      await asset.find().then((response) {
        expect(
            '/v3/assets/bltc94709340b84bdd2/bltb2291d913f97e9cb/5e9007ed89d7817e9320a769/images_(2).jpg',
            response['asset']['url']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset find chaining the functions", () async {
      final asset = stack.assetQuery();
      // cascading the functions
      asset
        ..version(4)
        ..relativeUrls()
        ..includeDimension();
      await asset.find().then((response) {
        expect(0, response["assets"].length);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });
  });
}
