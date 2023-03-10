import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int type;
  final int objId;
  CommentController(this.type, this.objId);
  late TabController tabController = TabController(length: 2, vsync: this);
}
