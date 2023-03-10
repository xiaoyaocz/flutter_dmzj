import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final settings = AppSettingsService.instance;
  var imageCacheSize = "正在计算缓存...".obs;
  var novelCacheSize = "正在计算缓存...".obs;

  @override
  void onInit() {
    super.onInit();
    getImageCachedSize();
    getNovelCachedSize();
  }

  void getImageCachedSize() async {
    try {
      imageCacheSize.value = "正在计算缓存...";
      var bytes = await getCachedSizeBytes();
      imageCacheSize.value = "${(bytes / 1024 / 1024).toStringAsFixed(1)}MB";
    } catch (e) {
      imageCacheSize.value = "缓存计算失败";
    }
  }

  void getNovelCachedSize() async {
    try {
      novelCacheSize.value = "正在计算缓存...";
      var bytes = await LocalStorageService.instance.getNovelCacheSize();
      novelCacheSize.value = "${(bytes / 1024 / 1024).toStringAsFixed(1)}MB";
    } catch (e) {
      novelCacheSize.value = "缓存计算失败";
    }
  }

  void cleanImageCache() async {
    var result = await clearDiskCachedImages();
    if (!result) {
      SmartDialog.showToast("清除失败");
    }
    getImageCachedSize();
  }

  void cleanNovelCache() async {
    var result = await LocalStorageService.instance.cleanNovelCacheSize();
    if (!result) {
      SmartDialog.showToast("清除失败");
    }
    getNovelCachedSize();
  }

  void setDownloadComicTask() {
    Get.dialog(
      SimpleDialog(
        title: const Text("漫画最大任务数"),
        children: [0, 1, 2, 3, 4, 5]
            .map(
              (e) => RadioListTile<int>(
                title: Text(e == 0 ? "无限制" : "$e个"),
                value: e,
                groupValue: settings.downloadComicTaskCount.value,
                onChanged: (e) {
                  Get.back();
                  settings.setDownloadComicTaskCount(e ?? 0);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void setDownloadNovelTask() {
    Get.dialog(
      SimpleDialog(
        title: const Text("小说最大任务数"),
        children: [0, 1, 2, 3, 4, 5]
            .map(
              (e) => RadioListTile<int>(
                title: Text(e == 0 ? "无限制" : "$e个"),
                value: e,
                groupValue: settings.downloadNovelTaskCount.value,
                onChanged: (e) {
                  Get.back();
                  settings.setDownloadNovelTaskCount(e ?? 0);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
