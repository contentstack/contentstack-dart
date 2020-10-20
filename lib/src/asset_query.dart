import 'dart:async';
import "package:contentstack/client.dart";
import 'package:contentstack/src/base_query.dart';

/// This call fetches the list of all the assets of a particular stack.
/// It also returns the content of each asset in JSON format.
/// You can also specify the environment of which you wish to get the assets.
/// Learn more about [Assets](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#all-assets)
class AssetQuery extends BaseQuery {
  final HttpClient _client;
  String _urlPath;

  AssetQuery([this._client]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _urlPath = '/${_client.stack.apiVersion}/assets';
  }

  ///
  /// Enter the name of the [environment] if you wish to retrieve
  /// the assets published in a particular environment.
  /// [environment] required
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.assetQuery()..environment('development');
  /// await asset.find().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  ///
  void environment(String environment) {
    queryParameter['environment'] = environment;
  }

  ///
  /// Specify the version number of the asset that you wish to retrieve.
  /// If the version is not specified, the details of the latest 
  /// version will be retrieved.
  /// To retrieve a specific version, keep the environment parameter blank.
  /// [version] required
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.assetQuery()..version(3);
  /// await asset.find().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  ///
  void version(int version) {
    queryParameter['version'] = version.toString();
  }

  ///
  /// include the dimensions (height and width) of the image in the response.
  /// Supported image types: JPG, GIF, PNG, WebP, BMP, TIFF, SVG, and PSD.
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.assetQuery()..includeDimension();
  /// await asset.find().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void includeDimension() {
    queryParameter['include_dimension'] = 'true';
  }

  ///
  /// includes the relative URLs of the assets in the response
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.assetQuery()..relativeUrls();
  /// await asset.find().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void relativeUrls() {
    queryParameter['relative_urls'] = 'true';
  }

  ///
  /// To retrieve the count of entries, we have two parameters:
  /// include_count (retrieves entries' details and their count)
  /// and count (retrieves only the count of entries).
  ///
  /// Example: If you wish to know the total number of entries in
  /// the a content type and also retrieve all the data.
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.assetQuery()..includeCount();
  /// await asset.find().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void includeCount() {
    queryParameter['include_count'] = 'true';
  }

  ///
  /// Retrieve the published content of the fallback locale if an entry is not
  /// localized in specified locale.
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.assetQuery()..includeFallback();
  /// await asset.find().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void includeFallback() {
    queryParameter['include_fallback'] = 'true';
  }

  /// find is applicable for getting all the available assets based on the query
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// await stack.assetQuery().find().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  Future<T> find<T, K>() async {
    final uri = Uri.https(_client.stack.endpoint, _urlPath, queryParameter);
    return _client.sendRequest<T, K>(uri);
  }
}
