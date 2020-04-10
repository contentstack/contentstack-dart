import 'package:contentstack/contentstack.dart' as contentstack;

class Credential{

  static const assetUid = 'something';

  static contentstack.Stack stack(){
    const String _apiKey = 'bltc94709340b84bdd2';
    //const String _accessToken = 'blt4cb0db9f9139b604';
    const String _deliveryToken = 'csd2e69747f83e59e327d19962';
    const String _environment = 'development';
    final contentstack.Stack stack = contentstack.Stack(_apiKey, _deliveryToken, _environment, region: contentstack.Region.us);
    return stack;
  }

}

