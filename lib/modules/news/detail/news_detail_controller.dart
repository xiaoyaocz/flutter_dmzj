import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailController extends BaseController {
  final String newsUrl;
  final String title;
  final int newsId;
  NewsDetailController(
      {required this.newsUrl, this.title = "资讯详情", required this.newsId});
  WebViewController webViewController = WebViewController();

  @override
  void onInit() {
    initWebView();
    super.onInit();
  }

  void initWebView() {
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Get.isDarkMode
        ? AppColor.backgroundColorDark
        : AppColor.backgroundColor);
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          pageLoadding.value = true;
        },
        onPageFinished: (String url) async {
          try {
            //防止亮瞎24K钛合金狗眼
            if (Get.isDarkMode) {
              await webViewController.runJavaScript("""
document.body.style.background="#212121";
document.getElementsByClassName("min_box")[0].style.background="#212121";
document.getElementsByClassName("news_box")[0].style.color="#f1f2f6";
document.getElementsByClassName("min_box_tit")[0].style.color="#fff";
""");
            }
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
    webViewController.loadRequest(Uri.parse(newsUrl));
  }
}
