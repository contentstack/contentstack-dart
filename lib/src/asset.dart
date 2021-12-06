import 'dart:async';

import 'package:contentstack/client.dart';

/// This call fetches the latest version of a specific
/// `asset` of a particular stack.
/// Read more about
/// Learn more about [Assets](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#get-a-single-asset)
///
class Asset {
  final HttpClient _client;
  final String _uid;
  String _urlPath;

  final Map<String, String> assetParameter = <String, String>{};

  /// * [_uid] assetUid:
  /// Enter the unique ID of the asset of which you wish to retrieve
  /// the details. {Example: asset_uid}
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.asset(asset_uid);
  /// asset.fetch<AssetModel, void>().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  ///
  Asset(this._uid, [this._client]) {
    assetParameter['environment'] = _client.stackHeaders['environment'];
    _urlPath = '/${_client.stack.apiVersion}/assets';
  }

  ///
  /// Enter the name of the [environment] if you wish to retrieve
  /// the assets published in a particular environment.
  /// [environment] required
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.asset(asset_uid)..environment('development');
  /// asset.fetch<AssetModel, void>().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void environment(String environment) {
    assetParameter['environment'] = environment;
  }

  /// It fetch single asset data on the basis of the asset uid.
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// asset.fetch<AssetModel, void>().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  Future<T> fetch<T, K>() {
    if (_uid == null || _uid.isEmpty) {
      throw Exception('Provide asset uid to fetch single entry');
    }
    final uri =
        Uri.https(_client.stack.endpoint, '$_urlPath/$_uid', assetParameter);
    return _client.sendRequest<T, K>(uri);
  }

  ///
  /// include the dimensions (height and width) of the image in the response.
  /// Supported image types: JPG, GIF, PNG, WebP, BMP, TIFF, SVG, and PSD.
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.asset(asset_uid)..includeDimension('development');
  /// asset.fetch<AssetModel, void>().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void includeDimension() {
    assetParameter['include_dimension'] = 'true';
  }

  ///
  /// Retrieve the published content of the fallback locale if an entry is not
  /// localized in specified locale.
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.asset(asset_uid)..includeFallback();
  /// asset.fetch<AssetModel, void>().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void includeFallback() {
    assetParameter['include_fallback'] = 'true';
  }

  ///
  /// Specify the version number of the asset that you wish to retrieve.
  /// If the version is not specified,
  /// the details of the latest version will be retrieved.
  /// To retrieve a specific version, keep the environment parameter blank.
  /// [version] required
  ///
  /// ```dart
  /// var stack = contentstack.Stack(apiKey, deliveryToken, environment);
  /// final asset = stack.asset(asset_uid)..version(2);
  /// asset.fetch<AssetModel, void>().then((response) {
  ///   print(response);
  /// }).catchError((error) {
  ///   print(error['error_code']);
  /// });
  void version(int version) {
    assetParameter['version'] = version.toString();
  }
}
