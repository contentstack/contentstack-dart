import 'dart:async';
import 'dart:io';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/asset.dart';
import 'package:http/http.dart';
import 'package:contentstack/contentstack.dart';
import 'package:logging/logging.dart';

enum Region {
  US,
  EU
}

class Stack {

  static const String https = 'https://';
  final Logger log = Logger('Stack');
  /// Stack API Key
  final String _apiKey;
  /// Stack Delivery Token
  final String _deliveryToken;
  /// Stack API Key
  final String _environment;
  /// The domain host to perform requests against. Defaults to `Host.delivery` i.e. `"cdn.contentstack.com"`.
  final String _host;
  ///  The region 
  final Region region;
  /// The Api Version
  final String apiVersion;
  /// The BaseClient
  HttpClient _client;
  /// stack headers
  Map<String, String> stackHeader = <String,String>{};
  /// stack Query parameters
  Map<String, String> queryParameter = <String,String>{};

  /// Create a new Stack instance with stack's apikey, token, environment name and Optional parameters like.
  /// Throws an [ArgumentError] if [apiKey], [deliveryToken] and [environment] is not passed.
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// var stack = contentstack.Stack('api_key', 'delivery_token', environment)
  Stack(this._apiKey, this._deliveryToken, this._environment,  { this.apiVersion = "v3",
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
    };

    _client = HttpClient(stackHeader, client: client);
  }

  /// ContentType  accepts contentTypeId  in  as the parameter
  /// Returns instance of [ContentType].
   ContentType contentType(String contentTypeId) {
    if(contentTypeId.replaceAll(RegExp("\\W"), "").isEmpty ?? true){
      throw ArgumentError("contentTypeId can't be null or empty");
    }
      return ContentType(contentTypeId, client: _client);
    }


  /// Asset  accepts [uid]  of asset in  as the parameter
  /// Returns instance of [Asset].
  Asset asset({String uid}) {
    return Asset(uid, client: _client);
  }

  /// removeHeader function is to Remove header by [headerKey]
  /// It requires header key to delete the header
  ///  returns [Stack] Instance
  Stack removeHeader(String headerKey){
    if(headerKey == null){
      throw ArgumentError.notNull("headerKey ");
    }
    stackHeader.remove(headerKey);
    return this;
  }

  Stack setHeader (String key, String value){
    if(key == null || value == null){
      throw ArgumentError.notNull("key & value ");
    }
    stackHeader[key] = value;
    return this;
  }

  /// It returns apiKey of the Stack
  String get apiKey => _apiKey;

    /// It returns delivery token of the Stack
  String get deliveryToken => _deliveryToken;

  /// It returns delivery token of the Environment
  String get environment => _environment;

  /// It returns host of the Stack
  String get host => _host;

  /// It returns endpoint of the Stack
  String get endpoint => "$https$host/$apiVersion";

  Stack  includeStackVariables(){
    queryParameter['include_stack_variables'] = 'true';
    return this;
  }

  Stack  includeDiscreteVariables(){
    queryParameter['include_discrete_variables'] = 'true';
    return this;
  }

  Stack  includeCount(){
    queryParameter['include_count'] = 'true';
    return this;
  }

  String imageTransform(String imageUrl, Map queryParameters){
    final bool _validURL = Uri.parse(imageUrl).isAbsolute;
    if (!_validURL){
      throw Exception('Invalid url requested');
    }
    final uri =  Uri.https(imageUrl, queryParameters.toString());
    final String imageLink = uri.toString();
    return imageLink;
  }

  ///This call returns comprehensive information of all the content types available in a particular stack in your account
  ///[queryParameter] is query parameters of type [Map]
  Future<dynamic> getContentTypes(Map queryParameters) {
//    final uri =  Uri.https('$endpoint/content_types', queryParameters.toString());
//    final response = await _client.get('$endpoint/content_types');
//    if(response.statusCode == 200){
//      return response;
//    }
//    log.fine('Got the response: $response');
    return _client.sendRequest('$endpoint/content_types');
  }

  Future<String> fetch() async{
    final response = await _client.get('$endpoint/stack');
    log.log(Level.FINE, response);
  }

  void sync(){

  }


}