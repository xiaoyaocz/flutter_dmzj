import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class ComicDetailV2Page extends StatelessWidget {
  final comicId;
  const ComicDetailV2Page(this.comicId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("久保同学不放过我"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("详情"),
              ),
              Tab(
                child: Text("评论"),
              ),
              Tab(
                child: Text("相关"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: EdgeInsets.all(8),
              children: [
                buildDetail(context),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            CommentWidget(4, 50425),
            Container(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: buildBottom(context),
        ),
      ),
    );
  }

  Widget buildDetail(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Utils.showImageViewDialog(context,
                    "https://images.dmzj.com/webpic/19/200203jbtxbfgw.jpg"),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 100,
                    child: Utils.createCacheImage(
                        "https://images.dmzj.com/webpic/19/200203jbtxbfgw.jpg",
                        270,
                        360),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildInfo(
                      context,
                      title: "尾田荣一郎",
                      iconData: Icons.account_circle,
                    ),
                    _buildInfo(
                      context,
                      title: "冒险/热血/高清单行",
                      iconData: Icons.category,
                    ),
                    _buildInfo(
                      context,
                      title: "人气 16767",
                      iconData: Icons.whatshot,
                    ),
                    _buildInfo(
                      context,
                      title: "订阅 2222",
                      iconData: Icons.favorite,
                    ),
                    _buildInfo(
                      context,
                      title: "2020/10/14 连载中",
                      iconData: Icons.schedule,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "财富，权力，曾经拥有一切的海贼王戈尔多·罗杰，在临死前畱下暸一句话：“想要我的财富吗？那就去找吧，我的一切都在那裏，在那伟大的航道！”于是越来越多的人奔嚮大海，驶入伟大的航道，世界迎来暸大海贼时代！很多年后，一个小孩对这一个断暸手臂的海贼髮誓：“我一定要成为海贼王！”于是10年后，一个伟大的传说开始暸。这是个关于一群爱做梦孩子的故事，他们拥有热情，他们拥有毅力，他们拥有伙伴……",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(
    BuildContext context, {
    @required String title,
    IconData iconData = Icons.tag,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(4),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 12,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.play_circle_outline),
              label: Text("阅读"),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
              label: Text("收藏"),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.file_download),
              label: Text("下载"),
            ),
          ),
        ],
      ),
    );
  }
}
