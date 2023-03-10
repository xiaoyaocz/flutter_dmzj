import 'package:flutter/material.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:get/get.dart';

class DownloadingView extends StatelessWidget {
  const DownloadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: ComicDownloadService.instance.taskQueues.length,
        itemBuilder: (_, i) {
          var task = ComicDownloadService.instance.taskQueues[i];
          return ListTile(
            title: Text(task.info.comicName),
            // subtitle: Text(task.info.chapterId),
            onTap: () {
              ComicDownloadService.instance.box.clear();
            },
          );
        },
      ),
    );
  }
}
