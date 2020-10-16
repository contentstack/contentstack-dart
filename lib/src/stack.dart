import 'dart:async';
import 'dart:io';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/asset.dart';
import 'package:contentstack/src/asset_query.dart';
import 'package:contentstack/src/image_transform.dart';
import 'package:contentstack/src/sync/publishtype.dart';
import 'package:http/http.dart';
import 'package:contentstack/contentstack.dart';

/// A stack is like a container that holds the content of your app.
/// Learn more about [Stacks](https://www.contentstack.com/docs/developers/set-up-stack/about-stack/).
class Stack {
  Map<String, String> stackHeader = <String, String>{};
  final String _apiKey;
  final String _deliveryToken;
  final String _environment;
  final String _host;
  final Region region;
  final String apiVersion;
  HttpClient _client;

  ///
  /// Create a new Stack instance with stack's apikey, token, environment name and Optional parameters like.
  /// Throws an [ArgumentError] if [apiKey], [deliveryToken] and [environment] is not passed.
  /// import 'package:contentstack/contentstack.dart' as contentstack;
  /// var stack = contentstack.Stack('api_key', 'delivery_token', environment)
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// ```
  ///
  Stack(this._apiKey, this._deliveryToken, this._environment,
      {this.apiVersion = 'v3',
      this.region = Region.us,
      String host = 'cdn.contentstack.io',
      BaseClient client})
      : _host = (region == Region.us)
            ? host
            : (host == 'cdn.contentstack.io'
                ? 'eu-cdn.contentstack.com'
                : 'eu-$host') {
    // final blank = s == null || s.trim() == '';
    if (_apiKey.replaceAll(RegExp('\\W'), '').isEmpty ?? true) {
      throw ArgumentError.notNull('APIkey');
    }

    if (_deliveryToken.replaceAll(RegExp('\\W'), '').isEmpty ?? true) {
      throw ArgumentError.notNull('deliveryToken');
    }

    if (_environment.replaceAll(RegExp('\\W'), '').isEmpty ?? true) {
      throw ArgumentError.notNull('environment');
    }

    stackHeader = {
      'api_key': _apiKey,
      'access_token': _deliveryToken,
      'environment': _environment,
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
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var contentType = stack.contentType('content_type_id');
  /// ```
  ///
  ContentType contentType([String contentTypeId]) {
    return ContentType(contentTypeId, _client);
  }

  ///
  /// This call fetches the latest version of a specific
  /// asset of a particular stack.
  /// API Reference :
  /// https://www.contentstack.com/docs/developers/apis/content-delivery-api/#single-asset
  /// [uid] assetUid
  ///
  /// Example:
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var asset = stack.asset('uid');
  /// ```
  ///
  Asset asset(String uid) {
    return Asset(uid, _client);
  }

  ///
  /// This call fetches the list of all the assets of a particular stack.
  /// It also returns the content of each asset in JSON format.
  /// You can also specify the environment of which you wish to get the assets.
  /// API Reference :
  /// https://www.contentstack.com/docs/developers/apis/content-delivery-api/#all-assets
  ///
  /// Example:
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var asset = stack.assetQuery();
  /// ```
  ///
  AssetQuery assetQuery() {
    return AssetQuery(_client);
  }

  ///
  /// removeHeader function is to Remove header by [headerKey]
  /// It requires header key to delete the header
  /// returns [Stack] Instance
  ///
  /// Example:
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// stack = stack..removeHeader('headerKey');
  /// ```
  void removeHeader(String headerKey) {
    if (headerKey != null) {
      if (stackHeader.containsKey(headerKey)) {
        stackHeader.remove(headerKey);
      }
    }
  }

  /// Adds headers for the request
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// stack = stack..setHeader('headerKey', 'headervalue');
  /// ```
  void setHeader(String key, String value) {
    if (key.isNotEmpty && value.isNotEmpty) {
      stackHeader[key] = value;
    }
  }

  /// It returns apiKey of the Stack
  ///
  /// Example
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var apiKey = stack.apiKey;
  /// ```
  String get apiKey => _apiKey;

  /// It returns delivery token of the Stack
  ///
  /// Example
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var deliveryToken = stack.deliveryToken;
  /// ```
  String get deliveryToken => _deliveryToken;

  /// It returns delivery token of the Environment
  ///
  /// Example
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var environment = stack.environment;
  /// ```
  String get environment => _environment;

  /// It returns host of the Stack
  ///
  /// Example
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var environment = stack.environment;
  /// ```
  String get host => _host;

  /// It returns endpoint of the Stack
  ///
  /// Example
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// var environment = stack.environment;
  /// ```
  String get endpoint => host;

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
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// imageTransformation = stack.imageTransform(imageUrl);
  /// ```
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
  ///
  /// ```dart
  /// final stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// response = stack.getContentTypes(queryParameters);
  /// ```
  ///
  Future<T> getContentTypes<T, K>(Map queryParameters) {
    final Uri uri = Uri.https(endpoint, '$apiVersion/content_types');
    return _client.sendRequest<T, K>(uri);
  }

  /////////////////////////////////////////////////
  //    ---------[Synchronization]----------     //
  /////////////////////////////////////////////////

  /// * [contentTypeUid] -- You can also initialize sync with entries of
  /// only specific content_type. To do this, use syncContentType and specify
  /// the content type uid as its value. However, if you do this,
  /// the subsequent syncs will only include the entries of the specified content_type.
  ///
  /// * [fromDate] -- You can also initialize sync with entries published
  /// after a specific date. To do this, use from_date
  /// and specify the start date as its value.
  ///
  /// * [locale] -- You can also initialize sync with entries of only specific locales.
  /// To do this, use syncLocale and specify the locale code as its value.
  /// However, if you do this, the subsequent syncs will only include
  /// the entries of the specified locales.
  ///
  /// * [publishType] -- Use the type parameter to get a specific type of content.
  /// If you do not specify any value, it will bring all published entries and published assets.
  ///
  /// Returns: List Of [SyncResult]
  ///
  Future<T> sync<T, K>(
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
        parameter['publish_type'] = 'asset_published';
      }, entryPublished: (result) {
        parameter['publish_type'] = 'entry_published';
      }, assetUnpublished: (result) {
        parameter['publish_type'] = 'asset_unpublished';
      }, assetDeleted: (result) {
        parameter['publish_type'] = 'asset_deleted';
      }, entryUnpublished: (result) {
        parameter['publish_type'] = 'entry_unpublished';
      }, entryDeleted: (result) {
        parameter['publish_type'] = 'entry_deleted';
      }, contentTypeDeleted: (result) {
        parameter['publish_type'] = 'content_type_deleted';
      });
    }

