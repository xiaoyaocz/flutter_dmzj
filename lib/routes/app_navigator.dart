import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  static void showBottomSheet(Widget widget) {
    showModalBottomSheet(
      context: subNavigatorContext,
      builder: (context) => widget,
      routeSettings: const RouteSettings(name: "/modalBottomSheet"),
    );
  }
}
