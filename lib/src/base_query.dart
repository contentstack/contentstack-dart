import 'package:contentstack/src/enums/operations.dart';
import 'package:contentstack/src/enums/operations_type.dart';

///
/// This is base Query class that contains common
/// functions to query in Entry, Assets and content_type
/// common query for asset & entry
class BaseQuery {
  final Map<String, String?> queryParameter = <String, String?>{};
  final Map<String, dynamic> parameter = <String, dynamic>{};

  ///
  /// This method adds key and value to an Entry.
  /// [parameters] The key and value pair that will be added to the Query
  ///
  /// Example:
  /// ```dart
  /// var stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// var query = stack.contentType("contentTypeUid").entry().query();
  /// query.addParam({key: value, key1: value2});
  /// ```
  ///
  void addParams(Map parameters) {
    if (parameters != null && parameters.isNotEmpty) {
      parameters.forEach((key, value) {
        queryParameter[key] = value;
      });
    }
  }

  ///
  /// Add a custom query against specified key.
  /// [parameters] The key and value pair that will be added to the Query
  ///
  /// Example:
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.addQuery("query_param_key", "query_param_value");
  /// ```
  ///
  void addQuery(Map parameters) {
    if (parameters != null && parameters.isNotEmpty) {
      parameters.forEach((key, value) {
        parameter[key] = value;
      });
    }
  }

  ///
  /// A limit on the number of objects to return.
  /// [limitCount] No of objects to limit
  /// you can chain this call by using double dot
  /// The limit parameter can be used for pagination,
  /// limit specifies the number of objects to limit to in the response.
  ///
  /// Example:
  /// ```dart
  /// var stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// var query = stack.contentType("contentTypeUid").entry().query();
  /// query.limit(2);
  /// ```
  ///
  void limit(int limitCount) {
    queryParameter['limit'] = limitCount.toString();
  }

  ///
  /// Sort the results in ascending order with the given key.
  /// Sort the returned entries in ascending order of the provided key.
  /// [key] The key to order by.
  /// you can chain this call by using double dot
  ///
  /// Example:
  /// ```dart
  /// var stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// var query = stack.contentType("contentTypeUid").entry().query();
  /// query.orderByAscending('ascendingByKey');
  /// ```
  ///
  void orderByAscending(String key) {
    queryParameter['asc'] = key.toString();
  }

  ///
  /// Sort the results in descending order with the given key.
  /// Sort the returned entries in descending order of the provided key.
  /// [key] The key to order by.
  /// you can chain this call by using double dot
  ///
  /// Example:
  /// ```dart
  /// var stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// var query = stack.contentType("contentTypeUid").entry().query();
  /// query.orderByDecending('descendingByKey');
  /// ```
  ///
  void orderByDescending(String key) {
    queryParameter['desc'] = key.toString();
  }

  ///
  /// This method adds key and value to an Entry.
  /// [key] The key as string which needs to be added to the Query
  /// [value] The value as string which needs to be added to the Query
  ///
  /// Example:
  ///
  /// ```dart
  /// var stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.param('key', 'value');
  /// ```
  ///
  void param(String key, String value) {
    if (key != null && value != null && key.isNotEmpty && value.isNotEmpty) {
      queryParameter[key] = value.toString();
    }
  }

  ///
  /// Add a custom query against specified key.
  /// [key] key for the query
  /// [value] value for the query
  ///
  /// Example:
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.addQuery("query_param_key", "query_param_value");
  /// ```
  ///
  void query(String key, String value) {
    if (key != null && value != null && key.isNotEmpty && value.isNotEmpty) {
      parameter[key] = value.toString();
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
  /// ```dart
  /// var stack = contentstack.Stack( "apiKey", "deliveryToken", "environment");
  /// var query = stack.contentType("contentTypeUid").entry().query();
  /// query.skip(2);
  /// ```
  ///
  void skip(int skipCount) {
    queryParameter['skip'] = skipCount.toString();
  }

  void where(String fieldUid, QueryOperation queryOperation) {
    if (fieldUid != null && fieldUid.isNotEmpty) {
      switch(queryOperation.operationType) {
        case QueryOperationType.Equals:
          parameter[fieldUid] = queryOperation.value;
          break;
        case QueryOperationType.NotEquals:
          parameter[fieldUid] = {'\$ne': queryOperation.value};
          break;
        case QueryOperationType.Includes:
          parameter[fieldUid] = {'\$in': queryOperation.value};
          break;
        case QueryOperationType.Excludes:
          parameter[fieldUid] = {'\$nin': queryOperation.value};
          break;
        case QueryOperationType.IsLessThan:
          parameter[fieldUid] = {'\$lt': queryOperation.value};
          break;
        case QueryOperationType.IsLessThanOrEqual:
          parameter[fieldUid] = {'\$lte': queryOperation.value};
          break;
        case QueryOperationType.IsGreaterThan:
          parameter[fieldUid] = {'\$gt': queryOperation.value};
          break;
        case QueryOperationType.IsGreaterThanOrEqual:
          parameter[fieldUid] = {'\$gte': queryOperation.value};
          break;
        case QueryOperationType.Exists:
          parameter[fieldUid] = {'\$exists': queryOperation.value};
          break;
        case QueryOperationType.Matches:
          parameter[fieldUid] = {'\$regex': queryOperation.value};
          break;
      }
    }
  }
}
