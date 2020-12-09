//import 'package:dotenv/dotenv.dart' show load, env;

import 'package:contentstack/contentstack.dart' as contentstack;
// import 'package:logger/logger.dart';

// Future main() async {
//   final logger = Logger(
//     level: Level.info,
//     printer: PrettyPrinter(),
//   );
//   load();
//   final apiKey = env['apiKey'];
//   final accessToken = env['accessToken'];
//   final deliveryToken = env['deliveryToken'];
//   final environment = env['environment'];
//   final entryUid = env['entryUid'];
//   final assetUid = env['assetUid'];

//   final loggerText = '''
// dart testcases initiated for below keys...\napiKey: $apiKey\n...accessToken: $accessToken\n...deliveryToken: $deliveryToken''';
//   logger.i(loggerText);
//   // ignore: cascade_invocations
//   logger.i('Progressing...');
// }

class Credential {
  static const assetUid =
      'bltb2291d913f97e9cb'; //env['assetUid']; //env['assetUid'];
  static const apiKey = 'bltc94709340b84bdd2'; //env['apiKey'];
  static const accessToken = 'blt4cb0db9f9139b604'; //env['accessToken'];
  static const deliveryToken =
      'csd2e69747f83e59e327d19962'; //env['deliveryToken'];
  static const environment = 'development'; //env['environment']
  static const entryUid = 'blt53ca1231625bdde4'; //env['entryUid'];

  static contentstack.Stack stack() {
    final contentstack.Stack stack =
        contentstack.Stack(apiKey, deliveryToken, environment);
    return stack;
  }
}
