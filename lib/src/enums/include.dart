import 'package:contentstack/src/enums/include_type.dart';

// ignore: lines_longer_than_80_chars
// set the name to IncludeClass, as the name Include was conflicting with reference.dart enum in entry_queryable.dart
// it also has an element named Include
class IncludeClass {
  final IncludeType includeType;
  final List<String> fieldUidList;

  IncludeClass(this.includeType, this.fieldUidList);
}
