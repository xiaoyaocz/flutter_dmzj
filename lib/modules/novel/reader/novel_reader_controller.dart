import 'dart:async';
import 'dart:io';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/models/db/novel_download_info.dart';
import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';
import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:remixicon/remixicon.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class NovelReaderController extends BaseController {
  final int novelId;
  final String novelTitle;
  final String novelCover;
  final List<NovelDetailChapter> chapters;
  final FocusNode focusNode = FocusNode();
  NovelDetailChapter chapter;
  NovelReaderController({
    required this.novelId,
    required this.novelTitle,
    required this.novelCover,
    required this.chapters,
    required this.chapter,
  }) {
    chapterIndex.value = chapters.indexOf(chapter);
  }

  /// 当前章节索引
  var chapterIndex = 0.obs;

  /// 当前页面
  var currentIndex = 0.obs;

  /// 最大页面
  var maxPage = 0.obs;

  /// 阅读进度，百分比
  var progress = 0.0.obs;

  final AppSettingsService settings = AppSettingsService.instance;
  final NovelRequest request = NovelRequest();

  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  /// 电量信息监听
  StreamSubscription<BatteryState>? batterySubscription;

  /// 连接类型
  Rx<ConnectivityResult> connectivityType =
      Rx<ConnectivityResult>(ConnectivityResult.other);

  /// 电量信息
  Rx<int> batteryLevel = 0.obs;

  /// 显示电量
  RxBool showBattery = true.obs;

  /// 文本内容
  var content = "".obs;

  /// 是否是图片
  var isPicture = false.obs;

  /// 是否为本地缓存
  var isLocal = false;

  /// 图片列表
  RxList<String> pictures = RxList<String>();

  var contentLength = 0;

  /// 是否显示控制器
  var showControls = false.obs;

  /// 阅读方向
  var direction = 0.obs;

  /// 左手模式
  bool get leftHandMode => settings.novelReaderLeftHandMode.value;

  /// 翻页动画
  bool get pageAnimation => settings.novelReaderPageAnimation.value;

  @override
  void onInit() {
    initConnectivity();
    initBattery();
    direction.value = settings.novelReaderDirection.value;

    scrollController.addListener(listenVertical);
    setFull();

    loadContent();
    super.onInit();
  }

  /// 初始化电池信息
  void initBattery() async {
    try {
      var battery = Battery();
      batterySubscription =
          battery.onBatteryStateChanged.listen((BatteryState state) async {
        try {
          var level = await battery.batteryLevel;
          batteryLevel.value = level;
          showBattery.value = true;
        } catch (e) {
          showBattery.value = false;
        }
      });
      batteryLevel.value = await battery.batteryLevel;
      showBattery.value = true;
    } catch (e) {
      showBattery.value = false;
    }
  }

  /// 初始化连接状态
  void initConnectivity() async {
    var connectivity = Connectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      //提醒
      if (connectivityType.value != result &&
          result == ConnectivityResult.mobile) {
        SmartDialog.showToast("您已切换至数据网络，请注意流量消耗");
      }
      connectivityType.value = result;
    });
    connectivityType.value = await connectivity.checkConnectivity();
  }

  /// 监听竖向模式时滚动百分比
  void listenVertical() {
    if (scrollController.position.maxScrollExtent > 0) {
      progress.value = scrollController.position.pixels /
          scrollController.position.maxScrollExtent;
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(listenVertical);
    connectivitySubscription?.cancel();
    batterySubscription?.cancel();
    exitFull();
    uploadHistory();
    super.onClose();
  }

  /// 加载内容
  Future loadContent() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      content.value = "";
      currentIndex.value = 0;
      isLocal = false;
      chapter = chapters[chapterIndex.value];

      //查询本地是否存在
      var localInfo = NovelDownloadService.instance.box
          .get("${novelId}_${chapter.volumeId}_${chapter.chapterId}");
      if (localInfo != null && localInfo.status == DownloadStatus.complete) {
        return await loadFromLocal(localInfo);
      }

      var text = await request.novelContent(
        volumeId: chapter.volumeId,
        chapterId: chapter.chapterId,
      );

      contentLength = text.length;

      var subStr = text.substring(0, text.length < 200 ? text.length : 200);
      //检查是否是插画
      if (subStr.contains(RegExp('<img.*?>'))) {
        List<String> imgs = [];
        for (var item
            in RegExp(r'<img.*?src=[' '""](.*?)[' '""].*?>').allMatches(text)) {
          var src = item.group(1);
          if (src != null && src.isNotEmpty) {
            imgs.add(src);
          }
        }
        isPicture.value = true;

        pictures.value = imgs;

        content.value = text;
        maxPage.value = pictures.length;

        SmartDialog.showToast("双击插画可放大、保存哦~");
      } else {
        isPicture.value = false;

        text = HtmlUnescape().convert(text);
        text = text
            .replaceAll('\r\n', '\n')
            .replaceAll("<br/>", "\n")
            .replaceAll('<br />', "\n")
            .replaceAll('\n\n\n', "\n")
            .replaceAll('\n\n', "\n")
            .replaceAll('\n', "\n　　")
            .replaceAll(RegExp(r"　　\s+"), "　　");

        content.value = text;
      }
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
        progress.value = 0.0;
      }
      preloadContent();
      //TODO 阅读记录跳转
      //上传记录
      uploadHistory();
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }

    //SmartDialog.dismiss(status: SmartStatus.loading);
  }

  Future loadFromLocal(NovelDownloadInfo local) async {
    try {
      isLocal = true;
      var file = File(p.join(local.savePath, local.fileName));

      var text = await file.readAsString();

      //检查是否是插画
      if (local.isImage) {
        List<String> imgs =
            local.imageFiles.map((e) => p.join(local.savePath, e)).toList();

        isPicture.value = true;

        pictures.value = imgs;

        content.value = text;
        maxPage.value = pictures.length;

        SmartDialog.showToast("双击插画可放大、保存哦~");
      } else {
        isPicture.value = false;

        text = HtmlUnescape().convert(text);
        text = text
            .replaceAll('\r\n', '\n')
            .replaceAll("<br/>", "\n")
            .replaceAll('<br />', "\n")
            .replaceAll('\n\n\n', "\n")
            .replaceAll('\n\n', "\n")
            .replaceAll('\n', "\n　　")
            .replaceAll(RegExp(r"　　\s+"), "　　");

        content.value = text;
      }
      if (scrollController.hasClients) {
        scrollController.jumpTo(0);
        progress.value = 0.0;
      }
      preloadContent();
      //TODO 阅读记录跳转
      //上传记录
      uploadHistory();
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  /// 预加载下一话
  void preloadContent() async {
    try {
      if (chapterIndex.value == chapters.length - 1) {
        return;
      }
      var nextChapter = chapters[chapterIndex.value + 1];
      await request.novelContent(
        volumeId: nextChapter.volumeId,
        chapterId: nextChapter.chapterId,
      );
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 上传历史记录
  void uploadHistory() {
    var chapter = chapters[chapterIndex.value];
    UserService.instance.updateNovelHistory(
      novelId: novelId,
      chapterId: chapter.chapterId,
      //TODO 已读位置计算
      index: 0,
      total: contentLength,
      novelCover: novelCover,
      novelName: novelTitle,
      chapterName: chapter.chapterName,
      volumeId: chapter.volumeId,
      volumeName: chapter.volumeName,
    );
  }

  /// 下一章
  void nextChapter() {
    if (chapterIndex.value == chapters.length - 1) {
      SmartDialog.showToast("后面没有了");
      return;
    }

    chapterIndex.value += 1;
    loadContent();
  }

  /// 上一章
  void forwardChapter() {
    if (chapterIndex.value == 0) {
      SmartDialog.showToast("前面没有了");
      return;
    }

    chapterIndex.value -= 1;
    loadContent();
  }

  /// 下一页
  void nextPage() {
    if (direction.value == ReaderDirection.kUpToDown) {
      return;
    }
    var value = currentIndex.value;
    var max = maxPage.value;
    if (value >= max - 1) {
      nextChapter();
    } else {
      jumpToPage(value + 1, anime: true);
    }
  }

  /// 上一页
  void forwardPage() {
    if (direction.value == ReaderDirection.kUpToDown) {
      return;
    }
    var value = currentIndex.value;

    if (value == 0) {
      forwardChapter();
    } else {
      jumpToPage(value - 1, anime: true);
    }
  }

  /// 跳转页数
  void jumpToPage(int page, {bool anime = false}) {
    //竖向
    if (direction.value == ReaderDirection.kUpToDown) {
      final viewportHeight = scrollController.position.viewportDimension;
      scrollController.jumpTo(viewportHeight * page);
    } else {
      anime && pageAnimation
          ? pageController.animateToPage(page,
              duration: const Duration(milliseconds: 200), curve: Curves.linear)
          : pageController.jumpToPage(page);
    }
  }

  /// 显示设置
  void showSettings() {
    setShowControls();

    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      backgroundColor: AppStyle.darkTheme.scaffoldBackgroundColor,
      builder: (context) => Theme(
        data: AppStyle.darkTheme,
        child: Column(
          children: [
            ListTile(
              title: const Text("设置"),
              trailing: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.close),
              ),
              contentPadding: AppStyle.edgeInsetsL12,
            ),
            Expanded(
              child: Obx(
                () => ListView(
                  padding: AppStyle.edgeInsetsA12,
                  children: [
                    buildBGItem(
                      child: ListTile(
                        title: const Text("阅读方向"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildSelectedButton(
                              onTap: () {
                                setDirection(ReaderDirection.kLeftToRight);
                              },
                              selected: settings.novelReaderDirection.value ==
                                  ReaderDirection.kLeftToRight,
                              child: const Icon(Remix.arrow_right_line),
                            ),
                            AppStyle.hGap8,
                            buildSelectedButton(
                              onTap: () {
                                setDirection(ReaderDirection.kRightToLeft);
                              },
                              selected: settings.novelReaderDirection.value ==
                                  ReaderDirection.kRightToLeft,
                              child: const Icon(Remix.arrow_left_line),
                            ),
                            AppStyle.hGap8,
                            buildSelectedButton(
                              onTap: () {
                                setDirection(ReaderDirection.kUpToDown);
                              },
                              selected: settings.novelReaderDirection.value ==
                                  ReaderDirection.kUpToDown,
                              child: const Icon(Remix.arrow_down_line),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: SwitchListTile(
                        value: settings.novelReaderLeftHandMode.value,
                        onChanged: (e) {
                          settings.setNovelReaderLeftHandMode(e);
                        },
                        title: const Text("操作反转"),
                        subtitle: const Text("点击左侧下一页，右侧上一页"),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: SwitchListTile(
                        value: settings.novelReaderShowStatus.value,
                        onChanged: (e) {
                          settings.setNovelReaderShowStatus(e);
                        },
                        title: const Text("显示状态信息"),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: SwitchListTile(
                        value: settings.novelReaderPageAnimation.value,
                        onChanged: (e) {
                          settings.setNovelReaderPageAnimation(e);
                        },
                        title: const Text("翻页动画"),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: ListTile(
                        title: const Text("字体大小"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                settings.setNovelReaderFontSize(
                                  settings.novelReaderFontSize.value + 1,
                                );
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                            ),
                            AppStyle.hGap12,
                            Text("${settings.novelReaderFontSize.value}"),
                            AppStyle.hGap12,
                            OutlinedButton(
                              onPressed: () {
                                settings.setNovelReaderFontSize(
                                  settings.novelReaderFontSize.value - 1,
                                );
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: ListTile(
                        title: const Text("行距"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                settings.setNovelReaderLineSpacing(
                                  settings.novelReaderLineSpacing.value + 0.1,
                                );
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                            ),
                            AppStyle.hGap12,
                            Text((settings.novelReaderLineSpacing.value)
                                .toStringAsFixed(1)),
                            AppStyle.hGap12,
                            OutlinedButton(
                              onPressed: () {
                                settings.setNovelReaderLineSpacing(
                                  settings.novelReaderLineSpacing.value - 0.1,
                                );
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: ListTile(
                        title: const Text("阅读主题"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: AppColor.novelThemes.keys
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    settings.setNovelReaderTheme(e);
                                  },
                                  child: Container(
                                    margin: AppStyle.edgeInsetsL8,
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: AppColor.novelThemes[e]!.first,
                                      borderRadius: AppStyle.radius24,
                                    ),
                                    child: Visibility(
                                      visible: AppColor.novelThemes.keys
                                              .toList()
                                              .indexOf(e) ==
                                          settings.novelReaderTheme.value,
                                      child: Icon(
                                        Icons.check,
                                        color: AppColor.novelThemes[e]!.last,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 设置阅读方向
  void setDirection(int value) {
    settings.setNovelReaderDirection(value);
    direction.value = value;
  }

  Widget buildBGItem({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppStyle.radius8,
        color: AppStyle.darkTheme.cardColor,
      ),
      child: child,
    );
  }

  Widget buildSelectedButton(
      {required Widget child, bool selected = false, Function()? onTap}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: selected ? Colors.blue : Colors.grey,
        side: BorderSide(
          color: selected ? Colors.blue : Colors.grey,
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }

  /// 显示目录
  void showMenu() {
    setShowControls();
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      backgroundColor: AppStyle.darkTheme.scaffoldBackgroundColor,
      builder: (context) => Theme(
        data: AppStyle.darkTheme,
        child: Column(
          children: [
            ListTile(
              title: Text("目录(${chapters.length})"),
              trailing: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.close),
              ),
              contentPadding: AppStyle.edgeInsetsL12,
            ),
            Divider(
              height: 1.0,
              color: Colors.grey.withOpacity(.2),
            ),
            Expanded(
              child: ScrollablePositionedList.separated(
                initialScrollIndex: chapterIndex.value,
                itemCount: chapters.length,
                separatorBuilder: (_, i) => Divider(
                  indent: 12,
                  endIndent: 12,
                  height: 1.0,
                  color: Colors.grey.withOpacity(.2),
                ),
                itemBuilder: (_, i) {
                  var item = chapters[i];
                  return ListTile(
                    selected: i == chapterIndex.value,
                    title: Text(item.chapterName),
                    subtitle: Text(item.volumeName),
                    onTap: () {
                      chapterIndex.value = i;
                      loadContent();
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      routeSettings: const RouteSettings(name: "/modalBottomSheet"),
    );
  }

  /// 设置显示/隐藏控制按钮
  void setShowControls() {
    if (settings.novelReaderFullScreen.value) {
      if (showControls.value) {
        setFull();
      } else {
        setFullEdge();
      }
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      showControls.value = !showControls.value;
    });
  }

  /// 进入全屏
  void setFull() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  /// 进入全屏edgeToEdge模式
  void setFullEdge() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }

  /// 退出全屏
  void exitFull() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: SystemUiOverlay.values,
    );
  }

  void keyDown(LogicalKeyboardKey key) {
    if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.pageUp) {
      if (leftHandMode) {
        nextPage();
      } else {
        forwardPage();
      }
    } else if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.pageDown) {
      if (leftHandMode) {
        forwardPage();
      } else {
        nextPage();
      }
    }
  }
}
