import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/news/detail/news_detail_controller.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsUrl;
  final int newsId;
  final String title;
  final NewsDetailController controller;
  NewsDetailPage({
    required this.newsUrl,
    this.title = "资讯详情",
    required this.newsId,
    Key? key,
  })  : controller = Get.put(
          NewsDetailController(id: newsId, newsUrl: newsUrl, title: title),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.newsTitle.value)),
        actions: [
          IconButton(
            onPressed: controller.share,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Stack(
        children: [
          (Platform.isAndroid || Platform.isIOS)
              ? Obx(
                  () => Offstage(
                    offstage: controller.pageLoadding.value,
                    child: WebViewWidget(
                      controller: controller.webViewController!,
                    ),
                  ),
                )
              : buildHtml(),
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
                onRefresh: controller.refershContent,
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
                child: Obx(
                  () => TextButton.icon(
                    onPressed: controller.like,
                    icon: Icon(
                      controller.liked.value
                          ? Remix.thumb_up_fill
                          : Remix.thumb_up_line,
                      size: 20,
                    ),
                    label: Text(controller.moodAmount > 0
                        ? "${controller.moodAmount}"
                        : "点赞"),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => TextButton.icon(
                    onPressed: controller.comment,
                    icon: const Icon(
                      Remix.chat_2_line,
                      size: 20,
                    ),
                    label: Text(controller.commentAmount > 0
                        ? "${controller.commentAmount}"
                        : "评论"),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => TextButton.icon(
                    onPressed: controller.collect,
                    icon: Icon(
                      controller.collected.value
                          ? Remix.star_fill
                          : Remix.star_line,
                      size: 20,
                    ),
                    label: Text(controller.collected.value ? "已收藏" : "收藏"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: controller.photoView,
                  icon: const Icon(
                    Remix.image_2_line,
                    size: 20,
                  ),
                  label: const Text("图集"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHtml() {
    return Obx(
      () => ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          Text(
            controller.title,
            style: Get.textTheme.titleLarge,
          ),
          AppStyle.vGap4,
          Text(
            "${controller.author.value}    ${controller.src.value}    ${controller.time.value}",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          AppStyle.vGap12,
          HtmlWidget(
            controller.htmlContent.value,
            customWidgetBuilder: (e) {
              if (e.localName == "img") {
                var imgSrc = e.attributes["src"];
                imgSrc ??= e.attributes["data-original"];
                return GestureDetector(
                  child: NetImage(
                    imgSrc!,
                    borderRadius: 4,
                  ),
                  onTap: () {
                    controller.showImageView(imgSrc ?? "");
                  },
                );
              }

              return null;
            },
            onTapUrl: controller.onTapUrl,
          ),
        ],
      ),
    );
  }
}
