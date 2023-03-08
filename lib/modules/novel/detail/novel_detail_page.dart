import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/modules/novel/detail/novel_detail_controller.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class NovelDetailPage extends StatelessWidget {
  final int id;
  final NovelDetailControler controller;
  NovelDetailPage(this.id, {super.key})
      : controller = Get.put(
          NovelDetailControler(id),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.detail.value.name.isEmpty
                ? "小说详情"
                : controller.detail.value.name,
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
              offstage: controller.detail.value.novelId == 0,
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
                                "上次看到：${controller.history.value?.volumeName ?? ""} ${controller.history.value?.chapterName ?? ""}",
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
        child: const Icon(Icons.play_circle_outline_rounded),
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
                    controller.detail.value.name,
                    style: Get.textTheme.titleMedium,
                  ),
                  AppStyle.vGap8,
                  _buildInfoItems(
                    iconData: Remix.user_smile_line,
                    children: controller.detail.value.authors
                        .split("/")
                        .map(
                          (e) => GestureDetector(
                            onTap: () => controller.toAuthorDetail(e),
                            child: Text(
                              e,
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
                    title:
                        controller.detail.value.types.map((e) => e).join("/"),
                    iconData: Remix.hashtag,
                  ),
                  _buildInfo(
                    title: "人气 ${controller.detail.value.hotHits}",
                    iconData: Remix.fire_line,
                  ),
                  _buildInfo(
                    title: "订阅 ${controller.detail.value.subscribeNum}",
                    iconData: Remix.heart_line,
                  ),
                  _buildInfo(
                    title:
                        "${Utils.formatTimestampToDate(controller.detail.value.lastUpdateTime)} ${controller.detail.value.status}",
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
            controller.detail.value.introduction,
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
    return LayoutBuilder(builder: (ctx, constraints) {
      var count = constraints.maxWidth ~/ 160;
      if (count < 3) count = 3;
      return Obx(
        () => Column(
          children: controller.detail.value.volume
              .map(
                (item) => ExpansionTile(
                  title: Text(
                    "${item.volumeName}(共${item.chapters.length}章)",
                    style: Get.textTheme.titleSmall,
                  ),
                  tilePadding: AppStyle.edgeInsetsH4,
                  children: [
                    MasonryGridView.count(
                      shrinkWrap: true,
                      padding: AppStyle.edgeInsetsB12,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: item.chapters.length,
                      itemBuilder: (_, i) {
                        return Tooltip(
                          message: item.chapters[i].chapterName,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Get.textTheme.bodyMedium!.color,
                              textStyle: const TextStyle(fontSize: 14),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: const Size.fromHeight(40),
                            ),
                            onPressed: () {
                              controller.readChapter(item, item.chapters[i]);
                            },
                            child: Text(
                              item.chapters[i].chapterName,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                      crossAxisCount: count,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    )
                  ],
                ),
              )
              .toList(),
        ),
      );
    });
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
