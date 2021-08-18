import 'package:contentstack/contentstack.dart';
import 'package:super_enum/super_enum.dart';
import 'package:test/test.dart';

void main() {
  // live preview option container
  final Map<String, dynamic> livePreview = {
    'authorization': 'management_token_12345',
    'enable': true,
    'host': 'live.contentstack.com',
    'include_edit_tags': true,
    'edit_tags_type': object,
  };
  test('test if live preview arguments are empty', () {
    final stack = Stack('_apiKey123456', '_deliveryToken654321', '_env',
        livePreview: livePreview);
    expect(5, stack.getLivePreview.length);
    expect(true, stack.getLivePreview.containsKey('enable'));
    expect('management_token_12345', stack.getLivePreview['authorization']);
    expect('live.contentstack.com', stack.getLivePreview['host']);
  });

  test('test if live preview argument enable true provided', () {
    final Map<String, dynamic> livePreviewEnabled = {
      'enable': true,
    };
    final stack = Stack('_apiKey123456', '_deliveryToken654321', '_env',
        livePreview: livePreviewEnabled);
    expect(1, stack.getLivePreview.length);
    expect(true, stack.getLivePreview.containsKey('enable'));
  });

  test('test if live preview argument authorization provided', () {
    final Map<String, dynamic> livePreviewEnabled = {
      'authorization': 'management_token_12345',
    };
    final stack = Stack('_apiKey123456', '_deliveryToken654321', '_env',
        livePreview: livePreviewEnabled);
    expect(1, stack.getLivePreview.length);
    expect(true, stack.getLivePreview.containsKey('authorization'));
    expect('management_token_12345', stack.getLivePreview['authorization']);
  });

  test('test if live preview host provided', () {
    final Map<String, dynamic> livePreviewAuthorization = {
      'host': 'host.contentstack.com',
    };
    final stack = Stack('_apiKey1234', '_deliveryToken4321', '_env',
        livePreview: livePreviewAuthorization);
    expect(1, stack.getLivePreview.length);
    expect(true, stack.getLivePreview.containsKey('host'));
    expect('host.contentstack.com', stack.getLivePreview['host']);
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
        'hash': 'hash_code',
      });

    stack
        .contentType('liveContentType')
        .entry(entryUid: 'bold_entry_uid')
        .fetch()
        .then(print)
        .onError((error, stackTrace) => print(error.toString()));

    expect(5, stack.getLivePreview.length);
    expect('liveContentType', stack.getLivePreview['content_type_uid']);
    expect('hash_code', stack.getLivePreview['hash']);
    expect('auth09090783478478', stack.getLivePreview['authorization']);
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
        .onError((error, stackTrace) => print(error.toString()));

    expect('liveContentType', stack.getLivePreview['content_type_uid']);
    expect('init', stack.getLivePreview['hash']);
    expect('auth09090783478478', stack.getLivePreview['authorization']);
  });
}
