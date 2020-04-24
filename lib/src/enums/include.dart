import 'package:super_enum/super_enum.dart';
part 'include.g.dart';

@superEnum
enum _Include {
  @Data(fields: [DataField<List<String>>('fieldUidList')])
  None,
  @Data(fields: [DataField<List<String>>('fieldUidList')])
  Only,
  @Data(fields: [DataField<List<String>>('fieldUidList')])
  Except
}
