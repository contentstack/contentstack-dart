import 'dart:async';
import 'dart:convert';
import 'package:contentstack/client.dart';
import 'package:contentstack/src/base_query.dart';
import 'package:contentstack/src/enums/operator.dart';
import 'package:contentstack/src/enums/reference.dart';

class Query extends BaseQuery {
  final HttpClient _client;
  final String _contentTypeUid;
  String _path;

  Query([this._client, this._contentTypeUid]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _path =
        "/${_client.stack.apiVersion}/content_types/$_contentTypeUid/entries";
  }

  Map getQueryUrl() {
    if (parameter != null && parameter.isNotEmpty) {
      final stringify = json.encode(parameter);
      queryParameter["query"] = stringify.toString();
      return queryParameter;
    }
    return queryParameter;
  }

  Future find() async {
    getQueryUrl();
    final uri = Uri.https(_client.stack.endpoint, "$_path", queryParameter);
    return _client.sendRequest(uri);
  }

  ///
  /// To set headers for Built.io Contentstack rest calls.
  /// Scope is limited to this object and followed classes.
  /// [key] header name.
  /// [value] header value against given header name.
  /// Example:
  /// final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
  /// final query = stack.contentType('content_type_uid').entry().query();
  /// query.setHeader('key', 'value');
  ///
  void setHeader(String key, String value) {
    if (key.isNotEmpty && value.isNotEmpty) {
      _client.stackHeaders[key] = value;
    }
  }

  ///
  /// Remove header key
  /// [key] custom header key
  ///
  /// Example:
  /// final stack = contentstack.Stack('apiKey', 'deliveryToken', 'environment');
  /// final query = stack.contentType('content_type_uid').entry().query();
  /// query.removeHeader('key');
  ///
  void removeHeader(String key) {
    if (_client.stackHeaders.containsKey(key)) {
      _client.stackHeaders.remove(key);
    }
  }

  ///
  /// * Reference Search Equals:
  /// Get entries having values based on referenced fields.
  /// This query retrieves all entries that satisfy the query
  /// conditions made on referenced fields.
  ///
  /// * Reference Search Not-equals:
  /// Get entries having values based on referenced fields.
  /// This query works the opposite of $in_query and retrieves
  /// all entries that does not satisfy query conditions made on referenced fields.
  ///
  /// * [referenceUid] is Reference field
  /// * [reference] It accepts Enum type
  /// QueryReference.include() OR QueryReference.NotInclude()
  /// and it accepts instance of Query
  /// Example:
  ///
  /// final query = stack.contentType('room').entry().query();
  /// query.referenceSearch('fieldUid', QueryReference.include(query: query));
  ///   await query.find().then((response){
  ///       print(response);
  ///   });
  ///
  void whereReference(String referenceUid, QueryReference reference) {
    if (referenceUid != null && referenceUid.isNotEmpty) {
      reference.when(include: (queryInstance) {
        parameter[referenceUid] = {"\$in_query": queryInstance.query.parameter};
      }, notInclude: (queryInstance) {
        parameter[referenceUid] = {
          "\$nin_query": queryInstance.query.parameter
        };
      });
    }
  }

  ///
  /// * AND Operator
  /// Get entries that satisfy all the conditions provided in the '$and' query.
  ///
  /// * OR Operator
  /// Get all entries that satisfy at least one of the given conditions provided
  /// in the '$or' query.
  ///
  /// Example:
  /// * operator OR
  ///
  /// test('test operator OR in Query', () async {
  ///
  ///      final stackInstance1 = Credential.stack();
  ///      final queryBase1 = stackInstance1.contentType('room').entry().query();
  ///      queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));
  ///
  ///      final stackInstance2 = Credential.stack();
  ///      final queryBase2 = stackInstance2.contentType('room').entry().query();
  ///      queryBase2.where('attendee', QueryOperation.equals(value: 20));
  ///
  ///      final List<contentstack.Query> listOfQuery = [queryBase1, queryBase2];
  ///      query.operator(QueryOperator.or(queryObjects: listOfQuery));
  ///      await query.find().then((response){
  ///        logger.fine(response);
  ///        final completeUrl = query.getQueryUrl()['query'];
  ///        print(response.toString());
  ///      }).catchError((onError){
  ///        print(onError);
  ///      });
  ///    });
  ///
  ///
  /// Example:
  ///
  /// * And Operator:
  /// test('test operator And in Query', () async {
  ///      final stackInstance1 = Credential.stack();
  ///      final queryBase1 = stackInstance1.contentType('room').entry().query();
  ///      queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));
  ///
  ///      final stackInstance2 = Credential.stack();
  ///      final queryBase2 = stackInstance2.contentType('room').entry().query();
  ///      queryBase2.where('attendee', QueryOperation.equals(value: 20));
  ///
  ///      final List<contentstack.Query> listOfQuery = [queryBase1, queryBase2];
  ///      query.operator(QueryOperator.and(queryObjects: listOfQuery));
  ///      await query.find().then((response){
  ///        logger.fine(response);
  ///        final completeUrl = query.getQueryUrl()['query'];
  ///        print(response.toString());
  ///      }).catchError((onError){
  ///        print(onError);
  ///      });
  ///    });
  ///
  void operator(QueryOperator operator) {
    operator.when(and: (and) {
      final List<Query> queryList =
          and.queryObjects; //and.queryObjects is list of Query Objects
      if (queryList.isNotEmpty) {
        final emptyList = [];
        for (final item in queryList) {
          emptyList.add(item.parameter);
        }
        parameter["\$and"] = emptyList;
      }
    }, or: (or) {
      final List<Query> queryList =
          or.queryObjects; //and.queryObjects is list of Query Objects
      if (queryList.isNotEmpty) {
        final emptyList = [];
        for (final item in queryList) {
          emptyList.add(item.parameter);
        }
        parameter["\$or"] = emptyList;
      }
    });
  }
}
