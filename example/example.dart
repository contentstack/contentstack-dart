import 'package:logging/logging.dart';
import 'package:contentstack/contentstack.dart' as contentstack;

void main() {

  final Logger logger = Logger('Stack');

 /// Get stack response
 final stack = contentstack.Stack('apiKey','deliveryToken','environment');
 final stackResponse = stack.fetch();
 logger.fine(stackResponse);


 /// Get Entry response like below.
 final entry = stack.contentType('content_type_uid').entry(entryUid: 'entry_uid');
 final entryResponse = entry.fetch();
 logger.fine(entryResponse);


 /// Get asset response
 final query = stack.contentType('content_type_uid').entry().query();
 final queryResponse = query.find();
 logger.fine(queryResponse);


}