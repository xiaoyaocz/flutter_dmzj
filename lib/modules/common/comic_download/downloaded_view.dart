import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:get/get.dart';

class DownloadedView extends StatelessWidget {
  const DownloadedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => EasyRefresh(
        onRefresh: () async {
          ComicDownloadService.instance.updateDownlaoded();
        },
        child: ListView.builder(
          itemCount: ComicDownloadService.instance.downloaded.length,
          itemBuilder: (_, i) {
            var info = ComicDownloadService.instance.downloaded[i];
            return ListTile(
              title: Text(info.comicName),
              subtitle: Text(info.chapterCount.toString()),
              onTap: () async {},
            );
          },
        ),
      ),
    );
  }
}
