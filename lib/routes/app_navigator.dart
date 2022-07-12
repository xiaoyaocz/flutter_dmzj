import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigator {
  /// 当前内容路由的名称
  static String currentContentRouteName = "/";
  static final GlobalKey<NavigatorState>? contentKey = Get.nestedKey(1);

  static BuildContext get contentBuildContext => contentKey!.currentContext!;

  static void toPage(String name, {dynamic arg}) {
    Get.toNamed(name, arguments: arg);
  }

  static void toContentPage(String name, {dynamic arg, bool replace = true}) {
    if (currentContentRouteName == name && replace) {
      Get.offAndToNamed(name, arguments: arg, id: 1);
    } else {
      Get.toNamed(name, arguments: arg, id: 1);
    }
  }

  static void closePage() {
    if (Navigator.canPop(Get.context!)) {
      Get.back();
    } else {
      Get.back(id: 1);
    }
  }

  static void showBottomSheet(Widget widget) {
    showModalBottomSheet(
      context: contentKey!.currentContext!,
      builder: (context) => widget,
      routeSettings: const RouteSettings(name: "/modalBottomSheet"),
    );
  }
}
