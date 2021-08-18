import 'package:contentstack/client.dart';

const SDK_VERSION = '0.3.0';
const SDK_NAME = 'contentstack-dart';
const CONTENT_TYPE = 'Content-Type';
const CONTENT_TYPE_VALUE = 'application/json';
const X_USER_AGENT = 'X-User-Agent';
const X_USER_AGENT_VALUE = '$SDK_NAME-v$SDK_VERSION';
const TIMEOUT = 30;

void ifLivePreviewEnable(HttpClient _client) {
  final dictLivePreview = _client.stack.livePreview;
  if (dictLivePreview.containsKey('enable') &&
      dictLivePreview['enable'] &&
      dictLivePreview.containsKey('authorization')) {
    _client.stack.removeHeader('access_token');
    _client.stack.removeHeader('environment');
    _client.stack
        .setHeader('authorization', _client.stack.livePreview['authorization']);

    if (dictLivePreview.containsKey('host')) {
      _client.stack.setHost(dictLivePreview['host']);
    }
    if (dictLivePreview.containsKey('hash')) {
      if (dictLivePreview['hash'].toString().isEmpty) {
        _client.stack.setHeader('hash', 'init');
      } else {
        _client.stack.setHeader('hash', dictLivePreview['hash']);
      }
    }

    final String errMessage = '''Invalid content_type_uid! Make sure you have 
          provided same content_type_uid 
          livePreviewQuery parameter in stack class''';
    if (!dictLivePreview.containsKey('content_type_uid')) {
      throw ArgumentError.value(errMessage);
    }
  }
}
