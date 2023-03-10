import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/dialog_utils.dart';
import 'package:flutter_dmzj/modules/novel/reader/novel_horizontal_reader.dart';

import 'package:flutter_dmzj/modules/novel/reader/novel_reader_controller.dart';
import 'package:flutter_dmzj/widgets/custom_header.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class NovelReaderPage extends GetView<NovelReaderController> {
  const NovelReaderPage({Key? key}) : super(key: key);

  Color get color =>
      AppColor.novelThemes[controller.settings.novelReaderTheme.value]!.last;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppStyle.darkTheme,
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor
              .novelThemes[controller.settings.novelReaderTheme.value]!.first,
          body: Stack(
            children: [
              Obx(
                () => Offstage(
                  offstage: controller.content.value.isEmpty,
                  child: GestureDetector(
                    onTap: () {
                      controller.setShowControls();
                    },
                    child: controller.isPicture.value
                        ? buildPicture()
                        : (controller.direction.value == 1
                            ? buildVertical()
                            : buildHorizontal()),
                  ),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.direction.value == 2
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
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.direction.value == 2
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
                    onRefresh: () => controller.loadContent(),
                  ),
                ),
              ),
              buildBottomStatus(),
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
                          child: Text(
                            controller.chapters[controller.chapterIndex.value]
                                .chapterName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
      child: NovelHorizontalReader(
        controller.content.value,
        controller: controller.pageController,
        reverse: controller.direction.value == 2,
        style: TextStyle(
          fontSize: controller.settings.novelReaderFontSize.value.toDouble(),
          height: controller.settings.novelReaderLineSpacing.value,
          color: AppColor
              .novelThemes[controller.settings.novelReaderTheme.value]!.last,
        ),
        padding: AppStyle.edgeInsetsA12.copyWith(
          top: AppStyle.statusBarHeight + 12,
          bottom: (controller.settings.novelReaderShowStatus.value ? 24 : 12),
        ),
        onPageChanged: (i, m) {
          controller.currentIndex.value = i;
          controller.maxPage.value = m;
        },
      ),
    );
  }

  Widget buildVertical() {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppStyle.statusBarHeight,
        ),
        child: Padding(
          padding: AppStyle.edgeInsetsA12.copyWith(
            bottom: (controller.settings.novelReaderShowStatus.value ? 36 : 12),
          ),
          child: EasyRefresh(
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
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Text(
                controller.content.value,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize:
                      controller.settings.novelReaderFontSize.value.toDouble(),
                  height: controller.settings.novelReaderLineSpacing.value,
                  color: AppColor
                      .novelThemes[controller.settings.novelReaderTheme.value]!
                      .last,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPicture() {
    return Padding(
      padding: EdgeInsets.only(
        top: AppStyle.statusBarHeight,
      ),
      child: EasyRefresh(
        header: MaterialHeader2(
          triggerOffset: 80,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppStyle.radius24,
            ),
            padding: AppStyle.edgeInsetsA12,
            child: Icon(
              controller.direction.value != 1
                  ? Icons.arrow_circle_left
                  : Icons.arrow_circle_up,
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
            child: Icon(
              controller.direction.value != 1
                  ? Icons.arrow_circle_right
                  : Icons.arrow_circle_down,
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
        child: controller.direction.value != 1
            ? PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pictures.length,
                reverse: controller.direction.value == 2,
                onPageChanged: (e) {
                  controller.currentIndex.value = e;
                  controller.maxPage.value = controller.pictures.length;
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: (controller.settings.novelReaderShowStatus.value
                          ? 24
                          : 12),
                    ),
                    child: GestureDetector(
                      onDoubleTap: () {
                        DialogUtils.showImageViewer(
                            i, controller.pictures.toList());
                      },
                      child: NetImage(
                        controller.pictures[i],
                        fit: BoxFit.contain,
                        progress: true,
                      ),
                    ),
                  );
                })
            : ListView.separated(
                controller: controller.scrollController,
                itemCount: controller.pictures.length,
                padding: EdgeInsets.zero,
                separatorBuilder: (_, i) => AppStyle.vGap4,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onDoubleTap: () {
                      DialogUtils.showImageViewer(
                          i, controller.pictures.toList());
                    },
                    child: NetImage(
                      controller.pictures[i],
                      fit: BoxFit.fitWidth,
                      progress: true,
                    ),
                  );
                }),
      ),
    );
  }

  Widget buildSilderBar() {
    if (controller.direction.value == 1) {
      return Obx(
        () {
          var value = controller.progress.value;
          var max = 1.0;
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
                      controller.scrollController.jumpTo(
                        controller.scrollController.position.maxScrollExtent *
                            e,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Obx(
      () {
        var value = controller.currentIndex.value + 1.0;
        var max = controller.maxPage.value;
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
                  max: max.toDouble(),
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

  Widget buildBottomStatus() {
    return Positioned(
      right: 8,
      left: 8,
      bottom: 4,
      child: Obx(
        () => Offstage(
          offstage: !controller.settings.novelReaderShowStatus.value,
          child: Container(
            padding: AppStyle.edgeInsetsA12.copyWith(top: 4, bottom: 4),
            child: Obx(
              () => Row(
                children: [
                  buildConnectivity(),
                  buildBattery(),
                  const Expanded(child: SizedBox()),
                  controller.direction.value != 1
                      ? Text(
                          "${controller.currentIndex.value + 1} / ${controller.maxPage.value}",
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            color: color.withOpacity(.6),
                          ),
                        )
                      : Text(
                          "${(controller.progress.value * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            color: color.withOpacity(.6),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
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
        Icon(icon, size: 12, color: color.withOpacity(.6)),
        AppStyle.hGap4,
        Text(
          name,
          style: TextStyle(
              fontSize: 12, height: 1.0, color: color.withOpacity(.6)),
        ),
        AppStyle.hGap8,
      ],
    );
  }

  Widget buildBattery() {
    var battery = controller.batteryLevel.value;
    // IconData icon = Icons.battery_0_bar;
    // if (battery >= 90) {
    //   icon = Icons.battery_full_rounded;
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
          //Icon(icon, size: 12, color: color.withOpacity(.6)),
          Text(
            "电量 $battery%",
            style: TextStyle(
                fontSize: 12, height: 1.0, color: color.withOpacity(.6)),
          ),
          AppStyle.hGap8,
        ],
      ),
    );
  }
}
