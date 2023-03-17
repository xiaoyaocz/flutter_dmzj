import 'package:get/get.dart';
import 'package:hive/hive.dart';
part 'local_favorite.g.dart';

@HiveType(typeId: 6)
class LocalFavorite {
  LocalFavorite({
    required this.id,
    required this.objId,
    required this.title,
    required this.cover,
    required this.type,
    required this.updateTime,
  });

  @HiveField(0)
  String id;

  String get hiveId => "${type}_$objId";

  @HiveField(1)
  int objId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String cover;

  /// 类型，对应app_constant，漫画或小说
  @HiveField(4)
  int type;

  @HiveField(5)
  DateTime updateTime;

  //是否被选中
  Rx<bool> isChecked = false.obs;
}
