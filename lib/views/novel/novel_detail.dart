import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
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
  int novel_id;
  NovelDetailPage(this.novel_id, {Key key}) : super(key: key);

  @override
  _NovelDetailPageState createState() => _NovelDetailPageState();
}

class _NovelDetailPageState extends State<NovelDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int history_chapter = 0;

  @override
  void initState() {
    super.initState();
    updateHistory();
    loadData();
  }

  void updateHistory() {
    var his = ConfigHelper.getNovelHistory(widget.novel_id);
    setState(() {
      history_chapter = his;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int _selectTabIndex = 0;
  NovelDetail _detail;
  @override
  Widget build(BuildContext context) {
    return _detail != null
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(_detail.name),
                actions: <Widget>[
                  Provider.of<AppUserInfo>(context).isLogin && _isSubscribe
                      ? IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () async {
                            var result = await UserHelper.novelSubscribe(
                                widget.novel_id,
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
                            var result = await UserHelper.novelSubscribe(
                                widget.novel_id);
                            if (result) {
                              setState(() {
                                _isSubscribe = true;
                              });
                            }
                          }),
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () => Share.share(
                          "${_detail.name}\r\nhttp://q.dmzj.com/${widget.novel_id}/index.shtml")),
                ],
                bottom: TabBar(tabs: [
                  Tab(text: "详情"),
                  Tab(text: "章节"),
                  Tab(text: "评论"),
                ]),
              ),
              body: TabBarView(
                children: [
                  createDetail(),
                  cerateVolume(),
                  CommentWidget(1, widget.novel_id),
                ],
              ),
            ))
        : Scaffold(
            appBar: AppBar(),
            body: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(24),
                    child: Text("读取轻小说失败"),
                  ),
          );
  }

  Widget createDetail() {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () =>
                          Utils.showImageViewDialog(context, _detail.cover),
                      child: Container(
                        width: 100,
                        child: Utils.createCacheImage(_detail.cover, 270, 360),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _detail.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "作者:" + _detail.authors,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "点击:" + _detail.hot_hits.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "订阅:" + _detail.subscribe_num.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "状态:" + _detail.status,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "最后更新:" +
                                DateUtil.formatDate(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        _detail.last_update_time * 1000),
                                    format: "yyyy-MM-dd"),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            color: Theme.of(context).cardColor,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("简介", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  _detail.introduction,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: null, child: Icon(Icons.play_arrow), onPressed: openRead),
    );
  }

  Widget cerateVolume() {
    return Scaffold(
      body: volumes != null && volumes.length != 0
          ? ListView.builder(
              itemCount: volumes.length,
              itemBuilder: (ctx, i) {
                var f = volumes[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        f.volume_name,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: f.chapters.length,
                      itemBuilder: (ctx, j) {
                        var item = f.chapters[j];
                        return InkWell(
                            onTap: () async {
                              await Utils.openNovelReader(
                                  context, widget.novel_id, volumes, item,
                                  novel_title: _detail.name,
                                  is_subscribe: _isSubscribe);
                              updateHistory();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(0.1))),
                                color: Theme.of(context).cardColor,
                              ),
                              child: Text(
                                item.chapter_name,
                                style: TextStyle(
                                    color: item.chapter_id == history_chapter
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context)
                                            .textTheme
                                            .title
                                            .color),
                              ),
                            ));
                      },
                    )
                  ],
                );
              },
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text("岂可修！竟然没有章节！"),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          heroTag: null, child: Icon(Icons.play_arrow), onPressed: openRead),
    );
  }

  void openRead() async {
    //Fluttertoast.showToast(msg: '没写完');

    if (volumes == null || volumes == null || volumes[0].chapters.length == 0) {
      Fluttertoast.showToast(msg: '没有可读的章节');
      return;
    }

    if (history_chapter != 0) {
      NovelVolumeChapterItem chapter_item = null;
      for (var item in volumes) {
        var first = item.chapters.firstWhere(
            (f) => f.chapter_id == history_chapter,
            orElse: () => null);
        if (first != null) {
          chapter_item = first;
        }
      }
      if (chapter_item != null) {
        await Utils.openNovelReader(
            context, widget.novel_id, volumes, chapter_item,
            novel_title: _detail.name, is_subscribe: _isSubscribe);
        updateHistory();
        return;
      }
    } else {
      await Utils.openNovelReader(
          context, widget.novel_id, volumes, volumes[0].chapters[0],
          novel_title: _detail.name, is_subscribe: _isSubscribe);
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
      Uint8List  responseBody;
      var api = Api.novelDetail(widget.novel_id);
      try {
        var response = await http.get(api);
        responseBody = response.bodyBytes;
      } catch (e) {
        var file = await _cacheManager.getFileFromCache(api);
        if (file != null) {
          responseBody = await file.file.readAsBytes();
        }
      }
      var responseStr=utf8.decode(responseBody) ;
      var jsonMap = jsonDecode(responseStr);
    
      NovelDetail detail = NovelDetail.fromJson(jsonMap);
      if (detail.name == null || detail.name == "") {
        setState(() {
          _loading = false;
        });
        return;
      }
      await _cacheManager.putFile(api,responseBody );
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
       Uint8List  responseBody;
      var api = Api.novelVolumeDetail(widget.novel_id);
      try {
        var response = await http.get(api);
        responseBody = response.bodyBytes;
      } catch (e) {
        var file = await _cacheManager.getFileFromCache(api);
        if (file != null) {
          responseBody = await file.file.readAsBytes();
        }
      }
      var responseStr=utf8.decode(responseBody) ;
      List jsonMap = jsonDecode(responseStr);

      List<NovelVolumeItem> detail =
          jsonMap.map((f) => NovelVolumeItem.fromJson(f)).toList();
      if (detail != null) {
        await _cacheManager.putFile(api,responseBody);
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
      var response = await http.get(Api.novelCheckSubscribe(widget.novel_id,
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
