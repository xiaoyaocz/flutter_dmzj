import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_page.dart';
import 'package:flutter_dmzj/modules/user/user_home_page.dart';
import 'package:get/get.dart';
import 'package:multi_split_view/multi_split_view.dart';

class IndexController extends GetxController {
  final index = 0.obs;
  final showContent = false.obs;
  final GlobalKey indexKey = GlobalKey();
  final MultiSplitViewController multiSplitViewController =
      MultiSplitViewController(areas: [
    Area(minimalSize: 400, size: 500),
  ]);
  final pages = [
    const ComicHomePage(),
    const Center(
      child: Text("测试"),
    ),
    const Center(
      child: Text("轻小说"),
    ),
    const UserHomePage(),
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}

  void setIndex(i) {
    index.value = i;
  }
}
