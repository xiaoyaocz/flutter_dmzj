import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';

import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:get/get.dart';

class ComicDownloadedView extends StatelessWidget {
  const ComicDownloadedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => EasyRefresh(
        header: const MaterialHeader(),
        onRefresh: () async {
          ComicDownloadService.instance.updateDownlaoded();
        },
        child: ListView.separated(
          itemCount: ComicDownloadService.instance.downloaded.length,
          separatorBuilder: (_, i) => Divider(
            endIndent: 12,
            indent: 12,
            color: Colors.grey.withOpacity(.2),
            height: 1,
          ),
          itemBuilder: (_, i) {
            var item = ComicDownloadService.instance.downloaded[i];
            return buildItem(item);
          },
        ),
      ),
    );
  }

  Widget buildItem(ComicDownloadedItem item) {
    return InkWell(
      onTap: () {
        AppNavigator.toComicDownloadDetail(item);
      },
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NetImage(
              item.comicCover,
              width: 60,
              borderRadius: 4,
            ),
            AppStyle.hGap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.comicName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppStyle.vGap4,
                  Text(
                    "已下载${item.chapterCount}章",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
