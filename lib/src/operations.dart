import 'package:super_enum/super_enum.dart';
part 'operations.g.dart';

@superEnum
enum _QueryOperation {
  @Data(fields: [DataField<dynamic>('value')])
  Equals,
  @Data(fields: [DataField<dynamic>('value')])
  NotEquals,
  @Data(fields: [DataField<List<dynamic>>('value')])
  Includes,
  @Data(fields: [DataField<List<dynamic>>('value')])
  Excludes,
  @Data(fields: [DataField<dynamic>('value')])
  IsLessThan,
  @Data(fields: [DataField<dynamic>('value')])
  IsLessThanOrEqual,
  @Data(fields: [DataField<dynamic>('value')])
  IsGreaterThan,
  @Data(fields: [DataField<dynamic>('value')])
  IsGreaterThanOrEqual,
  @Data(fields: [DataField<bool>('value')])
  Exists,
  @Data(fields: [DataField<String>('regex')])
  Matches,
}
