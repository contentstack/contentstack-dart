import 'dart:async';
import 'dart:convert';

import 'package:contentstack/client.dart';
import 'package:contentstack/constant.dart';
import 'package:contentstack/src/base_query.dart';
import 'package:contentstack/src/enums/include.dart';
import 'package:contentstack/src/enums/include_type.dart';
import 'package:contentstack/src/enums/operator.dart';
import 'package:contentstack/src/enums/operator_type.dart';
import 'package:contentstack/src/enums/reference.dart';
import 'package:contentstack/src/enums/reference_type.dart';

/// Contentstack provides certain queries that you
/// can use to fetch filtered results.
/// You can use queries for Entries and Assets API requests.
/// Learn more about [Query](https://www.contentstack.com/docs/developers/apis/content-delivery-api/#queries)
class Query extends BaseQuery {
  final HttpClient _client;
  final String? _contentTypeUid;
  late String _path;

  Query([this._client, this._contentTypeUid]) {
    queryParameter['environment'] = _client.stackHeaders['environment'];
    _path =
        '/${_client.stack!.apiVersion}/content_types/$_contentTypeUid/entries';
  }

  ///
  /// This method adds key and value to an Entry.
  /// [key] The key as string which needs to be added to an Entry
  /// [value] The value as string which needs to be added to an Entry
  /// [Query] object, so you can chain this call.
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// entry.addParam(key, value);
  /// ```
  ///
  void addParam(String key, String value) {
    if (key != null && value != null && key.isNotEmpty && value.isNotEmpty) {
      queryParameter[key] = value.toString();
    }
  }

  ///
  /// Specifies list of field uids that would be excluded from the response.
  /// [fieldUid] field uid  which get excluded from the response.
  /// [Query] object, so you can chain this call.
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// fieldUid is String type of List
  /// query.except(fieldUid);
  /// ```
  ///
  void except(List<String> fieldUid) {
    if (fieldUid != null && fieldUid.isNotEmpty) {
      final List referenceArray = [];
      for (final item in fieldUid) {
        referenceArray.add(item);
      }
      queryParameter['except[BASE][]'] = referenceArray.toString();
    }
  }

  Future<T?> find<T, K>() async {
    getQueryUrl();

    final preview = _client.stack!.livePreview;
    if (preview != null && preview.isNotEmpty) {
      __validateLivePreview(preview);
    }
    final uri = Uri.https(_client.stack!.endpoint!, _path, queryParameter);
    return _client.sendRequest<T, K>(uri);
  }

  void __validateLivePreview(preview) {
    if (preview != null && preview['enable']) {
      ifLivePreviewEnable(_client);
      if (_contentTypeUid == preview['content_type_uid']) {
        parameter['live_preview'] = 'init';
        if (preview.containsKey('live_preview') &&
            preview['live_preview'].toString().isNotEmpty) {
          parameter['live_preview'] = preview['live_preview'];
        }
      }
    }
  }

  Map getQueryUrl() {
    if (parameter != null && parameter.isNotEmpty) {
      final stringify = json.encode(parameter);
      queryParameter['query'] = stringify.toString();
      return queryParameter;
    }
    return queryParameter;
  }

  ///
  /// Include Content Type of all returned objects along with objects
  /// themselves. return, [Query] so you can chain this call.
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// query.includeContentType();
  /// ```
  ///
  void includeContentType() {
    queryParameter['include_content_type'] = 'true';
    queryParameter['include_global_field_schema'] = 'true';
  }

  ///
  /// Retrieve the published content of the fallback locale if an entry is not
  /// localized in specified locale.
  ///
  /// Example
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// entry.includeFallback()
  /// ```
  ///
  void includeFallback() {
    queryParameter['include_fallback'] = true.toString();
  }

  ///
  /// includeEmbeddedItems instance of Query
  /// Include Embedded Objects (Entries and Assets) along with entry/entries details
  ///
  /// Example:
  /// ```
  /// final stack = contentstack.Stack('apiKey', 'deliveryKey', 'environment');
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// query = query.includeEmbeddedItems()
  /// ```
  ///
  void includeEmbeddedItems() {
    queryParameter['include_embedded_items[]'] = 'BASE';
  }

