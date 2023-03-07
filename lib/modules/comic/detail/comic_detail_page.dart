import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/modules/comic/detail/comic_detail_controller.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class ComicDetailPage extends StatelessWidget {
  final int id;
  final ComicDetailControler controller;
  ComicDetailPage(this.id, {super.key})
      : controller = Get.put(
          ComicDetailControler(id),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.detail.value.title.isEmpty
                ? "漫画详情"
                : controller.detail.value.title,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.share,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(
            () => Offstage(
              offstage: controller.detail.value.id == 0,
              child: EasyRefresh(
                header: const MaterialHeader(),
                onRefresh: controller.refreshDetail,
                child: ListView(
                  padding: AppStyle.edgeInsetsA12,
                  children: [
                    _buildHeader(),
                    Obx(
                      () => Offstage(
                        offstage: controller.history.value == null,
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "上次看到：${controller.history.value?.chapterName ?? ""}  第${controller.history.value?.page}页",
                                style: Get.textTheme.titleSmall,
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                controller.read();
                              },
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(.2),
                              height: 1.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildChapter(),
                  ],
                ),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        onPressed: controller.read,
        child: const Icon(Icons.play_circle),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: controller.subscribe,
                    icon: Icon(
                      controller.subscribeStatus.value
                          ? Remix.heart_fill
                          : Remix.heart_line,
                      size: 20,
                    ),
                    label: Text(controller.subscribeStatus.value ? "取消" : "订阅"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: controller.comment,
                  icon: const Icon(
                    Remix.chat_2_line,
                    size: 20,
                  ),
                  label: const Text("评论"),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: controller.download,
                  icon: const Icon(
                    Remix.download_line,
                    size: 20,
                  ),
                  label: const Text("下载"),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: controller.related,
                  icon: const Icon(
                    Remix.links_line,
                    size: 20,
                  ),
                  label: const Text("相关"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //信息
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NetImage(
              controller.detail.value.cover,
              width: 120,
              height: 160,
              borderRadius: 4,
            ),
            AppStyle.hGap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    controller.detail.value.title,
                    style: Get.textTheme.titleMedium,
                  ),
                  AppStyle.vGap8,

                  _buildInfoItems(
                    iconData: Remix.user_smile_line,
                    children: controller.detail.value.authors
                        .map(
                          (e) => GestureDetector(
                            onTap: () => controller.toAuthorDetail(e),
                            child: Text(
                              e.tagName,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.2,
                                decoration: TextDecoration.underline,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : AppColor.black333,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  // _buildInfo(
                  //   title: controller.detail.value.types
                  //       .map((e) => e.tagName)
                  //       .join("/"),
                  //   iconData: Remix.hashtag,
                  // ),
                  _buildInfoItems(
                    iconData: Remix.hashtag,
                    children: controller.detail.value.types
                        .map(
                          (e) => GestureDetector(
                            onTap: () => controller.toCategoryDetail(e),
                            child: Text(
                              e.tagName,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.2,
                                decoration: TextDecoration.underline,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : AppColor.black333,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  _buildInfo(
                    title: "人气 ${controller.detail.value.hitNum}",
                    iconData: Remix.fire_line,
                  ),
                  _buildInfo(
                    title: "订阅 ${controller.detail.value.subscribeNum}",
                    iconData: Remix.heart_line,
                  ),
                  _buildInfo(
                    title:
                        "${Utils.formatTimestampToDate(controller.detail.value.lastUpdatetime)} ${controller.detail.value.status.map((e) => e.tagName).join("/")}",
                    iconData: Icons.schedule,
                  ),
                ],
              ),
            ),
          ],
        ),
        AppStyle.vGap12,
        GestureDetector(
          onTap: () {
            controller.expandDescription.value =
                !controller.expandDescription.value;
          },
          child: Text(
            controller.detail.value.description,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            maxLines: controller.expandDescription.value ? 999 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppStyle.vGap12,
        Divider(
          color: Colors.grey.withOpacity(.2),
          height: 1.0,
        ),
      ],
    );
  }

  Widget _buildChapter() {
    return Column(
      children: controller.detail.value.volumes
          .map(
            (item) => Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: AppStyle.edgeInsetsV8,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item.title}(共${item.chapters.length}话)",
                            style: Get.textTheme.titleSmall,
                          ),
                        ),
                        item.sortType.value == 1
                            ? TextButton.icon(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  item.sortType.value = 0;
                                  item.sort();
                                },
                                icon: const Icon(
                                  Remix.sort_asc,
                                  size: 20,
                                ),
                                label: const Text("升序"),
                              )
                            : TextButton.icon(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  item.sortType.value = 1;
                                  item.sort();
                                },
                                icon: const Icon(
                                  Remix.sort_desc,
                                  size: 20,
                                ),
                                label: const Text("倒序"),
                              ),
                      ],
                    ),
                  ),
                  LayoutBuilder(builder: (ctx, constraints) {
                    var count = constraints.maxWidth ~/ 160;
                    if (count < 3) count = 3;

                    return Obx(
                      () => MasonryGridView.count(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (item.showMoreButton && !item.showAll.value)
                            ? 15
                            : item.chapters.length,
                        itemBuilder: (_, i) {
                          if (item.showMoreButton &&
                              !item.showAll.value &&
                              i == 14) {
                            return Tooltip(
                              message: "展开全部章节",
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey,
                                  textStyle: const TextStyle(fontSize: 14),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: const Size.fromHeight(40),
                                ),
                                onPressed: () {
                                  item.showAll.value = true;
                                },
                                child: const Icon(Icons.arrow_drop_down),
                              ),
                            );
                          }
                          return Tooltip(
                            message: item.chapters[i].chapterTitle,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    Get.textTheme.bodyMedium!.color,
                                textStyle: const TextStyle(fontSize: 14),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: const Size.fromHeight(40),
                              ),
                              onPressed: () {
                                controller.readChapter(item, item.chapters[i]);
                              },
                              child: Text(
                                item.chapters[i].chapterTitle,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        },
                        crossAxisCount: count,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                    );
                  })
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildInfo({
    required String title,
    IconData iconData = Icons.tag,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 16,
          ),
          AppStyle.hGap8,
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Get.isDarkMode ? Colors.white : AppColor.black333,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItems({
    required List<Widget> children,
    IconData iconData = Icons.tag,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 16,
          ),
          AppStyle.hGap8,
          Expanded(
            child: Wrap(
              spacing: 8,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
