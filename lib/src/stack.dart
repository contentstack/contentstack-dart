import 'package:http/http.dart' as http;

enum Region {
  US,
  EU
}

///https://stackoverflow.com/a/57143088/622931

class HttpClient extends http.Client {

  final http.Client _client;

  HttpClient(this._client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['X-User-Agent'] = 'Dart/';
    return _client.send(request);
  }

}
class Stack {
  /// Stack API Key
  final String apiKey;
  /// Stack Delivery Token
  final String deliveryToken;
  /// Stack API Key
  final String environment;
  /// The domain host to perform requests against. Defaults to `Host.delivery` i.e. `"cdn.contentstack.com"`.
  final String host;
  ///  The region 
  final  Region region;
  final String apiVersion;
  final BaseClient _client;

  var stackHeader = new Map();

   
  /// Create a new Stack instance with stack's apikey, token, environment name and config.
  /// 
  /// Throws an [ArgumentError] if [apiKey], [deliveryToken] and [environment] is not passed. 
  /// ```dart
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// 
  /// var stack = contentstack.Stack('api_key', 'delivery_token', environment)
  /// 
  /// ```
  Stack(this.apiKey, this.deliveryToken, this.environment, { this.apiVersion = "v3", Region region = Region.US, String host = "cdn.contentstack.io", BaseClient client}) 
  : this.region = region,
    this.host = (region == Region.US ? (host) : ((host == "cdn.contentstack.io" ? 'eu-cdn.contentstack.com': "eu-${host}"))),
    this._client = client ?? Client() {
      if (this.apiKey.replaceAll(RegExp("\\W"), "").isEmpty ?? true) {
        throw new ArgumentError("Invalid argument API key can not be null.");
      }

      if (this.deliveryToken.replaceAll(RegExp("\\W"), "").isEmpty ?? true) {
        throw new ArgumentError("Invalid argument Delivery Token can not be null.");
      }

      if (this.environment.replaceAll(RegExp("\\W"), "").isEmpty ?? true) {
        throw new ArgumentError("Invalid argument Environment Name can not be null.");
      }

      this.stackHeader = {
        "api_key": apiKey,
        "access_token": deliveryToken
        // "X-User-Agent": config.userAgentString()
      };
      print(this._client.)
    }
  

}