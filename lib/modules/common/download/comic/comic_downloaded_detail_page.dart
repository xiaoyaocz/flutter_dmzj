import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/modules/common/download/comic/comic_downloaded_detail_controller.dart';

import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class ComicDownloadedDetailPage extends StatelessWidget {
  final ComicDownloadedItem info;
  final ComicDownloadedDetailController controller;
  ComicDownloadedDetailPage(this.info, {super.key})
      : controller = Get.put(
          ComicDownloadedDetailController(info),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info.comicName),
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

  Widget _buildChapters(ComicDetailVolume item) {
    return Obx(
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
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                  if (item.showMoreButton && !item.showAll.value && i == 14) {
                    return Tooltip(
                      message: "展开全部章节",
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          textStyle: const TextStyle(fontSize: 14),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size.fromHeight(40),
                        ),
                        onPressed: () {
                          item.showAll.value = true;
                        },
                        child: const Icon(Icons.arrow_drop_down),
                      ),
                    );
                  }
                  var chapter = item.chapters[i];

                  return Tooltip(
                    message: chapter.chapterTitle,
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
                                item.chapters[i].chapterTitle,
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
                                item.chapters[i].chapterTitle,
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
              ),
            );
          })
        ],
      ),
    );
  }
}
