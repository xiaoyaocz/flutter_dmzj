import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSubscribeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int type;
  UserSubscribeController(this.type);
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this, initialIndex: type);

    super.onInit();
  }
}
