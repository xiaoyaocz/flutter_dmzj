import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/modules/novel/home/category/novel_category_controller.dart';
import 'package:flutter_dmzj/modules/novel/home/latest/novel_latest_controller.dart';
import 'package:flutter_dmzj/modules/novel/home/rank/novel_rank_controller.dart';
import 'package:flutter_dmzj/modules/novel/home/recommend/novel_recommend_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:get/get.dart';

class NovelHomeController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  StreamSubscription<dynamic>? streamSubscription;

  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
      (index) {
        if (index == 2) {
          refreshOrScrollTop();
        }
      },
    );
    tabController = TabController(length: 3, vsync: this);

    super.onInit();
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController? controller;
    if (tabIndex == 0) {
      controller = Get.find<NovelRecommendController>();
    } else if (tabIndex == 1) {
      controller = Get.find<NovelLatestController>();
    } else if (tabIndex == 2) {
      controller = Get.find<NovelCategoryController>();
    } else if (tabIndex == 3) {
      controller = Get.find<NovelRankController>();
    }
    controller?.scrollToTopOrRefresh();
  }

  void search() {
    AppNavigator.toNovelSearch();
  }
}
