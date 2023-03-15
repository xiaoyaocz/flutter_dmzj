import 'package:flutter/material.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';
import 'package:get/get.dart';

class AppSettingsService extends GetxController {
  static AppSettingsService get instance => Get.find<AppSettingsService>();
  var themeMode = 0.obs;
  var firstRun = false;
  @override
  void onInit() {
    themeMode.value = LocalStorageService.instance
        .getValue(LocalStorageService.kThemeMode, 0);
    firstRun = LocalStorageService.instance
        .getValue(LocalStorageService.kFirstRun, true);
    //漫画
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
    comicReaderLeftHandMode.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicReaderLeftHandMode, false);
    comicReaderHD.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicReaderHD, false);
    //小说
    novelReaderDirection.value = LocalStorageService.instance
        .getValue(LocalStorageService.kNovelReaderDirection, 0);
    novelReaderFontSize.value = LocalStorageService.instance
        .getValue(LocalStorageService.kNovelReaderFontSize, 16);
    novelReaderLineSpacing.value = LocalStorageService.instance
        .getValue(LocalStorageService.kNovelReaderLineSpacing, 1.5);
    novelReaderTheme.value = LocalStorageService.instance
        .getValue(LocalStorageService.kNovelReaderTheme, 0);
    novelReaderFullScreen.value = LocalStorageService.instance
        .getValue(LocalStorageService.kNovelReaderFullScreen, true);
    novelReaderShowStatus.value = LocalStorageService.instance
        .getValue(LocalStorageService.kNovelReaderShowStatus, true);
    novelReaderLeftHandMode.value = LocalStorageService.instance
        .getValue(LocalStorageService.kNovelReaderLeftHandMode, false);
    //下载
    downloadAllowCellular.value = LocalStorageService.instance
        .getValue(LocalStorageService.kDownloadAllowCellular, true);
    downloadComicTaskCount.value = LocalStorageService.instance
        .getValue(LocalStorageService.kDownloadComicTaskCount, 5);
    downloadNovelTaskCount.value = LocalStorageService.instance
        .getValue(LocalStorageService.kDownloadNovelTaskCount, 5);
    //搜索API
    comicSearchUseWebApi.value = LocalStorageService.instance
        .getValue(LocalStorageService.kComicSearchUseWebApi, false);
    //字体大小
    useSystemFontSize.value = LocalStorageService.instance
        .getValue(LocalStorageService.kUseSystemFontSize, false);
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

  /// 小说阅读方向
  /// * [0] 左右
  /// * [1] 上下
  /// * [2] 右左
  var novelReaderDirection = 0.obs;
  void setNovelReaderDirection(int direction) {
    if (novelReaderDirection.value == direction) {
      return;
    }
    novelReaderDirection.value = direction;
    LocalStorageService.instance
        .setValue(LocalStorageService.kNovelReaderDirection, direction);
  }

  /// 小说字体
  var novelReaderFontSize = 16.obs;
  void setNovelReaderFontSize(int size) {
    if (size < 5) {
      size = 5;
    }
    //应该没人需要这么大的字体吧...
    if (size > 56) {
      size = 56;
    }
    novelReaderFontSize.value = size;
    LocalStorageService.instance
        .setValue(LocalStorageService.kNovelReaderFontSize, size);
  }

  /// 小说行距
  var novelReaderLineSpacing = 1.5.obs;
  void setNovelReaderLineSpacing(double spacing) {
    if (spacing < 1) {
      spacing = 1;
    }
    //应该没人需要这么大的字体吧...
    if (spacing > 5) {
      spacing = 5;
    }
    novelReaderLineSpacing.value = spacing;
    LocalStorageService.instance
        .setValue(LocalStorageService.kNovelReaderLineSpacing, spacing);
  }

  /// 小说阅读主题
  var novelReaderTheme = 0.obs;
  void setNovelReaderTheme(int theme) {
    novelReaderTheme.value = theme;
    LocalStorageService.instance
        .setValue(LocalStorageService.kNovelReaderTheme, theme);
  }

  /// 漫画全屏阅读
  RxBool novelReaderFullScreen = true.obs;
  void setNovelReaderFullScreen(bool value) {
    novelReaderFullScreen.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kNovelReaderFullScreen, value);
  }

  /// 漫画阅读显示状态信息
  RxBool novelReaderShowStatus = true.obs;
  void setNovelReaderShowStatus(bool value) {
    novelReaderShowStatus.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kNovelReaderShowStatus, value);
  }

  /// 下载是否允许使用流量
  RxBool downloadAllowCellular = true.obs;
  void setDownloadAllowCellular(bool value) {
    downloadAllowCellular.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kDownloadAllowCellular, value);
  }

  /// 下载漫画最大任务数
  var downloadComicTaskCount = 5.obs;
  void setDownloadComicTaskCount(int task) {
    downloadComicTaskCount.value = task;
    LocalStorageService.instance
        .setValue(LocalStorageService.kDownloadComicTaskCount, task);
  }

  /// 下载漫画最大任务数
  var downloadNovelTaskCount = 5.obs;
  void setDownloadNovelTaskCount(int task) {
    downloadNovelTaskCount.value = task;
    LocalStorageService.instance
        .setValue(LocalStorageService.kDownloadNovelTaskCount, task);
  }

  /// 漫画搜索使用Web接口
  var comicSearchUseWebApi = false.obs;
  void setComicSearchUseWebApi(bool e) {
    comicSearchUseWebApi.value = e;
    LocalStorageService.instance
        .setValue(LocalStorageService.kComicSearchUseWebApi, e);
  }

  /// 显示字体大小跟随系统
  var useSystemFontSize = false.obs;
  void setUseSystemFontSize(bool e) {
    useSystemFontSize.value = e;
    LocalStorageService.instance
        .setValue(LocalStorageService.kUseSystemFontSize, e);
  }

  /// 漫画阅读左手模式
  RxBool comicReaderLeftHandMode = false.obs;
  void setComicReaderLeftHandMode(bool value) {
    comicReaderLeftHandMode.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kComicReaderLeftHandMode, value);
  }

  /// 小说阅读左手模式
  RxBool novelReaderLeftHandMode = false.obs;
  void setNovelReaderLeftHandMode(bool value) {
    novelReaderLeftHandMode.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kNovelReaderLeftHandMode, value);
  }

  /// 漫画阅读优先加载高清图
  RxBool comicReaderHD = false.obs;
  void setComicReaderHD(bool value) {
    comicReaderHD.value = value;
    LocalStorageService.instance
        .setValue(LocalStorageService.kComicReaderHD, value);
  }

  void setNoFirstRun() {
    LocalStorageService.instance.setValue(LocalStorageService.kFirstRun, false);
  }
}
