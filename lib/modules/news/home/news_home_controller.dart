import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/models/news/news_tag_model.dart';
import 'package:flutter_dmzj/modules/news/home/news_list_controller.dart';
import 'package:flutter_dmzj/requests/news_request.dart';
import 'package:get/get.dart';

class NewsHomeController extends GetxController
    with GetTickerProviderStateMixin {
  NewsRequest request = NewsRequest();
  late TabController tabController;
  var loadding = true;
  List<NewsTagModel> categores = [];
  var error = false;
  var errorMsg = "";

  StreamSubscription<dynamic>? streamSubscription;

  @override
  void onInit() {
    streamSubscription = EventBus.instance.listen(
      EventBus.kBottomNavigationBarClicked,
      (index) {
        if (index == 1) {
          refreshOrScrollTop();
        }
      },
    );
    loadCategores();
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  void loadCategores() async {
    try {
      loadding = true;
      error = false;
      update();
      var category = await request.category();
      category.insert(0, NewsTagModel(id: 0, name: "最新"));
      tabController = TabController(length: category.length, vsync: this);

      categores = category;
    } catch (e) {
      errorMsg = e.toString();
      error = true;
    } finally {
      loadding = false;
      update();
    }
  }

  void refreshOrScrollTop() {
    var tabIndex = tabController.index;
    BasePageController controller;
    controller = Get.find<NewsListController>(tag: "${categores[tabIndex].id}");
    controller.scrollToTopOrRefresh();
  }
}
