import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_history_item.dart';
import 'package:flutter_dmzj/models/novel/novel_history_item.dart';
import 'package:flutter_dmzj/sql/comic_history.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:http/http.dart' as http;

class UserHistoryPage extends StatefulWidget {
  UserHistoryPage({Key key}) : super(key: key);

  @override
  _UserHistoryPageState createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("历史记录"),
            bottom: TabBar(tabs: [Tab(text: "漫画"), Tab(text: "轻小说")]),
          ),
          body: TabBarView(children: [
            HistoryTabItem(0),
            HistoryTabItem(1),
          ]),
        ));
  }
}

class HistoryTabItem extends StatefulWidget {
  final int type;
  HistoryTabItem(this.type, {Key key}) : super(key: key);

  @override
  _HistoryTabItemState createState() => _HistoryTabItemState();
}

class _HistoryTabItemState extends State<HistoryTabItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (widget.type == 0) {
      loadDataComic();
    } else {
      loadDataNovel();
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _loading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : widget.type == 0
            ? EasyRefresh(
                onRefresh: () async {
                  if (widget.type == 0) {
                    await loadDataComic();
                  } else {
                    await loadDataNovel();
                  }
                },
                header: MaterialHeader(),
                child: ListView(
                    children: _list.map(
                  (f) {
                    return createItem(f);
                  },
                ).toList()),
              )
            : EasyRefresh(
                onRefresh: () async {
                  if (widget.type == 0) {
                    await loadDataComic();
                  } else {
                    await loadDataNovel();
                  }
                },
                header: MaterialHeader(),
                child: ListView(
                    children: _novelList.map(
                  (f) {
                    return createNovelItem(f);
                  },
                ).toList()),
              );
  }

  Widget createItem(ComicHistoryItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.comic_id, 1,
            url: item.cover, title: item.comic_name);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 80,
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
                      item.comic_name,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text("看到" + item.chapter_name,
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                        DateUtil.formatDate(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.viewing_time * 1000),
                            format: "yyyy-MM-dd HH:mm:ss"),
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createNovelItem(NovelHistoryItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, int.parse(item.lnovel_id), 2,
            url: item.cover, title: item.novel_name);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 80,
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
                      item.novel_name,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                        "看到" +
                            item.volume_name.toString() +
                            " · " +
                            (item.chapter_name.toString() ?? ""),
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                        DateUtil.formatDate(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.viewing_time * 1000),
                            format: "yyyy-MM-dd HH:mm:ss"),
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<ComicHistoryItem> _list = [];
  List<NovelHistoryItem> _novelList = [];
  bool _loading = false;
  //int _page = 0;
  Future loadDataNovel() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });

      var response =
          await http.get(Api.userNovelHistory(ConfigHelper.getUserInfo().uid));
      List jsonMap = jsonDecode(response.body);
      // print(jsonMap[1].toString());
      List<NovelHistoryItem> detail =
          jsonMap.map((i) => NovelHistoryItem.fromJson(i)).toList();
      // print(detail[1].chapter_name);
      if (detail != null) {
        for (var item in detail) {
          ConfigHelper.setNovelHistory(
              int.parse(item.lnovel_id), item.chapter_id);
        }
        setState(() {
          _novelList = detail;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future loadDataComic() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });

      var response =
          await http.get(Api.userComicHistory(ConfigHelper.getUserInfo().uid));
      List jsonMap = jsonDecode(response.body);
      List<ComicHistoryItem> detail =
          jsonMap.map((i) => ComicHistoryItem.fromJson(i)).toList();
      if (detail != null && detail.length != 0) {
        for (var item in detail) {
          var historyItem = await ComicHistoryProvider.getItem(item.comic_id);
          if (historyItem != null) {
            historyItem.chapter_id = item.chapter_id;
            historyItem.page = item.progress?.toDouble() ?? 1;
            await ComicHistoryProvider.update(historyItem);
          } else {
            await ComicHistoryProvider.insert(ComicHistory(item.comic_id,
                item.chapter_id, item.progress?.toDouble() ?? 1, 1));
          }

          //ConfigHelper.setComicHistory(item.comic_id, item.chapter_id);
        }
        //_comicPage++;
        setState(() {
          _list = detail;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
