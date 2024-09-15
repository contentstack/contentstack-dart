import 'package:contentstack/src/enums/operations_type.dart';

class QueryOperation {
  final QueryOperationType operationType;
  final dynamic value;

  QueryOperation(this.operationType, this.value);
}
