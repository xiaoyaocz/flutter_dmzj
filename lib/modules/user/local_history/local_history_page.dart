import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/user/local_history/comic/comic_history_view.dart';

import 'package:flutter_dmzj/modules/user/local_history/local_history_controller.dart';
import 'package:flutter_dmzj/modules/user/local_history/novel/novel_history_view.dart';
import 'package:get/get.dart';

class LocalHistoryPage extends StatelessWidget {
  final LocalHistoryController controller;
  final int type;
  LocalHistoryPage({this.type = 0, super.key})
      : controller = Get.put(
          LocalHistoryController(type),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 56),
          child: TabBar(
            controller: controller.tabController,
            isScrollable: true,
            labelPadding: AppStyle.edgeInsetsH24,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor:
                Get.isDarkMode ? Colors.white70 : Colors.black87,
            tabs: const [
              Tab(text: "漫画记录"),
              Tab(text: "小说记录"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          LocalComicHistoryView(),
          LocalNovelHistoryView(),
        ],
      ),
    );
  }
}
