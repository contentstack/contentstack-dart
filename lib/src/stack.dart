import 'dart:async';
import 'dart:io';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/asset.dart';
import 'package:contentstack/src/image_transform.dart';
import 'package:contentstack/src/sync/publishtype.dart';
import 'package:http/http.dart';
import 'package:contentstack/contentstack.dart';
import 'package:logging/logging.dart';

///
/// A stack can be defined as a pool of data or a container that
/// holds all the content/assets related to a site.
/// It is a collaboration space where multiple users can work
/// together to create, edit, approve, and publish content
/// For more details, Read documentation:
/// https://www.contentstack.com/docs/developers/set-up-stack/about-stack
///
/// Example:
/// final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
///
class Stack {
  final Logger log = Logger('Stack');
  final String _apiKey;
  final String _deliveryToken;
  final String _environment;
  final String _host;
  final Region region;
  final String apiVersion;
  HttpClient _client;

  Map<String, String> stackHeader = <String, String>{};
  final Map<String, String> queryParameter = <String, String>{};

  ///
  /// Create a new Stack instance with stack's apikey, token, environment name and Optional parameters like.
  /// Throws an [ArgumentError] if [apiKey], [deliveryToken] and [environment] is not passed.
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// var stack = contentstack.Stack('api_key', 'delivery_token', environment)
  ///
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  ///

  Stack(this._apiKey, this._deliveryToken, this._environment,
      {this.apiVersion = "v3",
      this.region = Region.us,
      String host = "cdn.contentstack.io",
      BaseClient client})
      : _host = (region == Region.us)
            ? host
            : (host == "cdn.contentstack.io"
                ? 'eu-cdn.contentstack.com'
                : "eu-$host") {
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
      "environment": _environment,
    };

