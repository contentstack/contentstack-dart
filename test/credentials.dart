import 'package:contentstack/contentstack.dart' as contentstack;

// ignore: avoid_classes_with_only_static_members
class Credential{

  static const assetUid = 'bltb2291d913f97e9cb';
  static const String apiKey = 'bltc94709340b84bdd2';
  static const String accessToken = 'blt4cb0db9f9139b604';
  static const String deliveryToken = 'csd2e69747f83e59e327d19962';
  static const String environment = 'development';
  static const String entryUid = 'blt53ca1231625bdde4';

  static contentstack.Stack stack(){
    final contentstack.Stack stack = contentstack.Stack(apiKey, deliveryToken, environment, region: contentstack.Region.us);
    return stack;
  }

}

