import 'dart:async';
import 'package:contentstack/client.dart';

/// This call fetches the latest version of a specific asset of a particular stack.
/// Read more about
/// Learn more about [Assets](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#get-a-single-asset).
class Asset {
  final HttpClient _client;
  final String _uid;
  String _urlPath;
  final Map<String, String> assetParameter = <String, String>{};

  /// * [_uid] assetUid:
  /// Enter the unique ID of the asset of which you wish to retrieve
  /// the details. {Example: blt19c34e5374418484}
  Asset(this._uid, [this._client]) {
    assetParameter['environment'] = _client.stackHeaders['environment'];
    _urlPath = '/${_client.stack.apiVersion}/assets';
  }

  ///
  /// Enter the name of the [environment] if you wish to retrieve
  /// the assets published in a particular environment.
  /// [environment] required
  ///
  void environment(String environment) {
    assetParameter['environment'] = environment;
  }


  ///
  /// Specify the version number of the asset that you wish to retrieve.
  /// If the version is not specified, the details of the latest version will be retrieved.
  /// To retrieve a specific version, keep the environment parameter blank.
  /// [version] required
  ///
  void version(int version) {
    assetParameter['version'] = version.toString();
  }

  ///
  /// include the dimensions (height and width) of the image in the response.
  /// Supported image types: JPG, GIF, PNG, WebP, BMP, TIFF, SVG, and PSD.
  ///
  void includeDimension() {
    assetParameter['include_dimension'] = 'true';
  }


  /// It fetch single asset data on the basis of the asset uid.
  Future<T> fetch<T, K>() {
    if (_uid == null || _uid.isEmpty) {throw Exception('Provide asset uid to fetch single entry');}
    final uri = Uri.https(_client.stack.endpoint, '$_urlPath/$_uid', assetParameter);
    return _client.sendRequest<T, K>(uri);
  }

}
