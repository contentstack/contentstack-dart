import 'package:contentstack/client.dart';

const SDK_VERSION = '0.5.0';
const SDK_NAME = 'contentstack-dart';
const CONTENT_TYPE = 'Content-Type';
const CONTENT_TYPE_VALUE = 'application/json';
const X_USER_AGENT = 'X-User-Agent';
const X_USER_AGENT_VALUE = '$SDK_NAME-v$SDK_VERSION';
const TIMEOUT = 30;

void ifLivePreviewEnable(HttpClient _client) {
  final dictLivePreview = _client.stack!.livePreview;
  const String AUTH = 'authorization';
  if (dictLivePreview!.containsKey('enable')) {
    _client.stack!.removeHeader('access_token');
    _client.stack!.removeHeader('environment');
    _client.stack!.setHeader(AUTH, _client.stack!.livePreview![AUTH]);
    _client.stack!.setHost(dictLivePreview['host']);
    final String errMessage = '''Invalid content_type_uid! Make sure you have 
          provided same content_type_uid 
          livePreviewQuery parameter in stack class''';
    if (!dictLivePreview.containsKey('content_type_uid')) {
      throw ArgumentError.value(errMessage);
    }
  }
}
