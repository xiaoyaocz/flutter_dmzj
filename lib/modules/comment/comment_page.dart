import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/comment/comment_list_view.dart';
import 'package:get/get.dart';

class CommentPage extends StatelessWidget {
  final int objId;
  final int type;
  const CommentPage({required this.objId, required this.type, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: TabBar(
              isScrollable: true,
              labelPadding: AppStyle.edgeInsetsH24,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor:
                  Get.isDarkMode ? Colors.white70 : Colors.black87,
              tabs: const [
                Tab(text: "最新评论"),
                Tab(text: "热门评论"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            CommentListView(objId: objId, type: type, isHot: false),
            CommentListView(objId: objId, type: type, isHot: true),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
