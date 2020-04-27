import 'package:contentstack/src/query.dart';
import 'package:super_enum/super_enum.dart';
part 'reference.g.dart';

@superEnum
enum _QueryReference {
  @Data(fields: [DataField<Query>('query')])
  Include,
  @Data(fields: [DataField<Query>('query')])
  NotInclude
}
