import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComicHomeController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    super.onInit();
  }
}
