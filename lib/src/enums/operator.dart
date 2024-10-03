import 'package:contentstack/src/query.dart';
import 'package:contentstack/src/enums/operator_type.dart';

class QueryOperator {
  final QueryOperatorType operatorType;
  final List<Query> queryObjects;

  QueryOperator(this.operatorType, this.queryObjects);
}
