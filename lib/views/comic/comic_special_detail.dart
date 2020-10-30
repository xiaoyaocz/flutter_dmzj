import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_specia_datail_model.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:flutter_dmzj/widgets/stickyTabBarDelegate.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class ComicSpecialDetailPage extends StatefulWidget {
  final int id;
  final String title;
  final String coverUrl;
  ComicSpecialDetailPage(this.id, this.title, this.coverUrl, {Key key})
      : super(key: key);

  @override
  _ComicSpecialDetailPageState createState() => _ComicSpecialDetailPageState();
}

class _ComicSpecialDetailPageState extends State<ComicSpecialDetailPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  TabController _tabController;
  bool get wantKeepAlive => true;
  ComicSpecia _detail;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: 2, vsync: this);
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              pinned: true,
              expandedHeight: 180,
              title: Text(widget.title),
              flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                tag: widget.id,
                child: Utils.createCacheImage(
                    widget.coverUrl, MediaQuery.of(context).size.width, 350,
                    fit: BoxFit.cover),
              )),
              actions: (_detail != null)
                  ? <Widget>[
                      IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () => Share.share(
                              "${_detail.title}\r\nhttp://m.dmzj.com/zhuanti/${_detail.page_url}"))
                    ]
                  : null,
            ),
            SliverToBoxAdapter(
              child: (_detail != null)
                  ? Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("        " + _detail.description),
                    )
                  : Text(""),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: TabBar(
                    controller: _tabController,
                    indicatorWeight: 4,
                    indicatorColor: Theme.of(context).indicatorColor,
                    tabs: [Tab(text: "漫画"), Tab(text: "评论")]),
              ),
            ),
          ];
        },
        body: (_detail != null)
            ? TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    children: _detail.comics
                        .map<Widget>((f) => createItem(f))
                        .toList(),
                  ),
                  CommentWidget(2, widget.id),
                ],
              )
            : _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(24),
                    child: Text("读取专栏失败"),
                  ),
      ),
    );
  }

  Widget createItem(ComicSpeciaItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.id, 1, url: item.cover, title: item.name);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 80,
                child: Hero(
                  tag: item.id,
                  child: Utils.createCacheImage(item.cover, 270, 360),
                )),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(item.recommend_brief,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      maxLines: 1),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    item.recommend_reason,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                    maxLines: 3,
                  )
                ],
              ),
            ),
            Center(
              child: IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    UserHelper.comicSubscribe(item.id);
                  }),
            )
          ],
        ),
      ),
    );
  }

  bool _loading = false;

  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Api.comicSpeciaDetail(widget.id));

      var jsonMap = jsonDecode(response.body);

      ComicSpecia detail = ComicSpecia.fromJson(jsonMap);
      if (detail.title == null || detail.title == "") {
        setState(() {
          _loading = false;
        });
        return;
      }
      setState(() {
        _detail = detail;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
