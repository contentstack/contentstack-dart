import 'package:contentstack/src/query.dart';
import 'package:super_enum/super_enum.dart';
part 'operator.g.dart';

@superEnum
enum _QueryOperator {
  @Data(fields: [DataField<List<Query>>('queryObjects')])
  And,
  @Data(fields: [DataField<List<Query>>('queryObjects')])
  Or
}
