import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_specia_datail_model.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class ComicSpecialDetailPage extends StatefulWidget {
  final int id;
  ComicSpecialDetailPage(this.id, {Key key}) : super(key: key);

  @override
  _ComicSpecialDetailPageState createState() => _ComicSpecialDetailPageState();
}

class _ComicSpecialDetailPageState extends State<ComicSpecialDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  ComicSpecia _detail;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _detail != null
        ? DefaultTabController(
            length: 3, // This is the number of tabs.
            child: Scaffold(
              appBar: AppBar(
                title: Text(_detail.title),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () => Share.share(
                          "${_detail.title}\r\nhttp://m.dmzj.com/zhuanti/${_detail.page_url}"))
                ],
                bottom: TabBar(
                    tabs: [Tab(text: "介绍"), Tab(text: "漫画"), Tab(text: "评论")]),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Utils.createCacheImage(
                            _detail.mobile_header_pic, 710, 350),
                        SizedBox(height: 12),
                        Text(
                          _detail.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Text(_detail.description)
                      ],
                    ),
                  ),
                  ListView(
                    children: _detail.comics
                        .map<Widget>((f) => createItem(f))
                        .toList(),
                  ),
                  CommentWidget(2, widget.id),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(),
            body: Center(
              child: _loading ? CircularProgressIndicator() : Container(),
            ),
          );
  }

  Widget createItem(ComicSpeciaItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.id, 1);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 80,
              child: Utils.createCacheImage(item.cover, 270, 360),
            ),
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
      var response =
          await http.get(Uri.parse(Api.comicSpeciaDetail(widget.id)));

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
