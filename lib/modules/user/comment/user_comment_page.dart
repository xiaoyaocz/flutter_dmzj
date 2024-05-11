import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/user/comment/user_comment_view.dart';
import 'package:get/get.dart';

class UserCommentPage extends StatelessWidget {
  final int userId;
  const UserCommentPage(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 56),
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelPadding: AppStyle.edgeInsetsH24,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor:
                  Get.isDarkMode ? Colors.white70 : Colors.black87,
              tabs: const [
                Tab(text: "漫画"),
                Tab(text: "小说"),
                Tab(text: "新闻"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            UserCommentView(type: 0, userId: userId),
            UserCommentView(type: 1, userId: userId),
            UserCommentView(type: 2, userId: userId),
          ],
        ),
      ),
    );
  }
}
