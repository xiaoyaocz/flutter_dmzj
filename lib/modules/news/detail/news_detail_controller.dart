import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/requests/comment_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/widgets/comment_item_widget.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/parsing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailController extends BaseController {
  final String newsUrl;
  final String title;
  final int newsId;
  NewsDetailController(
      {required this.newsUrl, this.title = "资讯详情", required this.newsId});
  WebViewController? webViewController =
      (Platform.isAndroid || Platform.isIOS) ? WebViewController() : null;

  var htmlContent = "".obs;
  var author = "".obs;
  var photo = "".obs;
  var src = "".obs;
  var time = "".obs;

  @override
  void onInit() {
    if (Platform.isAndroid || Platform.isIOS) {
      initWebView();
    } else {
      loadHtml();
    }

    super.onInit();
  }

  void initWebView() {
    webViewController!.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController!.setBackgroundColor(Get.isDarkMode
        ? AppColor.backgroundColorDark
        : AppColor.backgroundColor);
    webViewController!.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          pageLoadding.value = true;
        },
        onPageFinished: (String url) async {
          try {
            //防止亮瞎24K钛合金狗眼
            if (Get.isDarkMode) {
              await webViewController!.runJavaScript("""
document.body.style.background="#212121";
document.getElementsByClassName("min_box")[0].style.background="#212121";
document.getElementsByClassName("news_box")[0].style.color="#f1f2f6";
document.getElementsByClassName("min_box_tit")[0].style.color="#fff";
""");
            }
            //加载前5张图片
            await webViewController!.runJavaScript("""
\$('.news_box img:lt(5)').each(function () {
   \$(this).lazyload({
     effect: "fadeIn"
   });
});""");
          } finally {
            pageLoadding.value = false;
          }
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          var uri = Uri.parse(request.url);
          Log.d(request.url);
          if (uri.scheme == "dmzjimage") {
            //打开图片
          } else if (uri.scheme == "dmzjandroid") {
            //打开漫画或小说
          } else if (uri.scheme == "https" || uri.scheme == "http") {
            AppNavigator.toWebView(request.url);
            return NavigationDecision.prevent;
          }

          return NavigationDecision.prevent;
        },
      ),
    );
    webViewController!.loadRequest(Uri.parse(newsUrl));
  }

  void loadHtml() async {
    try {
      pageError.value = false;
      pageLoadding.value = true;
      var result = await Dio().get(
        newsUrl,
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      final htmlDocument = parseHtmlDocument(result.data);
      var news = htmlDocument.documentElement!.querySelector('.news_box');

      htmlContent.value = news!.innerHtml ?? "";

      author.value =
          htmlDocument.documentElement?.querySelector('.txt1')?.innerText ?? "";
      src.value =
          htmlDocument.documentElement?.querySelector('.txt2')?.innerText ?? "";
      time.value =
          htmlDocument.documentElement?.querySelector('.txt3')?.innerText ?? "";
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  void refershContent() {
    webViewController!.reload();
  }

  void share() {
    Share.share("$title\n$newsUrl");
  }

  void comment() async {
    AppNavigator.toComment(objId: newsId, type: AppConstant.kTypeNews);
  }
}
