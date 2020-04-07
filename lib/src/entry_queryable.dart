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
  EntryQueryable locale(String locale) {
    parameter['locale'] = locale;
    return this;
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
  EntryQueryable only(List<String> fieldUid) {
    if (fieldUid != null && fieldUid.isNotEmpty) {
      final List referenceArray = [];
      for (final item in fieldUid) {
        referenceArray.add(item);
      }

      parameter["only[BASE][]"] = referenceArray.toString();
    }

    return this;
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
  EntryQueryable except(List<String> fieldUid) {
    if (fieldUid != null && fieldUid.isNotEmpty) {
      final List referenceArray = [];
      for (final item in fieldUid) {
        referenceArray.add(item);
      }

      parameter["except[BASE][]"] = referenceArray.toString();
    }

    return this;
  }

  ///
  /// Add a constraint that requires a particular reference key details.
  /// [includeType] provides three options, none, only and except
  /// [referenceFieldUid] Key who has reference to some other class object.
  /// [EntryQueryable] object, so you can chain this call.
  /// [fieldUid] is compulsory when includeType for the only & except.
  /// Array of the only reference keys to be included in response.
  /// OR
  /// Array of the except reference keys to be excluded in response.
  ///
  /// Example 1:
  ///
  /// final stack = contentstack.Stack("apiKey", "deliveryKey", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.includeReference(includeType.none, "referenceFieldUid");
  ///
  /// Example 2:
  ///
  /// final stack = contentstack.Stack("apiKey", "deliveryKey", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// final fieldUid = list of string type;
  /// entry.includeReference(includeType.only, "referenceFieldUid", fieldUid);
  ///
  /// Example 3:
  ///
  /// final stack = contentstack.Stack("apiKey", "deliveryKey", "environment");
  /// final entry = stack.contentType("contentTypeUid").entry("entryUid");
  /// entry.includeReference(includeType.except, "referenceFieldUid", fieldUid);
  ///
  EntryQueryable includeReference(
      IncludeType includeType, String referenceFieldUid,
      [List<String> fieldUid]) {
    
    final List referenceArray = [];

    if (_includeTypeToString(includeType) == 'none') {
      if (referenceFieldUid != null && referenceFieldUid.isNotEmpty) {
        referenceArray.add(referenceFieldUid);
      }

      if (fieldUid != null && fieldUid.isNotEmpty) {
        for (final item in fieldUid) {
          referenceArray.add(item);
        }
      }
      parameter["include[]"] = referenceArray.toString();
    }

    if (_includeTypeToString(includeType) == 'only') {
      final Map<String, dynamic> referenceOnlyParam = <String, dynamic>{};
      if (fieldUid != null && fieldUid.isNotEmpty) {
        for (final item in fieldUid) {
          referenceArray.add(item);
        }

        referenceOnlyParam[referenceFieldUid] = referenceArray;
        includeReference(IncludeType.none, referenceFieldUid);
        parameter["only"] = referenceOnlyParam.toString();
      }
    }

    if (_includeTypeToString(includeType) == 'except') {
      final Map<String, dynamic> referenceExceptParam = <String, dynamic>{};
      if (fieldUid != null && fieldUid.isNotEmpty) {
        for (final item in fieldUid) {
          referenceArray.add(item);
        }

        referenceExceptParam[referenceFieldUid] = referenceArray;
        includeReference(IncludeType.none, referenceFieldUid);
        parameter["except"] = referenceExceptParam.toString();
      }
    }

    return this;
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
  EntryQueryable includeContentType() {
    parameter["include_content_type"] = 'true';
    parameter["include_global_field_schema"] = 'true';
    return this;
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
  EntryQueryable includeReferenceContentTypeUID() {
    parameter['include_reference_content_type_uid'] = 'true';
    return this;
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
  EntryQueryable addParam(String key, String value) {
    if (key != null && value != null && key.isNotEmpty && value.isNotEmpty) {
      parameter[key] = value;
    }

    return this;
  }

  String _includeTypeToString(IncludeType include) {
    switch (include) {
      case IncludeType.none:
        return 'none';
      case IncludeType.only:
        return 'only';
      case IncludeType.except:
        return 'except';
    }

    return null;
  }
}

// can't take default as it is reserved keyword
// consider none as default
enum IncludeType { none, only, except }
