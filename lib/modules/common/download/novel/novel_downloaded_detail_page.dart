import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';
import 'package:flutter_dmzj/modules/common/download/novel/novel_downloaded_detail_controller.dart';

import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class NovelDownloadedDetailPage extends StatelessWidget {
  final NovelDownloadedItem info;
  final NovelDownloadedDetailController controller;
  NovelDownloadedDetailPage(this.info, {super.key})
      : controller = Get.put(
          NovelDownloadedDetailController(info),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info.novelName),
      ),
      body: ListView.builder(
        padding: AppStyle.edgeInsetsA12,
        itemCount: info.volumes.length,
        itemBuilder: (_, i) {
          var item = info.volumes[i];
          return _buildChapters(item);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 48,
          child: Obx(
            () => Column(
              children: [
                Visibility(
                  visible: !controller.editMode.value,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: controller.setEditMode,
                          icon: const Icon(
                            Remix.checkbox_line,
                            size: 20,
                          ),
                          label: const Text("选择"),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: controller.toDetail,
                          icon: const Icon(
                            Remix.information_line,
                            size: 20,
                          ),
                          label: const Text("详情"),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: controller.toAddDownload,
                          icon: const Icon(
                            Remix.add_line,
                            size: 20,
                          ),
                          label: const Text("追加"),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: controller.read,
                          icon: const Icon(
                            Remix.play_line,
                            size: 20,
                          ),
                          label: const Text("阅读"),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.editMode.value,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: controller.selectAll,
                          icon: const Icon(
                            Remix.checkbox_line,
                            size: 20,
                          ),
                          label: const Text("全选"),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: controller.delete,
                          icon: const Icon(
                            Remix.delete_bin_line,
                            size: 20,
                          ),
                          label: const Text("删除"),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 14),
                          ),
                          onPressed: controller.exitEditMode,
                          icon: const Icon(
                            Remix.close_line,
                            size: 20,
                          ),
                          label: const Text("取消"),
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
    );
  }

  Widget _buildChapters(NovelDetailVolume item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: AppStyle.edgeInsetsV8,
          child: Row(children: [
            Expanded(
              child: Text(
                "${item.volumeName}(共${item.chapters.length}话)",
                style: Get.textTheme.titleSmall,
              ),
            ),
          ]),
        ),
        LayoutBuilder(builder: (ctx, constraints) {
          var count = constraints.maxWidth ~/ 160;
          if (count < 3) count = 3;

          return MasonryGridView.count(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: item.chapters.length,
            itemBuilder: (_, i) {
              var chapter = item.chapters[i];

              return Tooltip(
                message: chapter.chapterName,
                child: Obx(
                  () => controller.editMode.value
                      ? OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                controller.selectItems.contains(chapter)
                                    ? Colors.blue
                                    : Get.textTheme.bodyMedium!.color,
                            side: controller.selectItems.contains(chapter)
                                ? const BorderSide(color: Colors.blue)
                                : null,
                            textStyle: const TextStyle(fontSize: 14),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: const Size.fromHeight(40),
                          ),
                          onPressed: () {
                            controller.selectItem(chapter);
                          },
                          child: Text(
                            item.chapters[i].chapterName,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: item.chapters[i].chapterId ==
                                    controller.history.value?.chapterId
                                ? Colors.blue
                                : Get.textTheme.bodyMedium!.color,
                            textStyle: const TextStyle(fontSize: 14),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: const Size.fromHeight(40),
                          ),
                          onPressed: () {
                            controller.readChapter(item, chapter);
                          },
                          child: Text(
                            item.chapters[i].chapterName,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
              );
            },
            crossAxisCount: count,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          );
        })
      ],
    );
  }
}