  //
  //  Entry Queryable functions:
  ///
  /// * Include Reference
  /// When you fetch an entry of a content type that has a reference field,
  /// by default, the content of the referred entry is not fetched.
  /// It only fetches the UID of the referred entry, along with the content of
  /// the specified entry.
  ///
  /// If you wish to fetch the content of the entry that is included in
  /// the reference field, you need to use the include[] parameter,
  /// and specify the UID of the reference field as value.
  /// This informs Contentstack that the request also includes
  /// fetching the entry used in the specified reference field.
  /// Add a constraint that requires a particular reference key details.
  /// [includeReference] provides three options, none, only and except
  /// i.e accepts list of fieldUid
  /// [referenceFieldUid] Key who has reference to some other class object.
  /// Array of the only reference keys to be included in response.
  ///
  /// {Example 1}: Reference type None
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// query.includeReference("referenceFieldUid",
  ///       IncludeReference.none(fieldUidList: null));
  /// await entry.fetch();
  /// ```
  ///
  /// {Example 2}: Reference type only
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// final fieldUid = list of string type;
  /// query.includeReference("referenceFieldUid",
  ///       IncludeReference.only(fieldUidList: fieldUid));
  /// ```
  ///
  /// {Example 3}: Reference type except
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// query.includeReference("referenceFieldUid",
  ///       IncludeReference.except(fieldUidList: fieldUid));
  /// ```
  ///
  void includeReference(String referenceFieldUid,
      {IncludeClass? includeReferenceField}) {
    if (referenceFieldUid != null && referenceFieldUid.isNotEmpty) {
      final List referenceArray = [];
      if (includeReferenceField != null) {

        switch(includeReferenceField.includeType) {
          case IncludeType.None:
            referenceArray.add(referenceFieldUid);
            if (includeReferenceField.fieldUidList != null &&
                includeReferenceField.fieldUidList.isNotEmpty) {
              for (final item in includeReferenceField.fieldUidList) {
                referenceArray.add(item);
              }
            }
            queryParameter['include[]'] = referenceArray.toString();
            break;
          case IncludeType.Only:
            final Map<String, dynamic> referenceOnlyParam = <String, dynamic>{};
            if (includeReferenceField.fieldUidList != null &&
                includeReferenceField.fieldUidList.isNotEmpty) {
              for (final item in includeReferenceField.fieldUidList) {
                referenceArray.add(item);
              }
            }
            referenceOnlyParam[referenceFieldUid] = referenceArray;
            //_include(referenceFieldUid);
            includeReference(referenceFieldUid);
            queryParameter['only'] = referenceOnlyParam.toString();
            break;
          case IncludeType.Except:
            final Map<String, dynamic> referenceOnlyParam = <String, dynamic>{};
            if (includeReferenceField.fieldUidList != null &&
                includeReferenceField.fieldUidList.isNotEmpty) {
              for (final item in includeReferenceField.fieldUidList) {
                referenceArray.add(item);
              }
            }
            referenceOnlyParam[referenceFieldUid] = referenceArray;
            //_include(referenceFieldUid);
            includeReference(referenceFieldUid);
            queryParameter['except'] = referenceOnlyParam.toString();
            break;
        }
      } else {
        queryParameter['include[]'] = referenceFieldUid;
      }
    }
  }

  /// This method also includes the content type
  /// UIDs of the referenced entries returned in the response
  /// return [Query] so you can chain this call
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// query.includeReferenceContentTypeUID();
  /// ```
  ///
  void includeReferenceContentTypeUID() {
    queryParameter['include_reference_content_type_uid'] = 'true';
  }

  ///
  /// [locale] is code of the language of which the
  /// entries needs to be included.
  /// Only the entries published in this locale will be fetched.
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// query.locale('en-eu');
  /// ```
  ///
  void locale(String locale) {
    queryParameter['locale'] = locale;
  }

  /////////////////////////////////////////////////
  //-------------[Entry Queryable]---------------//
  /////////////////////////////////////////////////

