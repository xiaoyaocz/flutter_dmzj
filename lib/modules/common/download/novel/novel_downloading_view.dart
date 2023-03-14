import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:flutter_dmzj/services/download_task/novel_downloader.dart';
import 'package:flutter_dmzj/widgets/status/app_empty_widget.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class NovelDownloadingView extends StatelessWidget {
  const NovelDownloadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => Stack(
              children: [
                ListView.separated(
                  itemCount: NovelDownloadService.instance.taskQueues.length,
                  separatorBuilder: (_, i) => const Divider(
                    height: 1,
                  ),
                  itemBuilder: (_, i) {
                    var task = NovelDownloadService.instance.taskQueues[i];
                    return buildItem(task);
                  },
                ),
                Offstage(
                  offstage: NovelDownloadService.instance.taskQueues.isNotEmpty,
                  child: const AppEmptyWidget(),
                ),
              ],
            ),
          ),
        ),
        BottomAppBar(
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: NovelDownloadService.instance.pauseAll,
                    icon: const Icon(
                      Remix.pause_line,
                      size: 20,
                    ),
                    label: const Text("暂停全部"),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: NovelDownloadService.instance.resumeAll,
                    icon: const Icon(
                      Remix.download_line,
                      size: 20,
                    ),
                    label: const Text("开始全部"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItem(NovelDownloader task) {
    return Obx(
      () => Padding(
        padding: AppStyle.edgeInsetsA12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${task.info.value.volumeName} - ${task.info.value.chapterName}",
            ),
            Text(
              task.info.value.novelName,
              style: Get.textTheme.bodySmall,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    parseStatus(task.info.value.status),
                    style: Get.textTheme.bodySmall,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildButton(
                      icon: Icons.refresh_rounded,
                      text: "重试",
                      visible: task.status == DownloadStatus.error ||
                          task.status == DownloadStatus.errorLoad,
                      onPressed: () {
                        task.retry();
                      },
                    ),
                    buildButton(
                      icon: Icons.play_arrow_rounded,
                      visible: task.status == DownloadStatus.wait ||
                          task.status == DownloadStatus.pauseCellular,
                      text: "开始",
                      onPressed: () {
                        task.start();
                      },
                    ),
                    buildButton(
                      icon: Icons.play_arrow_rounded,
                      visible: task.status == DownloadStatus.pause,
                      text: "继续",
                      onPressed: () {
                        task.resume();
                      },
                    ),
                    buildButton(
                      icon: Icons.pause_rounded,
                      visible: task.status == DownloadStatus.downloading,
                      text: "暂停",
                      onPressed: () {
                        task.pause();
                      },
                    ),
                    buildButton(
                      icon: Icons.cancel_outlined,
                      text: "取消",
                      onPressed: () {
                        task.cancel();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String parseStatus(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.cancel:
        return "已取消";
      case DownloadStatus.complete:
        return "已完成";
      case DownloadStatus.downloading:
        return "下载中";
      case DownloadStatus.error:
        return "下载失败";
      case DownloadStatus.errorLoad:
        return "无法读取信息";
      case DownloadStatus.loadding:
        return "读取信息中";
      case DownloadStatus.pause:
        return "暂停中";
      case DownloadStatus.pauseCellular:
        return "等待Wi-Fi";
      case DownloadStatus.wait:
        return "等待下载";
      case DownloadStatus.waitNetwork:
        return "等待网络连接";
      default:
        return status.toString();
    }
  }

  Widget buildButton({
    required String text,
    required IconData icon,
    Function()? onPressed,
    bool visible = true,
  }) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: AppStyle.edgeInsetsL4,
        child: TextButton.icon(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: const TextStyle(fontSize: 14),
          ),
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 16,
          ),
          label: Text(text),
        ),
      ),
    );
  }
}
