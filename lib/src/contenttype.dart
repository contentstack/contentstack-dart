import 'package:contentstack/client.dart';
import 'package:contentstack/contentstack.dart';


class ContentType{

  final String uid;
  final HttpClient client;
  Map<String, String> queryParameter = <String,String>{};

  ContentType(this.uid, {this.client});

  Entry entry(String uid){
    if(uid == null || uid.isEmpty) {
      throw ArgumentError('Invalid UID Requested');
    }
    return Entry(uid, client: client);
  }


  Query query() {
    return Query(client);
  }

  void fetch() {


  }



}