import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'credentials.dart';

void main() {

  group('test the functional implementation', () {
    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });


    test("test functional asset environment", () async {
      final asset = stack.asset(uid: Credential.assetUid);
      asset.environment('development');
      final params = asset.queryParameter;
      expect("{environment: development}", params.toString());
    });


  });

  group('test the API implementation', () {

    contentstack.Stack stack;
    setUp(() {
      stack = Credential.stack();
    });

    test("test asset environment", () async {
      final asset = stack.asset(uid: Credential.assetUid);
      asset.environment('development');
      await asset.fetch().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset fetch version", () async {
      final asset = stack.asset(uid: Credential.assetUid);
      asset.version(4);
      await asset.fetch().then((response) {
        expect('images_(2).jpg', response['asset']['filename']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset fetch dimension of the asset", () async {
      final asset = stack.asset(uid: Credential.assetUid);
      asset.includeDimension();
      await asset.fetch().then((response) {
        expect(171, response['asset']['dimension']['height']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset query on asset", () async {
      final asset = stack.asset(uid: Credential.assetUid);
      asset.relativeUrls();
      await asset.fetch().then((response) {
        expect(
            '/v3/assets/bltc94709340b84bdd2/bltb2291d913f97e9cb/5e9007ed89d7817e9320a769/images_(2).jpg',
            response['asset']['url']);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset find chaining the functions", () async {
      final asset = stack.asset(uid: Credential.assetUid);
      // chaining the functions
      asset..version(4)..relativeUrls()..includeDimension();
      await asset.find().then((response) {
        expect(0, response["assets"].length);
      }).catchError((error) {
        expect(422, error['error_code']);
      });
    });

    test("testcase asset find but uid is not available", () async {
      try {
        final asset = stack.asset();
        await asset.fetch().then((response) {
          expect(171, response['asset']['dimension']['height']);
        });
      } catch (e) {
        expect(e.message, equals("Provide asset uid to fetch single entry"));
      }
    });


    test("testcase asset set to model", () async {
      try {
        final asset = stack.asset();
        await asset.fetch().then((response) {
          final model = contentstack.AssetModel.fromJson(response['asset']);
          expect(171, model.dimension);
        });
      } catch (e) {
        expect(e.message, equals("Provide asset uid to fetch single entry"));
      }
    });


  });
}