  /// Specifies an array of only keys in BASE object
  /// that would be included in the response.
  /// [fieldUid] Array of the only reference keys to be included in response.
  /// [Query] object, so you can chain this call.
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final query = stack.contentType("contentTypeUid").entry().query();
  /// fieldUid is String type of List
  /// query.only(fieldUid);
  /// ```
  ///
  void only(List<String> fieldUid) {
    if (fieldUid != null && fieldUid.isNotEmpty) {
      final List<String> referenceArray = [];
      for (final item in fieldUid) {
        referenceArray.add(item);
      }
      queryParameter['only[BASE][]'] = referenceArray.toString();
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
  /// * {Example}: operator OR
  ///
  /// ```dart
  /// final stackInstance1 = Credential.stack();
  /// final queryBase1 = stackInstance1.contentType('room').entry().query();
  /// queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));
  /// ```
  /// ```dart
  /// final stackInstance2 = Credential.stack();
  /// final queryBase2 = stackInstance2.contentType('room').entry().query();
  /// queryBase2.where('attendee', QueryOperation.equals(value: 20));
  /// ```
  /// ```dart
  /// final List<contentstack.Query> listOfQuery = [queryBase1, queryBase2];
  /// query.operator(QueryOperator.or(queryObjects: listOfQuery));
  /// await query.find().then((response){
  ///    print(response.toString());
  /// }).catchError((onError){
  ///    print(onError);
  /// });
  /// ```
  ///
  /// * {Example}: And Operator:
  ///
  /// ```dart
  /// final stackInstance1 = Credential.stack();
  /// final queryBase1 = stackInstance1.contentType('room').entry().query();
  /// queryBase1.where('title', QueryOperation.equals(value: 'Room 13'));
  /// ```
  ///
  /// ```dart
  /// final stackInstance2 = Credential.stack();
  /// final queryBase2 = stackInstance2.contentType('room').entry().query();
  /// queryBase2.where('attendee', QueryOperation.equals(value: 20));
  /// ```
  /// ```dart
  /// final List<contentstack.Query> listOfQuery = [queryBase1, queryBase2];
  /// query.operator(QueryOperator.and(queryObjects: listOfQuery));
  /// await query.find().then((response){
  ///    print(response.toString());
  /// }).catchError((onError){
  ///    print(onError);
  /// });
  /// ```
  ///
  void operator(QueryOperator operator) {
    switch(operator.operatorType) {
      case QueryOperatorType.And:
        final List<Query> queryList =
          operator.queryObjects; //and.queryObjects is list of Query Objects
        if (queryList.isNotEmpty) {
          final emptyList = [];
          for (final item in queryList) {
            emptyList.add(item.parameter);
          }
          parameter['\$and'] = emptyList;
        }
        break;
      case QueryOperatorType.Or:
        final List<Query> queryList =
          operator.queryObjects; //and.queryObjects is list of Query Objects
        if (queryList.isNotEmpty) {
          final emptyList = [];
          for (final item in queryList) {
            emptyList.add(item.parameter);
          }
          parameter['\$or'] = emptyList;
        }
        break;
    }
  }

  ///
  /// Remove header key
  /// [key] custom header key
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final query = stack.contentType('content_type_uid').entry().query();
  /// query.removeHeader('key');
  /// ```
  ///
  void removeHeader(String key) {
    if (_client.stackHeaders.containsKey(key)) {
      _client.stackHeaders.remove(key);
    }
  }

  ///
  /// To set headers for Built.io Contentstack rest calls.
  /// Scope is limited to this object and followed classes.
  /// [key] header name.
  /// [value] header value against given header name.
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey','deliveryToken','environment');
  /// final query = stack.contentType('content_type_uid').entry().query();
  /// query.setHeader('key', 'value');
  /// ```
  ///
  void setHeader(String key, String value) {
    if (key.isNotEmpty && value.isNotEmpty) {
      _client.stackHeaders[key] = value;
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
  /// all entries that does not satisfy query conditions
  /// made on referenced fields.
  ///
  /// * [referenceUid] is Reference field
  /// * [reference] It accepts Enum type
  /// QueryReference.include() OR QueryReference.NotInclude()
  /// and it accepts instance of Query
  /// Example:
  ///
  /// ```dart
  /// final query = stack.contentType('room').entry().query();
  /// query.referenceSearch('fieldUid', QueryReference.include(query: query));
  /// await query.find().then((response){
  ///    print(response);
  /// });
  /// ```
  ///
  void whereReference(String referenceUid, QueryReference reference) {
    if (referenceUid != null && referenceUid.isNotEmpty) {
      switch(reference.referenceType) {
        case QueryReferenceType.Include:
          parameter[referenceUid] = {'\$in_query': reference.query.parameter};
          break;
        case QueryReferenceType.NotInclude:
          parameter[referenceUid] = {
            '\$nin_query': reference.query.parameter
          };
          break;
      }
    }
  }

  /// includes branch in the response
  ///
  /// Example:
  ///
  /// ```dart
  /// final stack = contentstack.Stack('apiKey, 'deliveryKey, 'environment);
  /// final query = stack.contentType('contentTypeUid').entry().query();
  /// query.includeBranch();
  /// ```
  ///
  void includeBranch() {
    queryParameter['include_branch'] = true.toString();
  }
}
