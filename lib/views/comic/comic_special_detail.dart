import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_specia_datail_model.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
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
  int _index = 0;
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
      body: IndexedStack(
        index: _index,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                title: Text(widget.title),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.id,
                    child: Utils.createCacheImage(
                        widget.coverUrl, MediaQuery.of(context).size.width, 350,
                        fit: BoxFit.cover),
                  ),
                ),
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return createItem(_detail.comics[index]);
                  },
                  childCount: _detail.comics.length,
                ),
              )
            ],
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("评论"),
            ),
            body: SafeArea(
                child: (_detail != null)
                    ? CommentWidget(2, widget.id)
                    : Container()),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          heroTag: "comic_float",
          child: AnimatedCrossFade(
            crossFadeState: _index == 0
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 200),
            firstChild: Icon(Icons.arrow_forward),
            secondChild: Icon(Icons.arrow_back),
          ),
          onPressed: () {
            setState(() {
              switch (_index) {
                case 0:
                  _index = 1;
                  break;
                case 1:
                  _index = 0;
                  break;
                default:
                  _index = 0;
              }
            });
          }),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            TextButton(
              child: Text("详情"),
              onPressed: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            TextButton(
              child: Text("评论"),
              onPressed: () {
                setState(() {
                  _index = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createItem(ComicSpeciaItem item) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: Text(
            item.recommend_reason,
            style: TextStyle(color: Colors.grey, fontSize: 14),
            maxLines: 3,
          ),
        ),
        Utils.createDetailWidget(
          item.id,
          1,
          item.cover,
          item.name,
          context,
          category: item.recommend_brief,
        ),
      ],
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
