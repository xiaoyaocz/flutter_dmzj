import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/widgets/user_comment_widget.dart';
import 'package:provider/provider.dart';

class MyCommentPage extends StatefulWidget {
  MyCommentPage({Key key}) : super(key: key);

  @override
  _MyCommentPageState createState() => _MyCommentPageState();
}

class _MyCommentPageState extends State<MyCommentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text("我的评论"),bottom: TabBar(tabs: [
          Tab(text:"漫画"),
          Tab(text:"小说"),
          Tab(text:"新闻"),
        ]),),
        body: TabBarView(children: [
          UserCommentWidget(0, int.parse( Provider.of<AppUserInfo>(context).loginInfo.uid??0) ),
          UserCommentWidget(1, int.parse( Provider.of<AppUserInfo>(context).loginInfo.uid??0) ),
          UserCommentWidget(2, int.parse( Provider.of<AppUserInfo>(context).loginInfo.uid??0) )
        ]),
      ),
    );
  }
}
