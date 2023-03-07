import 'package:flutter/material.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  var themeMode = 0.obs;

  @override
  void onInit() {
    themeMode.value = LocalStorageService.instance
        .getValue(LocalStorageService.kThemeMode, 0);

    comicReaderDirection.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicReaderDirection, 0);
    comicReaderFullScreen.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicReaderFullScreen, true);
    comicReaderShowStatus.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicReaderShowStatus, true);
    comicReaderShowStatus.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicReaderShowStatus, true);
    comicReaderShowViewPoint.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicReaderShowViewPoint, true);
    super.onInit();
  }

  void changeTheme() {
    Get.dialog(
      SimpleDialog(
        title: const Text("设置主题"),
        children: [
          RadioListTile<int>(
            title: const Text("跟随系统"),
            value: 0,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 0);
            },
          ),
          RadioListTile<int>(
            title: const Text("浅色模式"),
            value: 1,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 1);
            },
          ),
          RadioListTile<int>(
            title: const Text("深色模式"),
            value: 2,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 2);
            },
          ),
        ],
      ),
    );
  }

  void setTheme(int i) {
    themeMode.value = i;
    var mode = ThemeMode.values[i];

    LocalStorageService.instance.setValue(LocalStorageService.kThemeMode, i);
    Get.changeThemeMode(mode);
  }

  /// 漫画阅读方向
  /// * [0] 左右
  /// * [1] 上下
  /// * [2] 右左
  var comicReaderDirection = 0.obs;
  void setComicReaderDirection(int direction) {
    if (comicReaderDirection.value == direction) {
      return;
    }
    comicReaderDirection.value = direction;
    LocalStorageService.instance
        .setValue(LocalStorageService.kComicReaderDirection, direction);
  }

  /// 漫画全屏阅读
  RxBool comicReaderFullScreen = true.obs;
  void setComicReaderFullScreen(bool value) {
    comicReaderFullScreen.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kComicReaderFullScreen, value);
  }

  /// 漫画阅读显示状态信息
  RxBool comicReaderShowStatus = true.obs;
  void setComicReaderShowStatus(bool value) {
    comicReaderShowStatus.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kComicReaderShowStatus, value);
  }

  /// 漫画阅读尾页显示观点/吐槽
  RxBool comicReaderShowViewPoint = true.obs;
  void setComicReaderShowViewPoint(bool value) {
    comicReaderShowViewPoint.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kComicReaderShowViewPoint, value);
  }
}
