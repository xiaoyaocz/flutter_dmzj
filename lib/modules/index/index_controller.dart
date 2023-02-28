import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_page.dart';
import 'package:flutter_dmzj/modules/news/home/news_home_controller.dart';
import 'package:flutter_dmzj/modules/news/home/news_home_page.dart';
import 'package:flutter_dmzj/modules/user/user_home_page.dart';
import 'package:get/get.dart';
import 'package:multi_split_view/multi_split_view.dart';

class IndexController extends GetxController {
  final index = 0.obs;
  final showContent = false.obs;
  final GlobalKey indexKey = GlobalKey();
  final GlobalKey subRouterKey = GlobalKey();

  final MultiSplitViewController multiSplitViewController =
      MultiSplitViewController(areas: [
    Area(minimalSize: 400, size: 500),
  ]);
  final pages = [
    const ComicHomePage(),
    const SizedBox(),
    const Center(
      child: Text("轻小说"),
    ),
    const UserHomePage(),
  ];

  @override
  void onClose() {}

  void setIndex(i) {
    if (i == 1 && pages[i] is SizedBox) {
      Get.put(NewsHomeController());
      pages[i] = const NewsHomePage();
    }
    if (index.value == i) {
      EventBus.instance.emit<int>(EventBus.kBottomNavigationBarClicked, i);
    }
    index.value = i;
  }
}
