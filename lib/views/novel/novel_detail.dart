import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';
import 'package:flutter_dmzj/models/novel/novel_volume_item.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NovelDetailPage extends StatefulWidget {
  final int novelId;
  final String coverUrl;
  NovelDetailPage(this.novelId, this.coverUrl, {Key key}) : super(key: key);

  @override
  _NovelDetailPageState createState() => _NovelDetailPageState();
}

class _NovelDetailPageState extends State<NovelDetailPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  double detailExpandHeight = 150 + kToolbarHeight + 24;

  ScrollController _scrollController;
  int _index = 0;
  @override
  bool get wantKeepAlive => true;
  TabController _tabController;
  int historyChapter = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    loadData().whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
    _scrollController = new ScrollController();
  }


  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  double getSafebar() {
    return MediaQuery.of(context).padding.top;
  }

  void backTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  NovelDetail _detail;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    pinned: true,
                    expandedHeight: detailExpandHeight,
                    automaticallyImplyLeading: true,
                    title: (_detail != null) ? Text(_detail.name) : Text(""),
                    actions: (_detail != null)
                        ? <Widget>[
                            Provider.of<AppUserInfo>(context).isLogin &&
                                    _isSubscribe
                                ? IconButton(
                                    icon: Icon(Icons.favorite),
                                    onPressed: () async {
                                      var result =
                                          await UserHelper.novelSubscribe(
                                              widget.novelId,
                                              cancel: true);
                                      if (result) {
                                        setState(() {
                                          _isSubscribe = false;
                                        });
                                      }
                                    })
                                : IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () async {
                                      var result =
                                          await UserHelper.novelSubscribe(
                                              widget.novelId);
                                      if (result) {
                                        setState(() {
                                          _isSubscribe = true;
                                        });
                                      }
                                    }),
                            IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () => Share.share(
                                    "${_detail.name}\r\nhttp://q.dmzj.com/${widget.novelId}/index.shtml")),
                          ]
                        : null,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Stack(
                        fit: StackFit.loose,
                        children: [
                          ClipRect(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: detailExpandHeight + getSafebar(),
                              foregroundDecoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withAlpha(100)),
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Utils.createCacheImage(
                                    widget.coverUrl,
                                    MediaQuery.of(context).size.width,
                                    detailExpandHeight,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Positioned(
                              top: getSafebar() + kToolbarHeight,
                              child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: createHeader())),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Builder(builder: (context) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverToBoxAdapter(
                      child: (_detail != null)
                          ? createDetail()
                          : _loadfail
                              ? Center(
                                  child: Text("漫画走丢了 w(ﾟДﾟ)w ！"),
                                )
                              : Container()),
                ],
              );
            }),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("章节"),
            ),
            body: SafeArea(
                child: (_detail != null) ? createVolume() : Container()),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("评论"),
            ),
            body: SafeArea(
                child: (_detail != null)
                    ? CommentWidget(1, widget.novelId)
                    : Container()),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          heroTag: "comic_float",
          child: Icon(Icons.play_arrow),
          onPressed: openRead),
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
              child: Text("章节"),
              onPressed: () {
                setState(() {
                  _index = 1;
                });
              },
            ),
            TextButton(
              child: Text("评论"),
              onPressed: () {
                setState(() {
                  _index = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 12,
        ),
        Utils.createCover(widget.coverUrl, 100, 0.75, context),
        SizedBox(
          width: 24,
        ),
        Expanded(
          child: (_detail != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _detail.name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "作者:" + _detail.authors,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "点击:" + _detail.hot_hits.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "订阅:" + _detail.subscribe_num.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "状态:" + _detail.status,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "最后更新:" +
                          DateUtil.formatDate(
                              DateTime.fromMillisecondsSinceEpoch(
                                  _detail.last_update_time * 1000),
                              format: "yyyy-MM-dd"),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : SizedBox(
                  width: 12,
                ),
        )
      ],
    );
  }

  Widget createDetail() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("简介", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  _detail.introduction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createVolume() {
    return volumes != null && volumes.length != 0
        ? ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: volumes.length,
            itemBuilder: (ctx, i) {
              var f = volumes[i];
              var his = f.chapters.firstWhere(
                  (x) => x.chapter_id == historyChapter,
                  orElse: () => null);
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: ExpansionTile(
                    title: Text(f.volume_name),
                    subtitle:
                        his != null ? Text("上次看到:" + his.chapter_name) : null,
                    children: f.chapters.map((item) {
                      return InkWell(
                        onTap: () async {
                          await Utils.openNovelReader(
                              context, widget.novelId, volumes, item,
                              novelTitle: _detail.name,
                              isSubscribe: _isSubscribe);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey.withOpacity(0.1))),
                          ),
                          child: Text(
                            item.chapter_name,
                            style: TextStyle(
                                color: item.chapter_id == historyChapter
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text("岂可修！竟然没有章节！"),
            ),
          );
  }

  void openRead() async {
    //Fluttertoast.showToast(msg: '没写完');

    if (volumes == null || volumes == null || volumes[0].chapters.length == 0) {
      Fluttertoast.showToast(msg: '没有可读的章节');
      return;
    }

    if (historyChapter != 0) {
      NovelVolumeChapterItem chapterItem;
      for (var item in volumes) {
        var first = item.chapters.firstWhere(
            (f) => f.chapter_id == historyChapter,
            orElse: () => null);
        if (first != null) {
          chapterItem = first;
        }
      }
      if (chapterItem != null) {
        await Utils.openNovelReader(
            context, widget.novelId, volumes, chapterItem,
            novelTitle: _detail.name, isSubscribe: _isSubscribe);
        return;
      }
    } else {
      await Utils.openNovelReader(
          context, widget.novelId, volumes, volumes[0].chapters[0],
          novelTitle: _detail.name, isSubscribe: _isSubscribe);
    }
  }

  String tagsToString(List<String> items) {
    var str = "";
    for (var item in items) {
      str += item + " ";
    }
    return str;
  }

  DefaultCacheManager _cacheManager = DefaultCacheManager();
  bool _loading = false;
  bool _loadfail = false;
  bool _isSubscribe = false;
  List<NovelVolumeItem> volumes = [];
  Future loadData() async {
    if (_loading) {
      return;
    }
    setState(() {
      _loading = true;
    });
    loadDetail();
    loadVolumes();
    checkSubscribe();
  }

  Future loadDetail() async {
    try {
      Uint8List responseBody;
      var api = Api.novelDetail(widget.novelId);
      try {
        var response = await http.get(api);
        responseBody = response.bodyBytes;
      } catch (e) {
        var file = await _cacheManager.getFileFromCache(api);
        if (file != null) {
          responseBody = await file.file.readAsBytes();
        }
      }
      var responseStr = utf8.decode(responseBody);
      var jsonMap = jsonDecode(responseStr);

      NovelDetail detail = NovelDetail.fromJson(jsonMap);
      if (detail.name == null || detail.name == "") {
        setState(() {
          _loadfail = true;
        });
        return;
      }
      await _cacheManager.putFile(api, responseBody);

      setState(() {
        _detail = detail;
      });
    } catch (e) {
      _loadfail = true;
      print(e);
    }
  }

  Future loadVolumes() async {
    try {
      Uint8List responseBody;
      var api = Api.novelVolumeDetail(widget.novelId);
      try {
        var response = await http.get(api);
        responseBody = response.bodyBytes;
      } catch (e) {
        var file = await _cacheManager.getFileFromCache(api);
        if (file != null) {
          responseBody = await file.file.readAsBytes();
        }
      }
      var responseStr = utf8.decode(responseBody);
      List jsonMap = jsonDecode(responseStr);

      List<NovelVolumeItem> detail =
          jsonMap.map((f) => NovelVolumeItem.fromJson(f)).toList();
      if (detail != null) {
        await _cacheManager.putFile(api, responseBody);
        setState(() {
          volumes = detail;
        });
      }
    } catch (e) {
      _loadfail = true;
      print(e);
    }
  }

  Future checkSubscribe() async {
    try {
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        return;
      }
      var response = await http.get(Api.novelCheckSubscribe(widget.novelId,
          Provider.of<AppUserInfo>(context, listen: false).loginInfo.uid));
      var jsonMap = jsonDecode(response.body);
      setState(() {
        _isSubscribe = jsonMap["code"] == 0;
      });
    } catch (e) {
      _loadfail = true;
      print(e);
    }
  }
}
