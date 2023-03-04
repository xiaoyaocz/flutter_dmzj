import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/home/category/comic_category_view.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_controller.dart';
import 'package:flutter_dmzj/modules/comic/home/latest/comic_latest_view.dart';
import 'package:flutter_dmzj/modules/comic/home/rank/comic_rank_view.dart';
import 'package:flutter_dmzj/modules/comic/home/recommend/comic_recommend_view.dart';
import 'package:flutter_dmzj/widgets/tab_appbar.dart';
import 'package:get/get.dart';

class ComicHomePage extends GetView<ComicHomeController> {
  const ComicHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          ComicRecommendView(),
          ComicLatestView(),
          ComicCategoryView(),
          ComicRankView(),
          const Center(
            child: Text("5"),
          ),
        ],
      ),
    );
  }
}
