import 'package:contentstack/client.dart';

class Asset{
  final HttpClient client;
  final String uid;

  Asset(this.uid, {this.client});
}