import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/controller/app_settings_controller.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/chapter_info.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/comic/view_point_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:remixicon/remixicon.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderController extends BaseController {
  final int comicId;
  final String comicTitle;
  final String comicCover;
  final ComicDetailChapterItem chapter;
  final List<ComicDetailChapterItem> chapters;
  final ComicRequest request = ComicRequest();
  ComicReaderController({
    required this.comicId,
    required this.comicTitle,
    required this.chapters,
    required this.chapter,
    required this.comicCover,
  }) {
    chapterIndex.value = chapters.indexOf(chapter);
  }

  /// APP设置控制器
  final settings = Get.find<AppSettingsController>();

  /// 预加载控制器
  final PreloadPageController preloadPageController = PreloadPageController();

  /// 上下模式控制器
  final ItemScrollController itemScrollController = ItemScrollController();

  /// 监听上下滚动
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  /// 章节详情
  Rx<ComicChapterDetail> detail =
      Rx<ComicChapterDetail>(ComicChapterDetail.empty());

  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  /// 电量信息监听
  StreamSubscription<BatteryState>? batterySubscription;

  /// 当处于放大图片时，锁定滑动手势
  var lockSwipe = false.obs;

  /// 当前章节索引
  var chapterIndex = 0.obs;

  /// 当前页面
  var currentIndex = 0.obs;

  /// 初始化
  var initialIndex = 0;

  /// 是否显示控制器
  var showControls = false.obs;

  /// 阅读方向
  var direction = 0.obs;

  /// 观点、吐槽
  RxList<ComicViewPointModel> viewPoints = RxList<ComicViewPointModel>();

  /// 连接类型
  Rx<ConnectivityResult> connectivityType =
      Rx<ConnectivityResult>(ConnectivityResult.other);

  /// 电量信息
  Rx<int> batteryLevel = 0.obs;

  /// 显示电量
  RxBool showBattery = true.obs;

  @override
  void onInit() {
    initConnectivity();
    initBattery();
    direction.value = settings.comicReaderDirection.value;
    if (settings.comicReaderFullScreen.value) {
      setFull();
    }

    itemPositionsListener.itemPositions.addListener(updateItemPosition);
    loadDetail();
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

  @override
  void onClose() {
    connectivitySubscription?.cancel();
    batterySubscription?.cancel();
    exitFull();
    itemPositionsListener.itemPositions.removeListener(updateItemPosition);
    uploadHistory();
    super.onClose();
  }

  void updateItemPosition() {
    var items = itemPositionsListener.itemPositions.value;
    if (items.isEmpty) {
      return;
    }

    var index = items
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;

    currentIndex.value = index;
  }

  /// 加载信息
  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;

      detail.value = ComicChapterDetail.empty();
      var chapterId = chapters[chapterIndex.value].chapterId;
      loadViewPoints();

      var result = await request.chapterDetail(
        comicId: comicId,
        chapterId: chapterId,
      );
      var his = DBService.instance.getComicHistory(comicId);
      if (his != null && his.chapterId == chapterId && his.page != 0) {
        var hisIndex = (his.page - 1) < 0 ? 0 : his.page - 1;
        if (hisIndex >= result.pageUrls.length - 1) {
          hisIndex = 0;
        }
        initialIndex = hisIndex;
      } else {
        initialIndex = 0;
      }
      currentIndex.value = initialIndex;
      if (settings.comicReaderShowViewPoint.value) {
        result.pageUrls.add("TC");
      }

      detail.value = result;
      Future.delayed(const Duration(milliseconds: 100), () {
        jumpToPage(initialIndex);
      });
      //上传记录
      uploadHistory();
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  /// 加载吐槽、观点
  void loadViewPoints() async {
    try {
      viewPoints.clear();
      var result = await request.viewPoints(
        comicId: comicId,
        chapterId: chapters[chapterIndex.value].chapterId,
      );
      result.sort((a, b) => b.num.value.compareTo(a.num.value));
      viewPoints.value = result;
    } catch (e) {
      SmartDialog.showToast("读取吐槽失败");
      Log.logPrint(e.toString());
    }
  }

  /// 设置显示/隐藏控制按钮
  void setShowControls() {
    if (settings.comicReaderFullScreen.value) {
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

  /// 显示目录
  void showMenu() async {
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
                    title: Text(item.chapterTitle),
                    onTap: () {
                      chapterIndex.value = i;
                      loadDetail();
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

  /// 下一章
  void nextChapter() {
    if (chapterIndex.value == chapters.length - 1) {
      SmartDialog.showToast("后面没有了");
      return;
    }

    chapterIndex.value += 1;
    loadDetail();
  }

  /// 上一章
  void forwardChapter() {
    if (chapterIndex.value == 0) {
      SmartDialog.showToast("前面没有了");
      return;
    }

    chapterIndex.value -= 1;
    loadDetail();
  }

  /// 下一页
  void nextPage() {
    var value = currentIndex.value;
    var max = detail.value.pageUrls.length;
    if (value >= max - 1) {
      nextChapter();
    } else {
      jumpToPage(value + 1, anime: true);
    }
  }

  /// 上一页
  void forwardPage() {
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
    if (direction.value == 1) {
      itemScrollController.jumpTo(index: page);
    } else {
      anime
          ? preloadPageController.animateToPage(page,
              duration: const Duration(milliseconds: 200), curve: Curves.linear)
          : preloadPageController.jumpToPage(page);
    }
  }

  /// 查看吐槽
  void showComment() {
    setShowControls();
    TextEditingController tucaoController = TextEditingController();
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
              title: Text("吐槽(${viewPoints.length})"),
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
              child: EasyRefresh(
                header: const MaterialHeader(),
                onRefresh: () async {
                  loadViewPoints();
                },
                child: Obx(
                  () => ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: viewPoints.length,
                    separatorBuilder: (_, i) => Divider(
                      indent: 12,
                      endIndent: 12,
                      height: 1.0,
                      color: Colors.grey.withOpacity(.2),
                    ),
                    itemBuilder: (_, i) {
                      var item = viewPoints[i];
                      return Padding(
                        padding:
                            AppStyle.edgeInsetsA12.copyWith(top: 4, bottom: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.content,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                likeViewPoint(item);
                              },
                              icon: const Icon(
                                Remix.thumb_up_line,
                                size: 20,
                              ),
                              label: Obx(() => Text("${item.num.value}")),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              padding: AppStyle.edgeInsetsA8.copyWith(
                bottom: 8 + AppStyle.bottomBarHeight,
              ),
              child: TextField(
                controller: tucaoController,
                onSubmitted: (e) {
                  sendViewPoint(e);
                },
                decoration: InputDecoration(
                  hintText: "发表吐槽",
                  contentPadding: AppStyle.edgeInsetsH12,
                  border: const OutlineInputBorder(),
                  suffixIcon: TextButton(
                    onPressed: () {
                      sendViewPoint(tucaoController.text);
                    },
                    child: const Text("发布"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      routeSettings: const RouteSettings(name: "/modalBottomSheet"),
    );
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
                                setDirection(0);
                              },
                              selected:
                                  settings.comicReaderDirection.value == 0,
                              child: const Icon(Remix.arrow_right_line),
                            ),
                            AppStyle.hGap8,
                            buildSelectedButton(
                              onTap: () {
                                setDirection(2);
                              },
                              selected:
                                  settings.comicReaderDirection.value == 2,
                              child: const Icon(Remix.arrow_left_line),
                            ),
                            AppStyle.hGap8,
                            buildSelectedButton(
                              onTap: () {
                                setDirection(1);
                              },
                              selected:
                                  settings.comicReaderDirection.value == 1,
                              child: const Icon(Remix.arrow_down_line),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: SwitchListTile(
                        value: settings.comicReaderFullScreen.value,
                        onChanged: (e) {
                          settings.setComicReaderFullScreen(e);
                          if (e) {
                            setFull();
                          } else {
                            exitFull();
                          }
                        },
                        title: const Text("全屏阅读"),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: SwitchListTile(
                        value: settings.comicReaderShowStatus.value,
                        onChanged: (e) {
                          settings.setComicReaderShowStatus(e);
                        },
                        title: const Text("显示状态信息"),
                      ),
                    ),
                    AppStyle.vGap12,
                    buildBGItem(
                      child: SwitchListTile(
                        value: settings.comicReaderShowViewPoint.value,
                        onChanged: (e) {
                          settings.setComicReaderShowViewPoint(e);
                          setShowViewPoint(e);
                        },
                        title: const Text("显示观点/吐槽"),
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

  void setDirection(int value) {
    initialIndex = currentIndex.value;
    settings.setComicReaderDirection(value);
    direction.value = value;
    if (initialIndex != 0) {
      Future.delayed(const Duration(milliseconds: 200), () {
        jumpToPage(initialIndex);
      });
    }
  }

  void setShowViewPoint(bool value) {
    if (value) {
      if (!detail.value.pageUrls.contains("TC")) {
        detail.update((val) {
          val!.pageUrls.add("TC");
        });
      }
    } else {
      if (detail.value.pageUrls.contains("TC")) {
        detail.update((val) {
          val!.pageUrls.remove("TC");
        });
      }
    }
  }

  void uploadHistory() {
    var chapter = chapters[chapterIndex.value];
    UserService.instance.updateComicHistory(
      comicId: comicId,
      chapterId: chapter.chapterId,
      page: currentIndex.value + 1,
      comicName: comicTitle,
      comicCover: comicCover,
      chapterName: chapter.chapterTitle,
    );
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
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  void likeViewPoint(ComicViewPointModel item) async {
    try {
      await request.likeViewPoint(comicId: comicId, id: item.id);

      item.num.value += 1;
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  void sendViewPoint(String content) async {
    if (!await UserService.instance.login()) {
      SmartDialog.showToast("请先登录");
      return;
    }
    if (content.isEmpty) {
      SmartDialog.showToast("内容不能为空");
      return;
    }
    Get.back();
    try {
      SmartDialog.showLoading();
      await request.sendViewPoint(
        comicId: comicId,
        chapterId: chapters[chapterIndex.value].chapterId,
        content: content,
        page: currentIndex.value + 1,
      );
      loadViewPoints();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
