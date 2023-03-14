import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';

import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_empty_widget.dart';
import 'package:get/get.dart';

class NovelDownloadedView extends StatelessWidget {
  const NovelDownloadedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(),
            onRefresh: () async {
              NovelDownloadService.instance.updateDownlaoded();
            },
            child: ListView.separated(
              itemCount: NovelDownloadService.instance.downloaded.length,
              separatorBuilder: (_, i) => Divider(
                endIndent: 12,
                indent: 12,
                color: Colors.grey.withOpacity(.2),
                height: 1,
              ),
              itemBuilder: (_, i) {
                var item = NovelDownloadService.instance.downloaded[i];
                return buildItem(item);
              },
            ),
          ),
          Offstage(
            offstage: NovelDownloadService.instance.downloaded.isNotEmpty,
            child: AppEmptyWidget(
              onRefresh: () {
                NovelDownloadService.instance.updateDownlaoded();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(NovelDownloadedItem item) {
    return InkWell(
      onTap: () {
        AppNavigator.toNovelDownloadDetail(item);
      },
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NetImage(
              item.novelCover,
              width: 60,
              borderRadius: 4,
            ),
            AppStyle.hGap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.novelName,
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
