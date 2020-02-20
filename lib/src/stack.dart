import 'dart:async';
import 'dart:convert';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/error/apiexception.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

enum Region {
  US,
  EU
}

///https://stackoverflow.com/a/57143088/622931
class HttpClient extends http.BaseClient {
  HttpClient(this._client);

  final http.Client _client;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
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
  final Region region;
  final String apiVersion;
  final HttpClient _client;

  var stackHeader = new Map<String, String>();

   
  /// Create a new Stack instance with stack's apikey, token, environment name and config.
  /// 
  /// Throws an [ArgumentError] if [apiKey], [deliveryToken] and [environment] is not passed. 
  /// ```dart
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// 
  /// var stack = contentstack.Stack('api_key', 'delivery_token', environment)
  /// 
  /// ```
  Stack(this.apiKey, this.deliveryToken, this.environment, { this.apiVersion = "v3", Region region = Region.US, String host = "cdn.contentstack.io", http.BaseClient client}) 
  : this.region = region,
    this.host = (region == Region.US ? (host) : ((host == "cdn.contentstack.io" ? 'eu-cdn.contentstack.com': "eu-${host}"))),
    this._client = client != null ? HttpClient(client) != null : HttpClient(http.Client()) {
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
      };
    }
  
    // Future<dynamic> fetch() async {
    //   var response = this._client.get('${this.host}/stack', headers: stackHeader);

    //   return;
    // }
    ContentType contentType(String uid) {
      ContentType contentType = ContentType(uid);
      contentType.stack = this;
      return contentType;
    }

    Future<T> fetch<T>(String endpoint,{  @required T Function(Map<String, dynamic>) fromJson,  Map paramerter }) async{
        Uri uri = Uri.http(this.host, '/${this.apiVersion}${endpoint}', paramerter);
        var response = await this._fetchURL(uri);
        Map<String, dynamic> jsonString =json.decode(utf8.decode(response.bodyBytes));
        
        if (response.statusCode != 200) {
          var apiExeption = APIException.error(jsonString, response.statusCode);
          if (apiExeption != null) {
            throw apiExeption;
          }
        }
        return fromJson(jsonString['content_type'] ?? jsonString ?? {});
    }

    // @visibleForTesting
    Future<http.Response> _fetchURL(Uri uri) async {
      var response = await this._client.get(uri, headers: this.stackHeader);
      return response;
    }
}