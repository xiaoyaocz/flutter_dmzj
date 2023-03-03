import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/dialog_utils.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/requests/news_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/parsing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailController extends BaseController {
  final String newsUrl;
  final String title;
  final int id;
  final NewsRequest request = NewsRequest();
  NewsDetailController(
      {required this.newsUrl, this.title = "资讯详情", required this.id}) {
    newsTitle.value = title;
    if (id == 0) {
      newsId = int.tryParse(
              RegExp(r"/(\d+).html").firstMatch(newsUrl)?.group(1) ?? "0") ??
          0;
    } else {
      newsId = id;
    }
  }
  WebViewController? webViewController =
      (Platform.isAndroid || Platform.isIOS) ? WebViewController() : null;

  /// 评论数
  var commentAmount = 0.obs;

  /// 点赞数
  var moodAmount = 0.obs;

  /// 是否点过赞
  var liked = false.obs;

  /// 是否已经收藏
  var collected = false.obs;

  var newsId = 0;

  var newsTitle = "资讯详情".obs;

  var htmlContent = "".obs;
  var author = "".obs;
  var photo = "".obs;
  var src = "".obs;
  var time = "".obs;

  var images = <String>[];

  @override
  void onInit() {
    liked.value = DBService.instance.newsLikeBox.containsKey(newsId);
    if (Platform.isAndroid || Platform.isIOS) {
      initWebView();
    } else {
      loadHtml();
    }
    loadStat();
    checkCollected();
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
            //当Web没有滚动条时，图片不会加载，这里手动给他加载出来
            await webViewController!.runJavaScript("""
\$('.news_box img:lt(5)').each(function () {
   \$(this).lazyload({
     effect: "fadeIn"
   });
});""");
            //读取全部的图片
            var imagesResult =
                await webViewController?.runJavaScriptReturningResult(r'''
function getImgLinks(){
	var imgLinks = [];
  $('img').each(function() {
    var src = $(this).attr('data-original');
    if (src && src.startsWith('https://images')) {
      imgLinks.push(src);
    }
  });
  console.log(imgLinks);
  return imgLinks;
}
getImgLinks();
''');
            if (imagesResult != null && imagesResult != "null") {
              List list = json.decode(imagesResult.toString());
              images = list.map((e) => e.toString()).toList();
            }
          } finally {
            pageLoadding.value = false;
          }
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) async {
          onTapUrl(request.url);
          return NavigationDecision.prevent;
        },
      ),
    );
    Log.d(newsUrl);

    webViewController!.loadRequest(
        Uri.parse("https://v3api.dmzj.com/article/show/v2/$newsId.html"));
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

      var imgList = htmlDocument.documentElement?.querySelectorAll('img');
      var imagesList = <String>[];
      for (html.Element img in imgList ?? []) {
        var imgSrc = img.getAttribute("data-original");
        if (imgSrc != null) {
          imagesList.add(imgSrc);
        }
      }
      images = imagesList;
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  void loadStat() async {
    try {
      var result = await request.stat(newsId);
      commentAmount.value = result.commentAmount;
      moodAmount.value = result.moodAmount;
      newsTitle.value = result.title;
    } catch (e) {
      SmartDialog.showToast(e.toString());
      SmartDialog.showToast("读取新闻数据失败：$e");
    }
  }

  void checkCollected() async {
    if (!UserService.instance.logined.value) {
      return;
    }
    try {
      collected.value = await request.checkCollect(newsId);
    } catch (e) {
      Log.logPrint(e);
      SmartDialog.showToast("检查用户收藏状态失败：$e");
    }
  }

  void refershContent() {
    webViewController!.reload();
  }

  void collect() async {
    if (!await UserService.instance.login()) {
      return;
    }
    try {
      SmartDialog.showLoading();
      await (collected.value
          ? request.delCollect(newsId)
          : request.collect(newsId));
      collected.value = !collected.value;
    } catch (e) {
      Log.logPrint(e);
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  void like() async {
    if (liked.value) {
      SmartDialog.showToast("已经点过赞了");
      return;
    }
    try {
      SmartDialog.showLoading();
      await request.like(newsId);
      liked.value = true;
      moodAmount.value += 1;
      DBService.instance.newsLikeBox.put(newsId, true);
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }

  void share() {
    Share.share("$title\n$newsUrl");
  }

  void comment() async {
    AppNavigator.toComment(objId: newsId, type: AppConstant.kTypeNews);
  }

  void photoView() {
    DialogUtils.showImageViewer(0, images);
  }

  void showImageView(String imgSrc) {
    if (imgSrc.isEmpty) {
      return;
    }
    if (images.contains(imgSrc)) {
      DialogUtils.showImageViewer(
        images.indexOf(imgSrc),
        images,
      );
    } else {
      DialogUtils.showImageViewer(0, [imgSrc]);
    }
  }

  Future<bool> onTapUrl(url) async {
    var uri = Uri.parse(url);
    Log.d(url);
    if (uri.scheme == "dmzjimage") {
      //打开图片
      showImageView(uri.queryParameters['src'].toString());
    } else if (uri.scheme == "dmzjandroid") {
      var id = int.tryParse(uri.queryParameters["id"].toString()) ?? 0;
      if (uri.path == "/cartoon_description") {
        AppNavigator.toComicDetail(id);
      } else {
        AppNavigator.toNovelDetail(id);
      }
    } else if (uri.scheme == "https" || uri.scheme == "http") {
      if (uri.path.contains("article/")) {
        AppNavigator.toNewsDetail(url: url);
      } else {
        AppNavigator.toWebView(url);
      }

      return true;
    }

    return true;
  }
}
