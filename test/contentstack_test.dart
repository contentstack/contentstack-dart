import 'package:flutter_test/flutter_test.dart';
import 'package:contentstack/contentstack.dart';

void main() {

  String apiKEY = 'blt920bb7e90248f607'; // comment while pushing live repo
  String accessToken = 'blt0c4300391e033d4a59eb2857'; // comment while pushing live repo
  String environment = 'production'; // comment while pushing live repo
  String contentTYPE = 'news';
  String entryUID = 'blt62aa462c55dd3380';
  String assetUID = 'blt43343798495785';

  Stack stack = Contentstack.stack(apiKey: apiKEY, accessToken: accessToken, environment: environment);

//  for functional testing
//  test('checks API_Key instance', () {
//    expect(API_Key, stack.config.apiKey);
//  });
//  test('checks AccessToken instance', () {
//    expect(ACCESS_TOKEN, stack.config.accessToken);
//  });
//  test('checks ENV instance', () {
//    expect(ENV, stack.config.environment);
//  });
//  test('checks protocol instance', () {
//    expect('https', stack.config.protocol);
//  });
//  test('checks protocol instance', () {
//    expect('https', stack.config.protocol);
//  });
//  test('checks region of API', () {
//    Config config = stack.config;
//    expect('us', config.region);
//  });
//  test('checks region of API', () {
//    Config config = stack.config;
//    expect('https://cdn.contentstack.io/v3/', config);
//  });

  test('get Single Entry By UID', () async {
    //stack.config.setRegion(region: 'eu');
    Entry entry = stack.contentType(contentTYPE).entry(uid: entryUID);
    var resp = await entry.fetch();
    print(resp);
    expect('Dhoni to play charitable golf event in US', resp['entry']['title']);
  });



  test("checks entry Future.value() returns the value", () async {
    Entry entry = stack.contentType(contentTYPE).entry(uid: entryUID).locale(locale: 'es-us').version(version: 2);
    var response = await entry.fetch();
    print(response);
    expect('', response);
  });



  test('get All Entries', () async {
    Entry entry = stack.contentType(contentTYPE).entry();
    Map<String, String> mapQueryParam = new Map();
    mapQueryParam['locale'] = 'en-us';
    var resp = await entry.find(mapQueryParam);
    //print(resp['entries']);
    expect(false, resp['entries'] is Map);
  });


  test('checks asset instance', () {
    Asset asset = stack.asset(uid: assetUID);
    expect(null, asset.fetch());
  });


  test('checks all asset instance', () {
    Asset assets = stack.asset();
    var result = assets.fetch();
    expect(null, result);
  });


  test('checks response instance', () {
    Entry entry = stack.contentType(contentTYPE).entry(uid: entryUID);
    expect(null, entry.fetch());
  });

}
