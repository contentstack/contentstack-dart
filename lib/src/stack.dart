import 'dart:async';
import 'dart:io';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/asset.dart';
import 'package:contentstack/src/image_transform.dart';
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
  /// sync parameters
  Map<String, String> syncParameter = <String,String>{};

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

  ///Assets refer to all the media files (images, videos, PDFs, audio files, and so on)
  ///uploaded in your Contentstack repository for future use. These files can be
  ///attached and used in multiple entries. Learn more about Assets.
  /// Keep uid None to fetch list of all assets
  /// API Reference : https://www.contentstack.com/docs/content-managers/work-with-assets
  /// Asset  accepts [uid] of the asset [Optional]
  /// Returns class object of asset so we can chain the [Asset] functions.
  Asset asset({String uid}) {
    return Asset(uid, client: _client);
  }

  /// removeHeader function is to Remove header by [headerKey]
  /// It requires header key to delete the header
  ///  returns [Stack] Instance
  Stack removeHeader(String headerKey){
    if(headerKey != null ){
      if(stackHeader.containsKey(headerKey)){
        stackHeader.remove(headerKey);
      }
      return this;
    }
    throw ArgumentError.notNull("headerKey ");
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

  ///The Image Delivery API is used to retrieve, manipulate and/or convert image
  ///files of your Contentstack account and deliver it to your web or mobile properties.
  /// [Supported input formats]:  JPEG, PNG, WEBP, GIF
  /// [Supported output formats]: JPEG (baseline & progressive), PNG, WEBP (lossy & lossless), GIF
  /// Read documentation for more details:
  ///https://www.contentstack.com/docs/developers/apis/image-delivery-api/#limitations-with-optimizing-image
  ImageTransformation imageTransform(String imageUrl){
//    final bool _validURL = Uri.parse(imageUrl).isAbsolute;
//    if (!_validURL){
//      throw Exception('Invalid url requested');
//    }
//    final uri =  Uri.https(imageUrl, queryParameters.toString());
//    final String imageLink = uri.toString();
    return ImageTransformation( imageUrl);
  }

  ///Fetches all Content Types from the Stack. This call returns comprehensive information
  ///of all the content types available in a particular stack in your account.
  ///API Reference: https://www.contentstack.com/docs/apis/content-delivery-api/#content-types
  ///[queryParameters] is query parameters for the content_types of type [Map]
  /// returns list of content_types
  Future<dynamic> getContentTypes(Map queryParameters) {
    // create complete url to make request.
    return _client.sendRequest('$endpoint/content_types');
  }


  Future<dynamic> fetch() {
    return _client.sendRequest('$endpoint/stack');
  }

  ///[content_type_uid] -- You can also initialize sync with entries of
  ///only specific content_type. To do this, use syncContentType and specify
  ///the content type uid as its value. However, if you do this,
  ///the subsequent syncs will only include the entries of the specified [content_type].
  ///
  ///[from_date] -- You can also initialize sync with entries published
  ///after a specific date. To do this, use from_date
  ///and specify the start date as its value.
  ///
  ///[locale] -- You can also initialize sync with entries of only specific locales.
  ///To do this, use syncLocale and specify the locale code as its value.
  ///However, if you do this, the subsequent syncs will only include
  ///the entries of the specified locales.
  ///
  ///[publish_type] -- Use the type parameter to get a specific type of content.
  /// You can pass one of the following values:
  ///[asset_published], [entry_published], [asset_unpublished],
  /// [asset_deleted], [entry_unpublished], [entry_deleted],
  ///[content_type_deleted].
  /// If you do not specify any value, it will bring all published entries and published assets.
  ///
  ///Returns:
  ///List[SyncResult] -- returns list of SyncResult
  void sync({String contentTypeUid,  String fromDate, String locale, PublishType publishType}){
    syncParameter['init'] = 'true';
    if(contentTypeUid !=null){
      syncParameter['content_type_uid'] = contentTypeUid;
    }
    if(fromDate !=null){
      syncParameter['from_date'] = fromDate;
    }
    if(locale !=null){
      syncParameter['locale'] = locale;
    }
    if(publishType !=null){
      syncParameter['publish_type'] = publishType as String;
    }
   // return _client.sendRequest('$endpoint/stack');
  }


  /// If the result of the initial sync (or subsequent sync) contains more than 100 records, the response would be
  ///paginated. It provides pagination token in the response. However, you do not have to use the pagination token
  /// manually to get the next batch, the SDK does that automatically until the sync is complete. Pagination token
  ///can be used in case you want to fetch only selected batches. It is especially useful if the sync process is
  ///interrupted midway (due to network issues, etc.). In such cases, this token can be used to restart the sync
  ///process from where it was interrupted.
  ///
  void pagination(String paginationToken){
    if(paginationToken==null){
      throw ArgumentError.notNull('paginationToken');
    }
    syncParameter['pagination_token'] = paginationToken;
  }


  /// You can use the sync token (that you receive after initial sync)
  /// to get the updated content next time.
  /// The sync token fetches only the content that was added after your last sync,
  ///and the details of the content that was deleted or updated.
  ///
  void syncToken(String syncToken){
    if(syncToken == null){
      throw ArgumentError.notNull('Sync Token');
    }
    syncParameter['sync_token'] = syncToken;
  }

}



class PublishType {
  static const assetPublished = 'asset_published';
  static const entryPublished = 'entry_published';
  static const assetUnpublished = 'asset_unpublished';
  static const assetDeleted = 'asset_deleted';
  static const entryUnpublished = 'entry_unpublished';
  static const entryDeleted = 'entry_deleted';
  static const contentTypeDeleted = 'content_type_deleted';
}