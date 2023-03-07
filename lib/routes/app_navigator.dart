import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/routes/route_path.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppNavigator {
  /// 当前内容路由的名称
  static String currentContentRouteName = "/";

  /// 子路由ID
  static const int kSubNavigatorID = 1;

  /// 子路由Key
  static final GlobalKey<NavigatorState>? subNavigatorKey =
      Get.nestedKey(kSubNavigatorID);

  /// 子路由的Context
  static BuildContext get subNavigatorContext =>
      subNavigatorKey!.currentContext!;

  static void toPage(String name, {dynamic arg}) {
    Get.toNamed(name, arguments: arg);
  }

  /// 跳转子路由页面
  static void toContentPage(String name, {dynamic arg, bool replace = false}) {
    if (currentContentRouteName == name && replace) {
      Get.offAndToNamed(name, arguments: arg, id: kSubNavigatorID);
    } else {
      Get.toNamed(name, arguments: arg, id: kSubNavigatorID);
    }
  }

  /// 关闭页面
  /// 优先关闭主路由的页面
  static void closePage() {
    if (Navigator.canPop(Get.context!)) {
      Get.back();
    } else {
      Get.back(id: 1);
    }
  }

  /// 打开新闻详情
  static void toNewsDetail({
    required String url,
    String title = "资讯详情",
    int newsId = 0,
  }) {
    if (!url.startsWith("http:") && !url.startsWith("https:")) {
      SmartDialog.showToast("无法打开此此链接：$url");
      return;
    }
    //https://news.dmzj.com/article/77288.html
    if (url.contains("article/")) {
      toContentPage(RoutePath.kNewsDetail, arg: {
        "title": title,
        "newsUrl": url,
        "newsId": newsId,
      });
    } else {
      toWebView(url);
    }
  }

  /// 打开漫画详情
  static void toComicDetail(int id) {
    toContentPage(RoutePath.kComicDetail, arg: id);
  }

  /// 打开小说详情
  static void toNovelDetail(int id) {
    Log.w("打开小说:$id");
    toComment(objId: id, type: AppConstant.kTypeNovel);
  }

  /// 打开评论
  static void toComment({
    required int objId,
    required int type,
  }) {
    toContentPage(RoutePath.kComment, arg: {
      "objId": objId,
      "type": type,
    });
  }

  /// 打开WebView
  static void toWebView(String url) {
    if (Platform.isAndroid || Platform.isIOS) {
      toContentPage(RoutePath.kWebView, arg: url);
    } else {
      launchUrlString(url);
    }
  }

  /// 打开漫画分类详情
  static void toComicCategoryDetail(int id) {
    toContentPage(RoutePath.kComicCategoryDetail, arg: id);
  }

  /// 打开漫画作者详情
  static void toComicAuthorDetail(int id) {
    toContentPage(RoutePath.kComicAuthorDetail, arg: id);
  }

  /// 打开专题详情
  static void toSpecialDetail(int id) {
    toContentPage(RoutePath.kSpecialDetail, arg: id);
  }

  /// 打开漫画搜索
  static void toComicSearch({String keyword = ""}) {
    toContentPage(RoutePath.kComicSearch, arg: keyword);
  }

  /// 打开轻小说搜索
  static void toNovelSearch({String keyword = ""}) {
    toContentPage(RoutePath.kNovelSearch, arg: keyword);
  }

  /// 打开漫画分类详情
  static void toNovelCategoryDetail(int id) {
    toContentPage(RoutePath.kNovelCategoryDetail, arg: id);
  }

  /// 打开用户订阅
  /// - [type] 0=漫画,1=小说,2=新闻
  static void toUserSubscribe({int type = 0}) {
    toContentPage(RoutePath.kUserSubscribe, arg: type);
  }

  /// 打开用户历史记录
  /// - [type] 0=漫画,1=小说
  static void toUserHistory({int type = 0}) {
    toContentPage(RoutePath.kUserHistory, arg: type);
  }

  /// 打开本地历史记录
  /// - [type] 0=漫画,1=小说
  static void toLocalHistory({int type = 0}) {
    toContentPage(RoutePath.kLocalHistory, arg: type);
  }

  /// 打开漫画阅读
  static Future toComicReader({
    required int comicId,
    required String comicTitle,
    required String comicCover,
    required List<ComicDetailChapterItem> chapters,
    required ComicDetailChapterItem chapter,
  }) async {
    // 使用主路由跳转
    await Get.toNamed(RoutePath.kComicReader, arguments: {
      "comicId": comicId,
      "comicTitle": comicTitle,
      "comicCover": comicCover,
      "chapters": chapters,
      "chapter": chapter,
    });
  }

  static void showBottomSheet(
    Widget widget, {
    bool isScrollControlled = false,
  }) {
    showModalBottomSheet(
      context: subNavigatorContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      isScrollControlled: isScrollControlled,
      backgroundColor: Get.theme.cardColor,
      builder: (context) => widget,
      routeSettings: const RouteSettings(name: "/modalBottomSheet"),
    );
  }
}
