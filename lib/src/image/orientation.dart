import 'package:super_enum/super_enum.dart';
part 'orientation.g.dart';

@superEnum
enum _Orientation {
  @object ToDefault,
  @object Horizontally,
  @object HorizontallyAndVertically,
  @object Vertically,
  @object HorizontallyAndRotate90DegreeLeft,
  @object Degrees90TowardsRight,
  @object HorizontallyAndRotate90DegreesRight,
  @object Rotate90DegreesLeft,
}