    return _syncRequest<T, K>(parameter);
  }

  Future<T> _syncRequest<T, K>(parameters) async {
    parameters['environment'] = _client.stackHeaders['environment'];
    final Uri uri = Uri.https(endpoint, '$apiVersion/stacks/sync', parameters);
    return _client.sendRequest<T, K>(uri);
  }

  ///
  /// If the result of the initial sync (or subsequent sync) contains more than 100 records, the response would be
  /// paginated. It provides pagination token in the response. However, you do not have to use the pagination token
  /// manually to get the next batch, the SDK does that automatically until the sync is complete. Pagination token
  /// can be used in case you want to fetch only selected batches. It is especially useful if the sync process is
  /// interrupted midway (due to network issues, etc.). In such cases, this token can be used to restart the sync
  /// process from where it was interrupted.
  ///
  Future<T> paginationToken<T, K>(String paginationToken) {
    final parameters = <String, String>{};
    if (paginationToken != null && paginationToken.isNotEmpty) {
      parameters['pagination_token'] = paginationToken;
    }
    return _syncRequest<T, K>(parameters);
  }

  ///
  /// You can use the sync token (that you receive after initial sync)
  /// to get the updated content next time.
  /// The sync token fetches only the content that was added after your last sync,
  /// and the details of the content that was deleted or updated.
  ///
  ///
  Future<T> syncToken<T, K>(String syncToken) {
    final parameters = <String, String>{};
    if (syncToken != null && syncToken.isNotEmpty) {
      parameters['sync_token'] = syncToken;
    }

    parameters['environment'] = _client.stackHeaders['environment'];
    final Uri uri = Uri.https(endpoint, '$apiVersion/stacks/sync', parameters);
    return _client.sendRequest<T, K>(uri);
  }
}

/// Choosing a Region
/// A Contentstack region refers to the location of the data centers
/// where your organization's data resides
/// * Default [Region](https://www.contentstack.com/docs/developers/contentstack-regions/about-regions/) is: US
// Contact our support team at support@contentstack.com for more details.
enum Region { us, eu }
