import 'package:super_enum/super_enum.dart';
part 'publishtype.g.dart';

@superEnum
enum _PublishType {
  @object
  AssetPublished,
  @object
  EntryPublished,
  @object
  AssetUnpublished,
  @object
  AssetDeleted,
  @object
  EntryUnpublished,
  @object
  EntryDeleted,
  @object
  ContentTypeDeleted,
}