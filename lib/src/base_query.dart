enum Where {
  equals,
  notEquals,
  includes,
  excludes,
  isLessThan,
  isLessThanOrEqual,
  isGreaterThan,
  isGreaterThanOrEqual,
  exists,
  matches
}

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
class BaseQuery {
  
  final Map<String, String> queryParameter = <String, String>{};
  final _parameter = <String, String>{};

  void where(Where type, String key, value) {
    if (type != null && key != null && key.isNotEmpty) {
      final operation = _operationKey(type);
      if (operation.isEmpty) {
        _parameter[key] = value;
      } else {
        final query = {operation: value.toString()};
        _parameter[key] = query.toString();
      }
      queryParameter['query'] = _parameter.toString();
    }
  }

  ///
  /// The number of objects to skip before returning any.
  /// [skipCount] No of objects to skip from returned objects
  /// you can chain this call using double dot.
  ///
  /// The skip parameter can be used for pagination, 
  /// skip specifies the number of objects to skip in the response.
  /// Example:
  ///
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.skip(2);
  ///
  void skip(int skipCount) {
    _parameter["skip"] = skipCount.toString();
    // this will be removed and place at the common place where url is created
    queryParameter['query'] = _parameter.toString();
  }

  ///
  /// A limit on the number of objects to return.
  /// [limitCount] No of objects to limit
  /// you can chain this call by using double dot
  /// The limit parameter can be used for pagination, limit specifies the number of objects to limit to in the response.
  ///
  /// Example:
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.limit(2);
  ///
  void limit(int limitCount) {
    _parameter["limit"] = limitCount.toString();
    queryParameter['query'] = _parameter.toString();
  }

  /// 
  /// Sort the results in ascending order with the given key.
  /// Sort the returned entries in ascending order of the provided key.
  /// [key] The key to order by.
  /// you can chain this call by using double dot
  /// 
  /// Example:
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.orderByAscending('ascendingByKey');
  /// 
  void orderByAscending(String key) {
    _parameter["asc"] = key.toString();
    queryParameter['query'] = _parameter.toString();
  }

  /// 
  /// Sort the results in descending order with the given key.
  /// Sort the returned entries in descending order of the provided key.
  /// [key] The key to order by.
  /// you can chain this call by using double dot 
  /// 
  /// Example:
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.orderByDecending('descendingByKey');
  /// 
  void orderByDecending(String key){
    _parameter["desc"] = key.toString();
    queryParameter['query'] = _parameter.toString();
  }

  /// 
  /// This method adds key and value to an Entry.
  /// [key] The key as string which needs to be added to the Query
  /// [value] The value as string which needs to be added to the Query
  /// 
  /// Example:
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.param('key', 'value');
  ///  
  void param(String key, String value){
    if(key !=null && value != null && key.isNotEmpty && value.isNotEmpty){
      _parameter[key] = value.toString();
    }
    queryParameter['query'] = _parameter.toString();
  }


  /// 
  /// This method adds key and value to an Entry.
  /// [parameters] The key and value pair that will be added to the Query
  /// 
  /// Example:
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.addParam({key: value, key1: value2});
  /// 
  void addParam(Map parameters){
    if(parameters !=null && parameters.isNotEmpty){
      _parameter.addAll(queryParameter);
    }
    queryParameter['query'] = _parameter.toString();
  }

  /// 
  /// Add a custom query against specified key.
  /// [key] key for the query
  /// [value] value for the query
  /// 
  /// Example:
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.addQuery("query_param_key", "query_param_value"); 
  /// 
  void query(String key, String value){
    if(key !=null && value != null && key.isNotEmpty && value.isNotEmpty){
      queryParameter[key] = value.toString();
    }
  }


  /// 
  /// Add a custom query against specified key.
  /// [parameters] The key and value pair that will be added to the Query
  /// 
  /// Example:
  /// final stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.addQuery("query_param_key", "query_param_value"); 
  /// 
  void addQuery(Map parameters){
    if(parameters !=null && parameters.isNotEmpty){
      queryParameter.addAll(queryParameter);
    }
  }



  String _operationKey(Where whereType) {
    switch (whereType) {
      case Where.equals:
        return '';
      case Where.notEquals:
        return "\$ne";
      case Where.includes:
        return '\$in';
      case Where.excludes:
        return '\$nin';
      case Where.isLessThan:
        return '\$lt';
      case Where.isLessThanOrEqual:
        return '\$lte';
      case Where.isGreaterThan:
        return '\$gt';
      case Where.isGreaterThanOrEqual:
        return '\$gte';
      case Where.exists:
        return '\$exists';
      case Where.matches:
        return '\$regex';
    }
    return null;
  }
}
