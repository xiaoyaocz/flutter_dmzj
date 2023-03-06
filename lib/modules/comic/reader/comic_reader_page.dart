import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/reader/comic_reader_controller.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderPage extends GetView<ComicReaderController> {
  const ComicReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.detail.value.chapterTitle)),
      ),
      body: Stack(
        children: [
          Obx(
            () => Offstage(
              offstage: controller.detail.value.chapterId == 0,
              child: controller.direction.value == 1
                  ? buildVertical()
                  : buildHorizontal(),
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 36,
          child: Center(
            child: Obx(
              () => Text(
                "${controller.currentIndex.value + 1} / ${controller.detail.value.pageUrls.length}",
              ),
            ),
          ),
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
          onTapUp: (context, detail, e) {
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
}
