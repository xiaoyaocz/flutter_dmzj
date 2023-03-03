import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DBService extends GetxService {
  static DBService get instance => Get.find<DBService>();
  late Box newsLikeBox;

  Future init() async {
    newsLikeBox = await Hive.openBox("NewsLike");
  }
}
