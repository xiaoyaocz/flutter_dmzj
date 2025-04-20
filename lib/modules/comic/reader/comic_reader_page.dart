import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_constant.dart';

import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/modules/comic/reader/comic_reader_controller.dart';
import 'package:flutter_dmzj/widgets/custom_header.dart';
import 'package:flutter_dmzj/widgets/local_image.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:remixicon/remixicon.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_dmzj/services/app_settings_service.dart';

class ComicReaderPage extends GetView<ComicReaderController> {
  const ComicReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      onKeyEvent: (e) {
        if (e.runtimeType == KeyUpEvent) {
          controller.keyDown(e.logicalKey);
          Log.d(e.toString());
        }
      },
      focusNode: controller.focusNode,
      autofocus: true,
      child: Theme(
        data: AppStyle.darkTheme,
        child: Scaffold(
          // Change background based on E-Ink mode
          backgroundColor: controller.eInkMode
              ? Colors.white
              : AppStyle.darkTheme.scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Obx(
                () => Offstage(
                  offstage: controller.detail.value.chapterId == 0,
                  child: GestureDetector(
                    onTap: () {
                      controller.setShowControls();
                    },
                    child:
                        controller.direction.value == ReaderDirection.kUpToDown
                            ? buildVertical()
                            : buildHorizontal(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      // Increase touch target size in E-Ink mode
                      flex: controller.eInkMode ? 4 : 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.leftHandMode
                              ? controller.nextPage()
                              : controller.forwardPage();
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(),
                    ),
                    Expanded(
                      flex: controller.eInkMode ? 4 : 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.leftHandMode
                              ? controller.forwardPage()
                              : controller.nextPage();
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Offstage(
                  offstage: !controller.pageLoadding.value,
                  child: const AppLoaddingWidget(),
                ),
              ),
              Obx(
                () => Offstage(
                  offstage: !controller.pageError.value,
                  child: AppErrorWidget(
                    errorMsg: controller.errorMsg.value,
                    onRefresh: () => controller.loadDetail(),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Obx(
                  () => Offstage(
                    offstage: !controller.settings.comicReaderShowStatus.value,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      padding:
                          AppStyle.edgeInsetsA12.copyWith(top: 4, bottom: 4),
                      child: Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            buildConnectivity(),
                            buildBattery(),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: Text(
                                controller.detail.value.chapterTitle,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    const TextStyle(fontSize: 12, height: 1.0),
                              ),
                            ),
                            AppStyle.hGap8,
                            Text(
                              "${controller.currentIndex.value + 1} / ${controller.detail.value.pageUrls.length}",
                              style: const TextStyle(fontSize: 12, height: 1.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //顶部
              Obx(
                () => AnimatedPositioned(
                  top: controller.showControls.value
                      ? 0
                      : -(48 + AppStyle.statusBarHeight),
                  left: 0,
                  right: 0,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    color: AppStyle.darkTheme.cardColor,
                    height: 48 + AppStyle.statusBarHeight,
                    padding: EdgeInsets.only(top: AppStyle.statusBarHeight),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: Get.back,
                          icon: const Icon(Icons.arrow_back),
                        ),
                        AppStyle.hGap12,
                        Expanded(
                          child: Obx(
                            () => Text(
                              controller.chapters[controller.chapterIndex.value]
                                  .chapterTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //底部
              Obx(
                () => AnimatedPositioned(
                  bottom: controller.showControls.value
                      ? 0
                      : -(104 + AppStyle.bottomBarHeight),
                  left: 0,
                  right: 0,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    color: AppStyle.darkTheme.cardColor,
                    height: 104 + AppStyle.bottomBarHeight,
                    padding: EdgeInsets.only(bottom: AppStyle.bottomBarHeight),
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: Column(
                        children: [
                          buildSilderBar(),
                          Material(
                            color: AppStyle.darkTheme.cardColor,
                            child: Row(
                              children: [
                                Expanded(
                                  child: IconButton(
                                    onPressed: controller.forwardChapter,
                                    icon: const Icon(Remix.skip_back_line),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.settings
                                        .comicReaderShowViewPoint.value,
                                    child: Expanded(
                                      child: IconButton(
                                        onPressed: controller.showComment,
                                        icon: Badge(
                                          label: Text(
                                            "${controller.viewPoints.length}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          child: const Icon(
                                              Remix.chat_smile_2_line),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: controller.showMenu,
                                    icon: const Icon(Remix.file_list_line),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: controller.showSettings,
                                    icon: const Icon(Remix.settings_line),
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: controller.nextChapter,
                                    icon: const Icon(Remix.skip_forward_line),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHorizontal() {
    return EasyRefresh(
      header: MaterialHeader2(
        triggerOffset: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppStyle.radius24,
          ),
          padding: AppStyle.edgeInsetsA12,
          child: const Icon(
            Icons.arrow_circle_left,
            color: Colors.blue,
          ),
        ),
      ),
      footer: MaterialFooter2(
        triggerOffset: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppStyle.radius24,
          ),
          padding: AppStyle.edgeInsetsA12,
          child: const Icon(
            Icons.arrow_circle_right,
            color: Colors.blue,
          ),
        ),
      ),
      refreshOnStart: false,
      onRefresh: () async {
        controller.forwardChapter();
      },
      onLoad: () async {
        controller.nextChapter();
      },
      child: PreloadPageView.builder(
        controller: controller.preloadPageController,
        onPageChanged: (e) {
          controller.currentIndex.value = e;
        },
        reverse: controller.direction.value == ReaderDirection.kRightToLeft,
        physics: controller.lockSwipe.value
            ? const NeverScrollableScrollPhysics()
            : null,
        itemCount: controller.detail.value.pageUrls.length,
        preloadPagesCount: 4,
        itemBuilder: (_, i) {
          var url = controller.detail.value.pageUrls[i];
          if (i == controller.detail.value.pageUrls.length - 1 && url == "TC") {
            return buildViewPoints();
          }
          return PhotoView.customChild(
            wantKeepAlive: true,
            initialScale: 1.0,
            onScaleEnd: (context, detail, e) {
              controller.lockSwipe.value = (e.scale ?? 1) > 1.0;
            },
            child: Container(
              color: controller.eInkMode ? Colors.white : Colors.black,
              child: controller.detail.value.isLocal
                  ? LocalImage(url, fit: BoxFit.contain)
                  : NetImage(
                      url,
                      fit: BoxFit.contain,
                      progress: true,
                    ),
            )
          );
        },
      ),
    );
  }

  Widget buildVertical() {
    return EasyRefresh(
      header: MaterialHeader2(
        triggerOffset: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppStyle.radius24,
          ),
          padding: AppStyle.edgeInsetsA12,
          child: const Icon(
            Icons.arrow_circle_up,
            color: Colors.blue,
          ),
        ),
      ),
      footer: MaterialFooter2(
        triggerOffset: 80,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppStyle.radius24,
          ),
          padding: AppStyle.edgeInsetsA12,
          child: const Icon(
            Icons.arrow_circle_down,
            color: Colors.blue,
          ),
        ),
      ),
      refreshOnStart: false,
      onRefresh: () async {
        controller.forwardChapter();
      },
      onLoad: () async {
        controller.nextChapter();
      },
      child: ScrollablePositionedList.builder(
        itemScrollController: controller.itemScrollController,
        itemCount: controller.detail.value.pageUrls.length,
        itemPositionsListener: controller.itemPositionsListener,
        itemBuilder: (_, i) {
          if (i == controller.detail.value.pageUrls.length - 1 &&
              controller.detail.value.pageUrls[i] == "TC") {
            return buildViewPoints(shrinkWrap: true);
          }
          var url = controller.detail.value.pageUrls[i];
          return Container(
            constraints: const BoxConstraints(
              minHeight: 200,
            ),
            child: controller.detail.value.isLocal
                ? LocalImage(url, fit: BoxFit.contain)
                : NetImage(
                    url,
                    fit: BoxFit.fitWidth,
                    progress: true,
                  ),
          );
        },
      ),
    );
  }

  Widget buildSilderBar() {
    return Obx(
      () {
        var value = controller.currentIndex.value + 1.0;
        var max = controller.detail.value.pageUrls.length.toDouble();
        if (value > max) {
          return const SizedBox(
            height: 48,
          );
        }
        return SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: Slider(
                  value: value,
                  max: max,
                  onChanged: (e) {
                    controller.jumpToPage((e - 1).toInt());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildViewPoints({bool shrinkWrap = false}) {
    return Obx(
      () => ListView(
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Text("吐槽(${controller.viewPoints.length})"),
          ),
          Padding(
            padding: AppStyle.edgeInsetsH12,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.viewPoints
                  .take(10)
                  .map(
                    (e) => OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        controller.likeViewPoint(e);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.content,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          AppStyle.hGap12,
                          const Icon(
                            Remix.thumb_up_line,
                            size: 16,
                          ),
                          AppStyle.hGap4,
                          Obx(
                            () => Text(
                              "${e.num.value}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 100,
            margin: AppStyle.edgeInsetsA12,
            child: OutlinedButton(
              onPressed: () {
                controller.showComment();
              },
              child: const Text("查看更多"),
            ),
          ),
          AppStyle.vGap12,
        ],
      ),
    );
  }

  Widget buildConnectivity() {
    var connectivityType = controller.connectivityType.value;
    IconData icon = Remix.wifi_line;
    var name = "WiFi";
    switch (connectivityType) {
      case ConnectivityResult.bluetooth:
        icon = Remix.wifi_line;
        name = "蓝牙";
        break;
      case ConnectivityResult.ethernet:
        icon = Remix.computer_line;
        name = "有线";
        break;
      case ConnectivityResult.mobile:
        icon = Remix.base_station_line;
        name = "流量";
        break;
      case ConnectivityResult.wifi:
        icon = Remix.wifi_line;
        name = "WiFi";
        break;
      case ConnectivityResult.vpn:
        icon = Remix.shield_keyhole_line;
        name = "VPN";
        break;
      case ConnectivityResult.none:
        icon = Remix.wifi_off_line;
        name = "无网络";
        break;
      case ConnectivityResult.other:
        icon = Remix.question_line;
        name = "未知";
        break;
      default:
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 12,
        ),
        AppStyle.hGap4,
        Text(
          name,
          style: const TextStyle(fontSize: 12, height: 1.0),
        ),
        AppStyle.hGap8,
      ],
    );
  }

  Widget buildBattery() {
    var battery = controller.batteryLevel.value;
    // IconData icon = Icons.battery_0_bar;
    // if (battery >= 90) {
    //   icon = Icons.battery_full;
    // } else if (battery < 90 && battery >= 80) {
    //   icon = Icons.battery_6_bar;
    // } else if (battery < 80 && battery >= 70) {
    //   icon = Icons.battery_5_bar;
    // } else if (battery < 70 && battery >= 50) {
    //   icon = Icons.battery_4_bar;
    // } else if (battery < 50 && battery >= 30) {
    //   icon = Icons.battery_3_bar;
    // } else if (battery < 30 && battery >= 20) {
    //   icon = Icons.battery_2_bar;
    // } else if (battery < 20 && battery >= 10) {
    //   icon = Icons.battery_1_bar;
    // } else {
    //   icon = Icons.battery_0_bar;
    // }
    return Visibility(
      visible: controller.showBattery.value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon(
          //   icon,
          //   size: 16,
          // ),
          // AppStyle.hGap4,
          Text(
            "电量 $battery%",
            style: const TextStyle(fontSize: 12, height: 1.0),
          ),
          AppStyle.hGap8,
        ],
      ),
    );
  }
}
