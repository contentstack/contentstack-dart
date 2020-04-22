import 'package:super_enum/super_enum.dart';
part 'filter.g.dart';
@superEnum
enum _Filter {
  //nearest, bilinear, bicubic, lanczos
  @object
  Nearest,
  @object
  Bilinear,
  @object
  Bicubic,
  @object
  Lanczos,
}
