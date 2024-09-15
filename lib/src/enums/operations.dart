import 'package:contentstack/src/enums/operations_type.dart';

// set the name to IncludeClass, as the name Include was conflicting with reference.dart enum in entry_queryable.dart
// it also has an element named Include
class QueryOperation {
  final QueryOperationType operationType;
  final dynamic value;

  QueryOperation(this.operationType, this.value);
}
