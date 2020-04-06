import 'package:logging/logging.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

void main() {

  final Logger logger = Logger('Stack');

 // Get stack response 
 final stack = contentstack.Stack('apiKey','deliveryToken','environment');
 final response = stack.fetch();
 logger.fine(response);


 // Get Entry response
 final entry = stack.contentType('content_type_uid').entry(entryUid: 'entry_uid');
 logger.fine(entry);


 // Get asset response
 //final asset = stack.contentType('content_type_uid').asset()
 //logger.fine(asset);
}