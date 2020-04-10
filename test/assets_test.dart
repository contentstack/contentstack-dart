import 'package:test/test.dart';
import 'package:contentstack/contentstack.dart' as contentstack;
import 'credentials.dart';

void main(){

  group('test the functional implementation', (){

    contentstack.Stack stack;

    setUp((){
    stack = Credential.stack();
    });

    test("test description", (){
      stack.asset(uid: Credential.assetUid);
    });

  });



  group('test the API implementation', (){

  });

}