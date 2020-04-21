import 'package:contentstack/src/include.dart';

class EntryQueryable {
  final Map<String, String> parameter = <String, String>{};

  ///
  /// [locale] is code of the language of which the entries needs to be included.
  /// Only the entries published in this locale will be fetched.
  ///
  /// Example:
  /// final stack = contentstack.Stack("apiKey", "deliveryToken", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.locale('en-eu');
  ///
  void locale(String locale) {
    parameter['locale'] = locale;
  }

  /// Specifies an array of only keys in BASE object that would be included in the response.
  /// [fieldUid] Array of the only reference keys to be included in response.
  /// [EntryQueryable] object, so you can chain this call.
  ///
  /// Example:
  /// final stack = contentstack.Stack("apiKey", "deliveryToken", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// fieldUid is String type of List
  /// entry.only(fieldUid);
  ///
  void only(List<String> fieldUid) {
    if (fieldUid != null && fieldUid.isNotEmpty) {
      final List referenceArray = [];
      for (final item in fieldUid) {
        referenceArray.add(item);
      }
      parameter["only[BASE][]"] = referenceArray.toString();
    }
  }

  ///
  /// Specifies list of field uids that would be excluded from the response.
  /// [fieldUid] field uid  which get excluded from the response.
  /// [EntryQueryable] object, so you can chain this call.
  ///
  /// Example:
  /// final stack = contentstack.Stack("apiKey", "deliveryToken", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// fieldUid is String type of List
  /// entry.except(fieldUid);
  ///
  void except(List<String> fieldUid) {
    if (fieldUid != null && fieldUid.isNotEmpty) {
      final List referenceArray = [];
      for (final item in fieldUid) {
        referenceArray.add(item);
      }
      parameter["except[BASE][]"] = referenceArray.toString();
    }
  }

  ///
  /// * Include Reference
  /// When you fetch an entry of a content type that has a reference field,
  /// by default, the content of the referred entry is not fetched.
  /// It only fetches the UID of the referred entry, along with the content of
  /// the specified entry.
  ///
  /// If you wish to fetch the content of the entry that is included in the reference field, you need to use the include[] parameter, and specify the UID of the reference field as value. This informs Contentstack that the request also includes fetching the entry used in the specified reference field.
  /// Add a constraint that requires a particular reference key details.
  /// [includeReference] provides three options, none, only and except
  /// i.e accepts list of fieldUid
  /// [referenceFieldUid] Key who has reference to some other class object.
  /// Array of the only reference keys to be included in response.
  ///
  /// Example 1: Reference type None
  ///
  /// final stack = contentstack.Stack("apiKey", "deliveryKey", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.includeReference("referenceFieldUid", IncludeReference.none(fieldUidList: null));
  /// await entry.fetch();
  ///
  /// Example 2: Reference type only
  ///
  /// final stack = contentstack.Stack("apiKey", "deliveryKey", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// final fieldUid = list of string type;
  /// entry.includeReference("referenceFieldUid", IncludeReference.only(fieldUidList: fieldUid));
  ///
  /// Example 3: Reference type except
  ///
  /// final stack = contentstack.Stack("apiKey", "deliveryKey", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.includeReference("referenceFieldUid", IncludeReference.except(fieldUidList: fieldUid));
  ///
  void includeReference(String referenceFieldUid,
  {Include includeReferenceField}) {
    if (referenceFieldUid != null && referenceFieldUid.isNotEmpty) {
      final List referenceArray = [];
      if (includeReferenceField != null) {
        includeReferenceField.when(none: (fieldUid) {
          referenceArray.add(referenceFieldUid);
          if (fieldUid.fieldUidList != null &&
              fieldUid.fieldUidList.isNotEmpty) {
            for (final item in fieldUid.fieldUidList) {
              referenceArray.add(item);
            }
          }
          parameter["include[]"] = referenceArray.toString();
        }, only: (fieldUid) {
          final Map<String, dynamic> referenceOnlyParam = <String, dynamic>{};
          if (fieldUid.fieldUidList != null &&
              fieldUid.fieldUidList.isNotEmpty) {
            for (final item in fieldUid.fieldUidList) {
              referenceArray.add(item);
            }
          }
          referenceOnlyParam[referenceFieldUid] = referenceArray;
          //_include(referenceFieldUid);
          includeReference(referenceFieldUid);
          parameter["only"] = referenceOnlyParam.toString();
        }, except: (fieldUid) {
          final Map<String, dynamic> referenceOnlyParam = <String, dynamic>{};
          if (fieldUid.fieldUidList != null &&
              fieldUid.fieldUidList.isNotEmpty) {
            for (final item in fieldUid.fieldUidList) {
              referenceArray.add(item);
            }
          }
          referenceOnlyParam[referenceFieldUid] = referenceArray;
          //_include(referenceFieldUid);
          includeReference(referenceFieldUid);
          parameter["except"] = referenceOnlyParam.toString();
        });
      }else{
        //referenceArray.add(referenceFieldUid);
        parameter["include[]"] = referenceFieldUid;
      }
    }
  }

  ///
  /// Include Content Type of all returned objects along with objects themselves.
  /// return, [EntryQueryable] so you can chain this call.
  ///
  /// Example:
  /// Stack stack = contentstack.stack("apiKey", "deliveryToken", "environment");
  /// final entry  = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.includeContentType();
  ///
  void includeContentType() {
    parameter["include_content_type"] = 'true';
    parameter["include_global_field_schema"] = 'true';
  }

  /// This method also includes the content type UIDs of the referenced entries returned in the response
  /// return [EntryQueryable] so you can chain this call
  ///
  /// Example:
  ///
  /// Stack stack = contentstack.stack("apiKey", "deliveryToken", "environment");
  /// final entry  = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.includeReferenceContentTypeUID();
  ///
  void includeReferenceContentTypeUID() {
    parameter['include_reference_content_type_uid'] = 'true';
  }

  ///
  /// This method adds key and value to an Entry.
  /// [key] The key as string which needs to be added to an Entry
  /// [value] The value as string which needs to be added to an Entry
  /// [EntryQueryable] object, so you can chain this call.
  ///
  /// Example:
  ///
  /// Stack stack = contentstack.stack("apiKey", "deliveryToken", "environment");
  /// final entry  = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.addParam(key, value);
  ///
  void addParam(String key, String value) {
    if (key != null && value != null && key.isNotEmpty && value.isNotEmpty) {
      parameter[key] = value;
    }
  }

  void _include(String referenceFieldUid) {
    final List referenceArray = [];
    if (referenceFieldUid != null && referenceFieldUid.isNotEmpty) {
      referenceArray.add(referenceFieldUid);
    }
    parameter["include[]"] = referenceArray.toString();
  }
}
