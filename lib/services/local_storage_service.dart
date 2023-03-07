import 'package:flutter_dmzj/app/log.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LocalStorageService extends GetxService {
  static LocalStorageService get instance => Get.find<LocalStorageService>();

  static bool kDebug = false;

  /// 显示模式
  /// * [0] 跟随系统
  /// * [1] 浅色模式
  /// * [2] 深色模式
  static const String kThemeMode = "ThemeMode";

  /// 用户登录信息
  /// * 类型：LoginResultModel
  static const String kUserAuthInfo = "UserAuthInfo";

  /// 漫画阅读方向
  static const String kComicReaderDirection = "ComicReaderDirection";

  /// 漫画全屏阅读
  static const String kComicReaderFullScreen = "ComicReaderFullScreen";

  /// 漫画阅读显示状态信息
  static const String kComicReaderShowStatus = "ComicReaderShowStatus";

  /// 漫画阅读尾页显示观点/吐槽
  static const String kComicReaderShowViewPoint = "ComicReaderShowViewPoint";

  late Box settingsBox;
  Future init() async {
    settingsBox = await Hive.openBox(
      "LocalStorage",
    );
  }

  T getValue<T>(dynamic key, T defaultValue) {
    var value = settingsBox.get(key, defaultValue: defaultValue) as T;
    Log.d("Get LocalStorage：$key\r\n$value");
    return value;
  }

  Future setValue<T>(dynamic key, T value) async {
    Log.d("Set LocalStorage：$key\r\n$value");
    return await settingsBox.put(key, value);
  }

  Future removeValue<T>(dynamic key) async {
    Log.d("Remove LocalStorage：$key");
    return await settingsBox.delete(key);
  }

  bool get isFirst => getValue("First", true);

  void setNoFirst() {
    setValue("First", false);
  }
}
