import 'package:contentstack/src/enums/reference_type.dart';
import 'package:contentstack/src/query.dart';

class QueryReference {
  final QueryReferenceType referenceType;
  final Query query;

  QueryReference(this.referenceType, this.query);
}
