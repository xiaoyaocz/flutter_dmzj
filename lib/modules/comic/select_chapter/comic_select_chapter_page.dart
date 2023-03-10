import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/modules/comic/select_chapter/comic_select_chapter_controller.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class ComicSelectChapterPage extends StatelessWidget {
  final int comicId;
  final ComicSelectChapterController controller;
  ComicSelectChapterPage(this.comicId, {super.key})
      : controller = Get.put(
          ComicSelectChapterController(comicId),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("选择下载章节"),
        actions: [
          TextButton(
            onPressed: controller.toDownloadManage,
            child: const Text("下载管理"),
          ),
        ],
      ),
      body: Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(),
            onRefresh: controller.loadDetail,
            child: _buildVolumes(),
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
          height: 48,
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
                  onPressed: controller.cleanAll,
                  icon: const Icon(
                    Remix.checkbox_blank_line,
                    size: 20,
                  ),
                  label: const Text("取消全选"),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: controller.startDownload,
                  icon: const Icon(
                    Remix.download_line,
                    size: 20,
                  ),
                  label:
                      Obx(() => Text("下载选中(${controller.chapterIds.length})")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVolumes() {
    return Obx(
      () => ListView.builder(
        padding: AppStyle.edgeInsetsA12,
        itemCount: controller.volumes.length,
        itemBuilder: (_, i) {
          var item = controller.volumes[i];
          return _buildChapters(item);
        },
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
                      () => OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              controller.chapterIds.contains(chapter.chapterId)
                                  ? Colors.blue
                                  : Get.textTheme.bodyMedium!.color,
                          side:
                              controller.chapterIds.contains(chapter.chapterId)
                                  ? const BorderSide(color: Colors.blue)
                                  : null,
                          textStyle: const TextStyle(fontSize: 14),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: const Size.fromHeight(40),
                        ),
                        onPressed: ComicDownloadService.instance.downloadIds
                                .contains("${comicId}_${chapter.chapterId}")
                            ? null
                            : () => controller.selectItem(chapter),
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
