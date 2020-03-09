import 'dart:io';
import 'package:contentstack/client.dart';
import 'package:http/http.dart';
import 'package:contentstack/contentstack.dart';


enum Region {
  US,
  EU
}



class Stack {
  
  /// Stack API Key
  final String _apiKey;
  /// Stack Delivery Token
  final String _deliveryToken;
  /// Stack API Key
  final String _environment;
  /// The domain host to perform requests against. 
  /// Defaults to `Host.delivery` i.e. `"cdn.contentstack.com"`.
  final String _host;
  ///  The region 
  final Region region;
  /// The Api Version
  final String apiVersion;
  /// The BaseClient
  HttpClient _client;

  /// stack headers
  // ignore: prefer_collection_literals
  var stackHeader = <String,String>{};
  // ignore: prefer_collection_literals
  var queryParameter = <String,String>{};


  /// Create a new Stack instance with stack's apikey, token, environment name and Optional parameters like.
  /// Throws an [ArgumentError] if [apiKey], [deliveryToken] and [environment] is not passed.
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// var stack = contentstack.Stack('api_key', 'delivery_token', environment)
  Stack(this._apiKey, this._deliveryToken, this._environment, { this.apiVersion = "v3",
    this.region = Region.US, String host = "cdn.contentstack.io", BaseClient client}):
        _host = (region == Region.US) ? host : (host == "cdn.contentstack.io" ? 'eu-cdn.contentstack.com': "eu-$host"){

    // final blank = s == null || s.trim() == '';
    if (_apiKey.replaceAll(RegExp("\\W"), "").isEmpty ?? true) {
      throw ArgumentError.notNull('APIkey');
    }

    if (_deliveryToken.replaceAll(RegExp("\\W"), "").isEmpty ?? true) {
      throw ArgumentError.notNull('deliveryToken');
    }

    if (_environment.replaceAll(RegExp("\\W"), "").isEmpty ?? true) {
      throw ArgumentError.notNull('environment');
    }


    stackHeader = {
      "api_key": _apiKey,
      "access_token": _deliveryToken,
      "environment" : _environment,
      "api_version" : apiVersion,
      "host" : host,
    };

    _client = HttpClient(stackHeader, client: client);
  }
    ContentType contentType(String uid) {
      return ContentType(uid, client: _client);
    }


}