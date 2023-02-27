import 'package:flutter/material.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  var themeMode = 0.obs;

  @override
  void onInit() {
    themeMode.value = LocalStorageService.instance
        .getValue(LocalStorageService.kThemeMode, 0);

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
}
