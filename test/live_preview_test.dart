import 'package:contentstack/contentstack.dart';
import 'package:dotenv/dotenv.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  final logger = Logger(printer: PrettyPrinter());

  load();
  final apiKey = env['apiKey']!;
  final deliveryToken = env['deliveryToken']!;
  final environment = env['environment']!;
  final fakeManagementToken = deliveryToken;
  const editTags = 'editTagsType';

  final Map<String, dynamic> livePreview = {
    'authorization': fakeManagementToken,
    'enable': true,
    'host': 'live.contentstack.com',
    'include_edit_tags': true,
    'edit_tags_type': editTags,
  };

  final Stack stack =
      Stack(apiKey, deliveryToken, environment, livePreview: livePreview);
  logger.i('live_preview credentials loaded..');

  test('test if live preview arguments are empty', () {
    expect(5, stack.getLivePreview!.length);
    expect(true, stack.getLivePreview!.containsKey('enable'));
    expect(fakeManagementToken, stack.getLivePreview!['authorization']);
    expect('live.contentstack.com', stack.getLivePreview!['host']);
  });

  test('test if live preview argument enable true provided', () {
    final Map<String, dynamic> livePreviewEnabled = {
      'host': 'host.contentstack.com',
      'enable': true,
      'authorization': 'managementToken@1234',
    };
    final stack = Stack('_apiKey123456', '_deliveryToken654321', '_env',
        livePreview: livePreviewEnabled);
    expect(3, stack.getLivePreview!.length);
    expect(true, stack.getLivePreview!.containsKey('enable'));
  });

  test('test if live preview argument authorization provided', () {
    final Map<String, dynamic> livePreviewEnabled = {
      'authorization': 'management_token_12345',
      'enable': true,
      'host': 'api.contentstack.io',
    };
    final stack = Stack('_apiKey123456', '_deliveryToken654321', '_env',
        livePreview: livePreviewEnabled);
    expect(3, stack.getLivePreview!.length);
    expect(true, stack.getLivePreview!.containsKey('authorization'));
    expect('management_token_12345', stack.getLivePreview!['authorization']);
  });

  test('test if live preview host provided', () {
    final Map<String, dynamic> livePreviewAuthorization = {
      'host': 'host.contentstack.com',
      'enable': true,
      'authorization': 'managementToken@1234',
    };
    final stack = Stack('_apiKey1234', '_deliveryToken4321', '_env',
        livePreview: livePreviewAuthorization);
    expect(3, stack.getLivePreview!.length);
    expect(true, stack.getLivePreview!.containsKey('host'));
    expect('host.contentstack.com', stack.getLivePreview!['host']);
  });

  test('test if live preview entry complete call', () {
    final Map<String, dynamic> livePreviewDict = {
      'enable': true,
      'authorization': 'auth09090783478478',
      'host': 'live-preview.contentstack.com',
    };
    final stack = Stack(
      '_apiKey123456',
      '_deliveryToken654321',
      '_env',
      livePreview: livePreviewDict,
    )..livePreviewQuery({
        'content_type_uid': 'liveContentType',
        'live_preview': 'hash_code',
      });

    stack
        .contentType('liveContentType')
        .entry(entryUid: 'bold_entry_uid')
        .fetch()
        .then(print)
        .onError((dynamic error, stackTrace) => print(error.toString()));

    expect(5, stack.getLivePreview!.length);
    expect('liveContentType', stack.getLivePreview!['content_type_uid']);
    expect('hash_code', stack.getLivePreview!['live_preview']);
    expect('auth09090783478478', stack.getLivePreview!['authorization']);
  });

  test('test if live preview entry call check when hash is not provided', () {
    final Map<String, dynamic> livePreviewDict = {
      'enable': true,
      'authorization': 'auth09090783478478',
      'host': 'live-preview.contentstack.com',
    };
    final stack = Stack(
      '_apiKey123456',
      '_deliveryToken654321',
      '_env',
      livePreview: livePreviewDict,
    )..livePreviewQuery({
        'content_type_uid': 'liveContentType',
      });

    stack
        .contentType('liveContentType')
        .entry(entryUid: 'bold_entry_uid')
        .fetch()
        .then(print)
        .onError((dynamic error, stackTrace) => print(error.toString()));

    expect('liveContentType', stack.getLivePreview!['content_type_uid']);
    expect('init', stack.getLivePreview!['live_preview']);
    expect('auth09090783478478', stack.getLivePreview!['authorization']);
  });
}
