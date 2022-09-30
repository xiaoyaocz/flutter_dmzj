import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_controller.dart';
import 'package:flutter_dmzj/modules/comic/home/recommend/comic_recommend_view.dart';
import 'package:flutter_dmzj/widgets/tab_appbar.dart';
import 'package:get/get.dart';

class ComicHomePage extends GetView<ComicHomeController> {
  const ComicHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabAppBar(
          tabs: const [
            Tab(text: "推荐"),
            Tab(text: "更新"),
            Tab(text: "分类"),
            Tab(text: "排行"),
            Tab(text: "专题"),
          ],
          controller: controller.tabController,
          action: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            ComicRecommendView(),
            const Center(
              child: Text("2"),
            ),
            const Center(
              child: Text("3"),
            ),
            const Center(
              child: Text("4"),
            ),
            const Center(
              child: Text("5"),
            ),
          ],
        ),
      ),
    );
  }
}
