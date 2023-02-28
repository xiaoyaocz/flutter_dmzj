import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/modules/comic/home/recommend/comic_recommend_controller.dart';
import 'package:get/get.dart';

class ComicHomeController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  StreamSubscription<dynamic>? streamSubscription;

  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
      (index) {
        if (index == 0) {
          refreshOrScrollTop();
        }
      },
    );
    tabController = TabController(length: 5, vsync: this);

    super.onInit();
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController? controller;
    if (tabIndex == 0) {
      controller = Get.find<ComicRecommendController>();
    }
    controller?.scrollToTopOrRefresh();
  }
}
