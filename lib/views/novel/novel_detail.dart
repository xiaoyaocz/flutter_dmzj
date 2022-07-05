import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/api/novel.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/protobuf/novel/novel_chapter_response.pb.dart';
import 'package:flutter_dmzj/protobuf/novel/novel_detail_response.pb.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NovelDetailPage extends StatefulWidget {
  final int novelId;
  NovelDetailPage(this.novelId, {Key key}) : super(key: key);

  @override
  _NovelDetailPageState createState() => _NovelDetailPageState();
}

class _NovelDetailPageState extends State<NovelDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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

  NovelDetailInfoResponse _detail;
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  CommentWidget(1, widget.novelId),
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
                            "点击:" + _detail.hotHits.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "订阅:" + _detail.subscribeNum.toString(),
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
                                        _detail.lastUpdateTime.toInt() * 1000),
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
                var his = f.chapters.firstWhere(
                    (x) => x.chapterId == historyChapter,
                    orElse: () => null);
                return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Container(
                    color: Theme.of(context).cardColor,
                    child: ExpansionTile(
                      title: Text(f.volumeName),
                      subtitle:
                          his != null ? Text("上次看到:" + his.chapterName) : null,
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
                              item.chapterName,
                              style: TextStyle(
                                  color: item.chapterId == historyChapter
                                      ? Theme.of(context).colorScheme.secondary
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

    if (historyChapter != 0) {
      NovelChapterItemResponse chapterItem;
      for (var item in volumes) {
        var first = item.chapters.firstWhere(
            (f) => f.chapterId == historyChapter,
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

  // DefaultCacheManager _cacheManager = DefaultCacheManager();
  bool _loading = false;
  bool _isSubscribe = false;
  List<NovelChapterVolumeResponse> volumes = [];
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var detail = await NovelApi.instance.getDetail(widget.novelId);
      // print(detail.writeToJson());
      // Uint8List responseBody;
      // var api = Api.novelDetail(widget.novelId);
      // try {
      //   var response = await http.get(Uri.parse(api));
      //   responseBody = response.bodyBytes;
      // } catch (e) {
      //   var file = await _cacheManager.getFileFromCache(api);
      //   if (file != null) {
      //     responseBody = await file.file.readAsBytes();
      //   }
      // }
      // var responseStr = utf8.decode(responseBody);
      // var jsonMap = jsonDecode(responseStr);

      //NovelDetail detail = NovelDetail.fromJson(jsonMap);
      if (detail.name == null || detail.name == "") {
        setState(() {
          _loading = false;
        });
        return;
      }
      // await _cacheManager.putFile(api, responseBody);
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
      // Uint8List responseBody;
      // var api = Api.novelVolumeDetail(widget.novelId);
      // try {
      //   var response = await http.get(Uri.parse(api));
      //   responseBody = response.bodyBytes;
      // } catch (e) {
      //   var file = await _cacheManager.getFileFromCache(api);
      //   if (file != null) {
      //     responseBody = await file.file.readAsBytes();
      //   }
      // }
      // var responseStr = utf8.decode(responseBody);
      // List jsonMap = jsonDecode(responseStr);

      // List<NovelVolumeItem> detail =
      //     jsonMap.map((f) => NovelVolumeItem.fromJson(f)).toList();
      var detail = await NovelApi.instance.getChapter(widget.novelId);
      if (detail != null) {
        //await _cacheManager.putFile(api, responseBody);
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
      var response = await http.get(Uri.parse(Api.novelCheckSubscribe(
          widget.novelId,
          Provider.of<AppUserInfo>(context, listen: false).loginInfo.uid)));
      var jsonMap = jsonDecode(response.body);
      setState(() {
        _isSubscribe = jsonMap["code"] == 0;
      });
    } catch (e) {
      print(e);
    }
  }
}
