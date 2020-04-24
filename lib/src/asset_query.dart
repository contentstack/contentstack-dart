import 'dart:async';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';

/// Assets refer to all the media files (images, videos, PDFs, audio files, and so on)
/// uploaded in your Contentstack repository for future use. These files can be
/// attached and used in multiple entries. Learn more about Assets.
/// https://www.contentstack.com/docs/content-managers/work-with-assets
///
/// * All Assets
/// This call fetches the list of all the assets of a particular stack
///
/// * Single Asset
/// This call fetches the latest version of a specific asset of a particular stack.
///
class AssetQuery extends BaseQuery {
  final HttpClient _client;
  String _urlPath;

  AssetQuery([this._client]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _urlPath = "/${_client.stack.apiVersion}/assets";
  }

  ///
  /// Enter the name of the [environment] if you wish to retrieve
  /// the assets published in a particular environment.
  /// [environment] required
  ///
  void environment(String environment) {
    queryParameter["environment"] = environment;
  }

  ///
  /// Specify the version number of the asset that you wish to retrieve.
  /// If the version is not specified, the details of the latest version will be retrieved.
  /// To retrieve a specific version, keep the environment parameter blank.
  /// [version] required
  ///
  void version(int version) {
    queryParameter["version"] = version.toString();
  }

  ///
  /// include the dimensions (height and width) of the image in the response.
  /// Supported image types: JPG, GIF, PNG, WebP, BMP, TIFF, SVG, and PSD.
  ///
  void includeDimension() {
    queryParameter["include_dimension"] = 'true';
  }

  ///
  /// include the relative URLs of the assets in the response.
  ///
  void relativeUrls() {
    queryParameter["relative_urls"] = 'true';
  }

  void includeCount() {
    queryParameter['include_count'] = 'true';
  }

  /// find is applicable for getting all the available assets based on the query
  Future<dynamic> find() async {
    final uri = Uri.https(_client.stack.endpoint, "$_urlPath", queryParameter);
    return _client.sendRequest(uri);
  }
}
