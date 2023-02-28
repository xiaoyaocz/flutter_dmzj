import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/news/detail/news_detail_controller.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:get/get.dart';
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
          NewsDetailController(newsId: newsId, newsUrl: newsUrl, title: title),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
      ),
      body: Stack(
        children: [
          Obx(
            () => Offstage(
              offstage: controller.pageLoadding.value,
              child: WebViewWidget(
                controller: controller.webViewController,
              ),
            ),
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
                onRefresh: () => controller.webViewController.reload(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
