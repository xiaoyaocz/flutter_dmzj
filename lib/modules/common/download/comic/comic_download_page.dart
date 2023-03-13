import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/common/download/comic/comic_downloaded_view.dart';
import 'package:flutter_dmzj/modules/common/download/comic/comic_downloading_view.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:get/get.dart';

class ComicDownloadPage extends StatelessWidget {
  final int type;
  const ComicDownloadPage(this.type, {super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: type,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 56),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor:
                  Get.isDarkMode ? Colors.white70 : Colors.black87,
              tabs: [
                const Tab(text: "已完成"),
                Obx(
                  () => Tab(
                      text: ComicDownloadService.instance.taskQueues.isEmpty
                          ? "下载中"
                          : "下载中(${ComicDownloadService.instance.taskQueues.length})"),
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ComicDownloadedView(),
            ComicDownloadingView(),
          ],
        ),
      ),
    );
  }
}
