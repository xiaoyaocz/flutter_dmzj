import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/comic/reader/comic_reader_controller.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:remixicon/remixicon.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderPage extends GetView<ComicReaderController> {
  const ComicReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppStyle.darkTheme,
      child: Scaffold(
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
                  child: controller.direction.value == 1
                      ? buildVertical()
                      : buildHorizontal(),
                ),
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
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                  ),
                ),
                padding: AppStyle.edgeInsetsA8.copyWith(top: 4, bottom: 4),
                child: Obx(
                  () => Text(
                    "${controller.detail.value.chapterTitle}  ${controller.currentIndex.value + 1} / ${controller.detail.value.pageUrls.length}",
                    style: const TextStyle(fontSize: 12),
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
                      Text(controller.detail.value.chapterTitle),
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
                                  onPressed: controller.showComment,
                                  icon: Obx(
                                    () => Badge(
                                      label: Text(
                                        "${controller.viewPoints.length}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      child:
                                          const Icon(Remix.chat_smile_2_line),
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
    );
  }

  Widget buildHorizontal() {
    return PreloadPageView.builder(
      controller: controller.preloadPageController,
      onPageChanged: (e) {
        controller.currentIndex.value = e;
      },
      physics: controller.lockSwipe.value
          ? const NeverScrollableScrollPhysics()
          : null,
      itemCount: controller.detail.value.pageUrls.length,
      preloadPagesCount: 4,
      itemBuilder: (_, i) {
        var url = controller.detail.value.pageUrls[i];
        return PhotoView.customChild(
          wantKeepAlive: true,
          initialScale: 1.0,
          onScaleEnd: (context, detail, e) {
            controller.lockSwipe.value = (e.scale ?? 1) > 1.0;
            print(e.scale);
          },
          child: NetImage(
            url,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

  Widget buildVertical() {
    return ScrollablePositionedList.builder(
      itemScrollController: controller.itemScrollController,
      itemCount: controller.detail.value.pageUrls.length + 1,
      itemPositionsListener: controller.itemPositionsListener,
      itemBuilder: (_, i) {
        if (i == controller.detail.value.pageUrls.length) {
          return const SizedBox(
            height: 100,
            child: Text("底部，吐槽页面"),
          );
        }
        var url = controller.detail.value.pageUrls[i];
        return Container(
          constraints: const BoxConstraints(
            minHeight: 200,
          ),
          child: NetImage(
            url,
            fit: BoxFit.fitWidth,
          ),
        );
      },
    );
  }

  Widget buildSilderBar() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Slider(
              value: controller.currentIndex.value + 1,
              max: controller.detail.value.pageUrls.isEmpty
                  ? 1
                  : controller.detail.value.pageUrls.length.toDouble(),
              onChanged: (e) {
                print(e);
                //竖向
                if (controller.direction.value == 1) {
                  controller.itemScrollController
                      .jumpTo(index: (e - 1).toInt());
                } else {
                  controller.preloadPageController.jumpToPage((e - 1).toInt());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
