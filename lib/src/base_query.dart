class BaseQuery{

  /// 
  /// This is base Query class that contains common 
  /// functions to query in Entry, Assets and  content_type
  ///
  /// Example:
  /// 
  /// final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
  /// final query = stack.contentType('content_type_uid').query();
  /// query.addParams('key', 'value');
  /// final response = query.find();
  /// 
  final Map<String, String> parameter = <String, String>{};



}