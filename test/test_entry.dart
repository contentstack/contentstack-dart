import 'package:contentstack/contentstack.dart';
import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

void main(){

  group('Entry testcases', () {
    Entry entry;

    setUp(() async {
      final Stack stack = contentstack.Stack('blt12c8ad610ff4ddc2', 'blt43359585f471685188b2e1ba', 'env1');
      const String entryUID = "blt7801c5d40cbbe979";
       entry = stack.contentType('product').entry(entryUID);
    });

    test('find the entry response with locale', () async{
     final  response =  await entry.locale('en-us').fetch();
      expect("", response);
    });

    test('find the entry responsee with environment', () async {
      final  response =  await entry.environment('env').fetch();
      expect("", response);
    });

    test('find the entry response with version', () async {
      final  response =  await entry.version(2).fetch();
      expect("", response);
    });

  });
}