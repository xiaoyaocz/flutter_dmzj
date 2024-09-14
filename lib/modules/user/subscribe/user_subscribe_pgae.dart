import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/user/subscribe/comic/comic_subscribe_view.dart';
import 'package:flutter_dmzj/modules/user/subscribe/novel/novel_subscribe_view.dart';
import 'package:flutter_dmzj/modules/user/subscribe/user_subscribe_controller.dart';
import 'package:get/get.dart';

class UserSubscribePage extends StatelessWidget {
  final UserSubscribeController controller;
  final int type;
  UserSubscribePage({this.type = 0, super.key})
      : controller = Get.put(
          UserSubscribeController(type),
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
            tabAlignment: TabAlignment.start,
            labelPadding: AppStyle.edgeInsetsH24,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor:
                Get.isDarkMode ? Colors.white70 : Colors.black87,
            tabs: const [
              Tab(text: "漫画"),
              Tab(text: "小说"),
              // Tab(text: "新闻"),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          ComicSubscribeView(),
          NovelSubscribeView(),
          // NewsSubscribeView(),
        ],
      ),
    );
  }
}
