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
import 'package:flutter_dmzj/widgets/stickyTabBarDelegate.dart';
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
  @override
  bool get wantKeepAlive => true;
  TabController _tabController;
  int historyChapter = 0;

  @override
  void initState() {
    super.initState();
    updateHistory();
    loadData();
  }

  void updateHistory() {
    var his = ConfigHelper.getNovelHistory(widget.novelId);
    setState(() {
      historyChapter = his;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  NovelDetail _detail;
  @override
  Widget build(BuildContext context) {
    _tabController = TabController(length: 3, vsync: this);
    super.build(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: (_detail != null) ? Text(_detail.name) : Text(""),
          actions: (_detail != null)
              ? <Widget>[
                  Provider.of<AppUserInfo>(context).isLogin && _isSubscribe
                      ? IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () async {
                            var result = await UserHelper.novelSubscribe(
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
                                await UserHelper.novelSubscribe(widget.novelId);
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
              : null),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
                child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Hero(
                      tag: widget.novelId,
                      child: Utils.createCacheImage(widget.coverUrl,
                          MediaQuery.of(context).size.width, 200,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Center(
                      child: Container(
                    color: Theme.of(context).cardColor.withAlpha(75),
                    padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () => Utils.showImageViewDialog(
                                  context, widget.coverUrl),
                              child: Container(
                                width: 100,
                                child: Utils.createCacheImage(
                                    widget.coverUrl, 270, 360),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: (_detail != null)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _detail.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "作者:" + _detail.authors,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "点击:" + _detail.hot_hits.toString(),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "订阅:" +
                                              _detail.subscribe_num.toString(),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "状态:" + _detail.status,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "最后更新:" +
                                              DateUtil.formatDate(
                                                  DateTime.fromMillisecondsSinceEpoch(
                                                      _detail.last_update_time *
                                                          1000),
                                                  format: "yyyy-MM-dd"),
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      width: 12,
                                    ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        )
                      ],
                    ),
                  )),
                ),
              ],
            )),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: TabBar(
                    controller: _tabController,
                    indicatorWeight: 4,
                    indicatorColor: Theme.of(context).indicatorColor,
                    tabs: [
                      Tab(text: "详情"),
                      Tab(text: "章节"),
                      Tab(text: "评论"),
                    ]),
              ),
            ),
          ];
        },
        body: (_detail != null)
            ? TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      color: Theme.of(context).cardColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("简介",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(
                            _detail.introduction,
                          ),
                        ],
                      ),
                    ),
                  ),
                  cerateVolume(),
                  CommentWidget(1, widget.novelId),
                ],
              )
            : _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(24),
                    child: Text("读取轻小说失败"),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "read_novel",
          child: Icon(Icons.play_arrow),
          onPressed: openRead),
    );
  }

  Widget cerateVolume() {
    return volumes != null && volumes.length != 0
        ? ListView.builder(
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
                          updateHistory();
                        },
                        child: Container(
                          width: double.infinity,
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
        updateHistory();
        return;
      }
    } else {
      await Utils.openNovelReader(
          context, widget.novelId, volumes, volumes[0].chapters[0],
          novelTitle: _detail.name, isSubscribe: _isSubscribe);
      updateHistory();
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
  bool _isSubscribe = false;
  List<NovelVolumeItem> volumes = [];
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      Uint8List responseBody;
      var api = Api.novelDetail(widget.novelId);
      //优先从缓存读取信息，加快加载速度
      var file = await _cacheManager.getFileFromCache(api);
      if (file != null) {
        responseBody = await file.file.readAsBytes();
        print('load from cache ${widget.novelId}');
      } else {
        try {
          var response = await http.get(api);
          responseBody = response.bodyBytes;
        } catch (e) {
          return;
        }
      }

      var responseStr = utf8.decode(responseBody);
      var jsonMap = jsonDecode(responseStr);

      NovelDetail detail = NovelDetail.fromJson(jsonMap);
      if (detail.name == null || detail.name == "") {
        setState(() {
          _loading = false;
        });
        return;
      }
      await _cacheManager.putFile(api, responseBody);
      await loadVolumes();
      await checkSubscribe();
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
      print(e);
    }
  }
}
