import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:contentstack/client.dart';

class Entry{

  final String uid;
  final HttpClient client;
  Map<String, String> queryParameter = <String,String>{};

  Entry(this.uid, {this.client});

  Entry locale(String locale){
    if (locale == null) {
      throw ArgumentError.notNull('locale could not be null');
    }
    queryParameter['locale'] = locale;
    return this;
  }

  Entry version(int version){

    if (version == null) {
      throw ArgumentError.notNull('version could not be null');
    }
    queryParameter['version'] = version.toString();
    return this;
  }

  // Now call find that returns the passing model result
  Future find() async{
    // initialise the client and pass the instance
    //log(queryParameter.toString())
  }


  Uri _uri(String path, {Map<String, dynamic> params}) => Uri(
    scheme: 'https',
    host: '',
    path: 'v3/stack/$path',
    queryParameters: params,
  );


  Future<T> fetchEntry<T extends Entry>(
      String id,
      T Function(Map<String, dynamic>) fromJson, {
        Map<String, dynamic> params,
      }) async {
    final response = await client.get(_uri('/entries/$id', params: params));
    if (response.statusCode != 200) {
      throw Exception('getEntry failed');
    }
    return null;

  }


}