    _client = HttpClient(stackHeader, client: client, stack: this);
  }

  ///
  /// ContentType  accepts contentTypeId  in  as the parameter
  /// Returns instance of [ContentType].
  /// contentType takes [contentTypeId] as optional parameter
  /// If you want get one contentType by their content_type_uid
  ///
  /// Example:
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var contentType = stack.contentType('content_type_id');
  ///
  ContentType contentType([String contentTypeId]) {
    return ContentType(contentTypeId, _client);
  }

  ///
  /// Assets refer to all the media files (images, videos, PDFs, audio files, and so on)
  /// uploaded in your Contentstack repository for future use. These files can be
  /// attached and used in multiple entries. Learn more about Assets.
  /// Keep uid None to fetch list of all assets
  /// API Reference : https://www.contentstack.com/docs/content-managers/work-with-assets
  /// Asset  accepts [uid] of the asset Optional
  /// Returns class object of asset so we can chain the [Asset] functions.
  ///
  /// Example:
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var asset = stack.asset('asset_uid');
  ///
  Asset asset({String uid}) {
    return Asset(uid, _client);
  }

  ///
  /// removeHeader function is to Remove header by [headerKey]
  /// It requires header key to delete the header
  ///  returns [Stack] Instance
  ///

  void removeHeader(String headerKey) {
    if (headerKey != null) {
      if (stackHeader.containsKey(headerKey)) {
        stackHeader.remove(headerKey);
      }
    }
  }

  void setHeader(String key, String value) {
    if (key == null || value == null) {
      throw ArgumentError.notNull("key & value ");
    }
    stackHeader[key] = value;
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
  String get endpoint => host;

  void includeStackVariables() {
    queryParameter['include_stack_variables'] = 'true';
  }

  void includeDiscreteVariables() {
    queryParameter['include_discrete_variables'] = 'true';
  }

  void includeCount() {
    queryParameter['include_count'] = 'true';
  }

  ///
  /// The Image Delivery API is used to retrieve, manipulate and/or convert image
  /// files of your Contentstack account and deliver it to your web or mobile properties.
  /// {Supported input formats}:  JPEG, PNG, WEBP, GIF
  /// {Supported output formats}: JPEG (baseline & progressive), PNG, WEBP (lossy & lossless), GIF
  /// Read documentation for more details:
  /// https://www.contentstack.com/docs/developers/apis/image-delivery-api/#limitations-with-optimizing-image
  ///
  /// [imageUrl] is the required parameter
  ///
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// imageTransformation = stack.imageTransform(imageUrl);
  ///
  ImageTransformation imageTransform(String imageUrl) {
    return ImageTransformation(imageUrl, _client);
  }

  ///
  /// Fetches all Content Types from the Stack.
  /// This call returns comprehensive information
  /// of all the content types available in a particular stack in your account.
  /// API Reference: https://www.contentstack.com/docs/apis/content-delivery-api/#content-types
  /// [queryParameters] is query parameters for the content_types of type [Map]
  /// returns list of content_types
  ///
  /// Example:
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// response = stack.getContentTypes(queryParameters);
  ///

  Future<dynamic> getContentTypes(Map queryParameters) {
    final Uri uri = Uri.https(endpoint, '$apiVersion/content_types');
    return _client.sendRequest(uri);
  }

  /// gets stack Future response
  Future<dynamic> fetch() {
    final Uri uri = Uri.https(endpoint, '$apiVersion/stack');
    return _client.sendRequest(uri);
  }

  /// [contentTypeUid] -- You can also initialize sync with entries of
  /// only specific content_type. To do this, use syncContentType and specify
  /// the content type uid as its value. However, if you do this,
  /// the subsequent syncs will only include the entries of the specified content_type.
  ///
  /// [fromDate] -- You can also initialize sync with entries published
  /// after a specific date. To do this, use from_date
  /// and specify the start date as its value.
  ///
  /// [locale] -- You can also initialize sync with entries of only specific locales.
  /// To do this, use syncLocale and specify the locale code as its value.
  /// However, if you do this, the subsequent syncs will only include
  /// the entries of the specified locales.
  ///
  /// [publishType] -- Use the type parameter to get a specific type of content.
  /// If you do not specify any value, it will bring all published entries and published assets.
  ///
  /// Returns:
  /// List[SyncModel] -- returns list of SyncResult
  ///
  Future sync(
      {String contentTypeUid,
      String fromDate,
      String locale,
      PublishType publishType}) async {
    final parameter = <String, String>{};
    parameter['init'] = 'true';
    if (contentTypeUid != null && contentTypeUid.isNotEmpty) {
      parameter['content_type_uid'] = contentTypeUid;
    }
    if (fromDate != null && fromDate.isNotEmpty) {
      parameter['from_date'] = fromDate;
    }
    if (locale != null && locale.isNotEmpty) {
      parameter['locale'] = locale;
    }
    if (publishType != null) {
      publishType.when(assetPublished: (result) {
        parameter["publish_type"] = "asset_published";
      }, entryPublished: (result) {
        parameter["publish_type"] = "entry_published";
      }, assetUnpublished: (result) {
        parameter["publish_type"] = "asset_unpublished";
      }, assetDeleted: (result) {
        parameter["publish_type"] = "asset_deleted";
      }, entryUnpublished: (result) {
        parameter["publish_type"] = "entry_unpublished";
      }, entryDeleted: (result) {
        parameter["publish_type"] = "entry_deleted";
      }, contentTypeDeleted: (result) {
        parameter["publish_type"] = "content_type_deleted";
      });
    }
    return _syncRequest(parameter);
  }

  Future<dynamic> _syncRequest(parameters) async {
    parameters['environment'] = _client.stackHeaders['environment'];
    final Uri uri = Uri.https(endpoint, '$apiVersion/stacks/sync', parameters);
    return _client.sendRequest(uri);
  }

  ///
  /// If the result of the initial sync (or subsequent sync) contains more than 100 records, the response would be
  /// paginated. It provides pagination token in the response. However, you do not have to use the pagination token
  /// manually to get the next batch, the SDK does that automatically until the sync is complete. Pagination token
  /// can be used in case you want to fetch only selected batches. It is especially useful if the sync process is
  /// interrupted midway (due to network issues, etc.). In such cases, this token can be used to restart the sync
  /// process from where it was interrupted.
  ///
  Future<dynamic> paginationToken(String paginationToken) {
    final parameters = <String, String>{};
    if (paginationToken != null && paginationToken.isNotEmpty) {
      parameters['pagination_token'] = paginationToken;
    }
    return _syncRequest(parameters);
  }

  ///
  /// You can use the sync token (that you receive after initial sync)
  /// to get the updated content next time.
  /// The sync token fetches only the content that was added after your last sync,
  /// and the details of the content that was deleted or updated.
  ///
  ///
  Future<dynamic> syncToken(String syncToken) {
    final parameters = <String, String>{};
    if (syncToken != null && syncToken.isNotEmpty) {
      parameters['sync_token'] = syncToken;
    }
    return _syncRequest(parameters);
  }
}

enum Region { us, eu }
