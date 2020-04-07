import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';
import 'package:contentstack/src/base_query.dart';

/// 
/// Assets refer to all the media files (images, videos, PDFs, audio files, and so on) 
/// uploaded in your Contentstack repository for future use. These files can be 
/// attached and used in multiple entries. Learn more about Assets.
/// https://www.contentstack.com/docs/content-managers/work-with-assets
///
/// All Assets
/// This call fetches the list of all the assets of a particular stack
/// 
/// Single Asset
/// This call fetches the latest version of a specific asset of a particular stack.
/// 

class Asset extends BaseQuery {
  final HttpClient _client;
  final String _uid;
  String _urlPath;

  Asset(this._uid, [this._client]) {
    parameter['environment'] = _client.stackHeaders['environment'];
    if (_uid != null && _uid.isNotEmpty) {
      _urlPath = "/${_client.stack.apiVersion}/assets";
    }
  }

  /// Enter the name of the [environment] if you wish to retrieve
  /// the assets published in a particular environment.
  /// [environment] required
  Asset environment(String environment) {
    parameter["environment"] = environment;
    return this;
  }

  /// Specify the version number of the asset that you wish to retrieve.
  /// If the version is not specified, the details of the latest version will be retrieved.
  /// To retrieve a specific version, keep the environment parameter blank.
  /// [version] required
  Asset version(String version) {
    parameter["version"] = version;
    return this;
  }

  /// include the dimensions (height and width) of the image in the response.
  /// Supported image types: JPG, GIF, PNG, WebP, BMP, TIFF, SVG, and PSD.
  Asset includeDimension() {
    parameter["include_dimension"] = 'true';
    return this;
  }

  /// include the relative URLs of the assets in the response.
  Asset relativeUrls() {
    parameter["relative_urls"] = 'true';
    return this;
  }

  /// It fetch single asset data.
  Future fetch() async {
    if (_uid == null) {
      throwException('Provide asset uid to fetch single entry');
    }
    //https://cdn.contentstack.io/v3/content_types/product/entries/entry_uid?version=4&environment=production&locale=en-us
    final uri =
    Uri.https(_client.stack.endpoint, "$_urlPath/$_uid", parameter);
    return _client.sendRequest(uri.toString());
  }

  /// find is applicable for querying the asset data.
  Future find() async {
    //https://cdn.contentstack.io/v3/content_types/product/entries?environment=production&locale=en-us
    final uri =
    Uri.https(_client.stack.endpoint, "/$_urlPath", parameter);
    return _client.sendRequest(uri.toString());
  }


}
