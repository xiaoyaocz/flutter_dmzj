import 'dart:convert';
import 'dart:typed_data';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/api/comic.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/http_util.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_dmzj/models/comic/comic_related_model.dart';
import 'package:flutter_dmzj/protobuf/comic/detail_response.pb.dart';
import 'package:flutter_dmzj/sql/comic_history.dart';
import 'package:flutter_dmzj/views/download/comic_download.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ComicDetailPage extends StatefulWidget {
  final int comicId;
  ComicDetailPage(this.comicId, {Key key}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int historyChapter = 0;

  @override
  void initState() {
    super.initState();
    updateHistory();
    Utils.changHistory.on<int>().listen((e) {
      updateHistory();
    });
    loadData();
  }

  void updateHistory() async {
    var his = await ComicHistoryProvider.getItem(widget.comicId);
    setState(() {
      historyChapter = his?.chapter_id ?? 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  double getWidth() {
    return (MediaQuery.of(context).size.width - 24) / 3 - 32;
  }

  ComicDetailInfoResponse _detail;
  ComicRelated _related;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _detail != null
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(_detail.title),
                actions: <Widget>[
                  Provider.of<AppUserInfo>(context).isLogin && _isSubscribe
                      ? IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () async {
                            var result = await UserHelper.comicSubscribe(
                                widget.comicId,
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
                                await UserHelper.comicSubscribe(widget.comicId);
                            if (result) {
                              setState(() {
                                _isSubscribe = true;
                              });
                            }
                          }),
                  PopupMenuButton<String>(
                    itemBuilder: (e) => [
                      PopupMenuItem<String>(
                          value: 'download', child: new Text('下载')),
                      PopupMenuItem<String>(
                          value: 'share', child: new Text('分享漫画')),
                    ],
                    icon: Icon(Icons.more_vert),
                    onSelected: (e) {
                      if (e == "share") {
                        Share.share(
                            "${_detail.title}\r\nhttp://m.dmzj.com/info/${_detail.comicPy}.html");
                      } else {
                        if (_detail == null ||
                            _detail.chapters == null ||
                            _detail.chapters.length == 0) {
                          Fluttertoast.showToast(msg: '没有可以下载的章节');
                          return;
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             ComicDownloadPage(_detail)));
                      }
                    },
                  )
                  // IconButton(icon: Icon(Icons.more_vert), onPressed: (){}),
                  // IconButton(
                  //     icon: Icon(Icons.share),
                  //     onPressed: () => Share.share(
                  //         "${_detail.title}\r\nhttp://m.dmzj.com/info/${_detail.comic_py}.html")),
                ],
                bottom: TabBar(
                    tabs: [Tab(text: "详情"), Tab(text: "评论"), Tab(text: "相关")]),
              ),
              body: TabBarView(
                children: [
                  createDetail(),
                  CommentWidget(4, widget.comicId),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: _related.author_comics
                              .map<Widget>((f) => _getItem(
                                      f.author_name + "的其他作品", f.data,
                                      icon: Icon(Icons.chevron_right),
                                      ratio: getWidth() /
                                          ((getWidth() * (360 / 270)) + 36),
                                      ontap: () {
                                    Utils.openPage(context, f.author_id, 8);
                                  }))
                              .toList(),
                        ),
                        _getItem(
                          "同类题材作品",
                          _related.theme_comics,
                          ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                        ),
                        _related.novels != null && _related.novels.length != 0
                            ? _getItem(
                                "相关小说",
                                _related.novels,
                                type: 2,
                                ratio: getWidth() /
                                    ((getWidth() * (360 / 270)) + 36),
                              )
                            : Container()
                      ],
                    ),
                  ),
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
                    child: Text(_noCopyright
                        ? "漫画ID:${widget.comicId}\r\n因版权、国家法规等原因，该漫画暂时无法观看。"
                        : ""),
                  ),
          );
  }

  Widget createDetail() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).cardColor,
              padding: EdgeInsets.only(top: 12, left: 12, right: 12),
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
                          child:
                              Utils.createCacheImage(_detail.cover, 270, 360),
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
                              _detail.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "作者:" + tagsToString(_detail.authors ?? []),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "点击:" + _detail.hotNum.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "订阅:" + _detail.subscribeNum.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "状态:" + tagsToString(_detail.status ?? []),
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "最后更新:" +
                                  DateUtil.formatDate(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(_detail.lastUpdatetime
                                                  .toString()) *
                                              1000),
                                      format: "yyyy-MM-dd"),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Wrap(
                      children: _detail.types
                          .map<Widget>((f) => createTagItem(f.tagName, f.tagId))
                          .toList(),
                    ),
                  )
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
                    _detail.description,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            ComicChapterView(
              widget.comicId,
              _detail,
              historyChapter,
              isSubscribe: _isSubscribe,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: null, child: Icon(Icons.play_arrow), onPressed: openRead),
    );
  }

  Widget createChpter() {
    return Scaffold(
      body: _detail.chapters != null && _detail.chapters.length != 0
          ? ListView.builder(
              itemCount: _detail.chapters.length,
              itemBuilder: (ctx, i) {
                var f = _detail.chapters[i];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  width: double.infinity,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          f.title,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: null,
                        itemCount: f.data.length,
                        padding: EdgeInsets.all(2),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 6 / 2),
                        itemBuilder: (context, i) {
                          return OutlineButton(
                            borderSide: BorderSide(
                                color: f.data[i].chapterId == historyChapter
                                    ? Theme.of(context).accentColor
                                    : Colors.grey.withOpacity(0.6)),
                            child: Text(
                              f.data[i].chapterTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: f.data[i].chapterId == historyChapter
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color),
                            ),
                            onPressed: () async {
                              await Utils.openComicReader(
                                  context,
                                  widget.comicId,
                                  _detail.title,
                                  _isSubscribe,
                                  f.data,
                                  f.data[i]);
                              updateHistory();
                            },
                          );
                        },
                      ),
                      SizedBox(height: 8)
                    ],
                  ),
                );
              })
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

  Widget createTagItem(String text, int id) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ButtonTheme(
        minWidth: 20,
        height: 24,
        child: OutlineButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          textColor: Theme.of(context).accentColor,
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          child: Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
          onPressed: () {
            Utils.openPage(context, id, 11, title: text);
          },
        ),
      ),
    );
  }

  void openRead() async {
    if (_detail == null ||
        _detail.chapters == null ||
        _detail.chapters.length == 0 ||
        _detail.chapters[0].data.length == 0) {
      Fluttertoast.showToast(msg: '没有可读的章节');
      return;
    }
    if (historyChapter != 0) {
      ComicDetailChapterInfoResponse _item;
      ComicDetailChapterResponse chpters;
      for (var item in _detail.chapters) {
        var first = item.data.firstWhere((f) => f.chapterId == historyChapter,
            orElse: () => null);
        if (first != null) {
          chpters = item;
          _item = first;
        }
      }
      if (_item != null) {
        await Utils.openComicReader(context, widget.comicId, _detail.title,
            _isSubscribe, chpters.data, _item);
        updateHistory();
        return;
      }
    }
    var _chapters = _detail.chapters[0].data;
    _chapters.sort((x, y) => x.chapterOrder.compareTo(y.chapterOrder));
    await Utils.openComicReader(context, widget.comicId, _detail.title,
        _isSubscribe, _chapters, _chapters.first);
    updateHistory();
  }

  Widget _getItem(String title, List items,
      {Icon icon,
      Function ontap,
      bool needSubTitle = true,
      int count = 3,
      int type = 1,
      double ratio = 3 / 5.2,
      double imgWidth = 270,
      double imgHeight = 360}) {
    return Offstage(
        offstage: items == null || items.length == 0,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: Theme.of(context).cardColor,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTitle(title, icon: icon, ontap: ontap),
                  SizedBox(
                    height: 4.0,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: count,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: ratio),
                    itemBuilder: (context, i) => _getComicItemBuilder(
                        items[i].id, type, items[i].cover, items[i].name,
                        author: needSubTitle ? items[i].status : "",
                        url: '',
                        width: imgWidth,
                        height: imgHeight),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ));
  }

  Widget _getTitle(String title, {Icon icon, Function ontap}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(padding: EdgeInsets.only(left: 4), child: Text(title)),
        ),
        Offstage(
          offstage: icon == null,
          child: Material(
              color: Theme.of(context).cardColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: ontap,
                child: icon ?? Icon(Icons.refresh),
              )),
        )
      ],
    );
  }

  Widget _getComicItemBuilder(int id, int type, String pic, String title,
      {String author = "",
      String url = "",
      double width = 270,
      double height = 360}) {
    return RawMaterialButton(
      onPressed: () =>
          Utils.openPage(context, id, type, url: url, title: title),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(4),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Utils.createCacheImage(pic, width, height),
            Padding(
              padding: EdgeInsets.only(top: 4, bottom: 4),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            author == ""
                ? Container()
                : Flexible(
                    child: Text(
                      author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  String tagsToString(List<ComicDetailTypeItemResponse> items) {
    var str = "";
    for (var item in items) {
      str += item.tagName + " ";
    }
    return str;
  }

  bool _noCopyright = false;
  bool _loading = false;

  bool _isSubscribe = false;
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
        _noCopyright = false;
      });
      // var api = Api.comicDetail(widget.comicId);
      // Uint8List responseBody;
      // var response = await http.get(Uri.parse(api));
      // responseBody = response.bodyBytes;
      // if (response.body == "漫画不存在!!!") {
      //   var file = await _cacheManager
      //       .getFileFromCache('http://comic.cache/${widget.comicId}');
      //   if (file == null) {
      //     setState(() {
      //       _loading = false;
      //       _noCopyright = true;
      //     });
      //     return;
      //   }
      //   responseBody = await file.file.readAsBytes();
      // }
      // var responseStr = utf8.decode(responseBody);
      // var jsonMap = jsonDecode(responseStr);

      // ComicDetail detail = ComicDetail.fromJson(jsonMap);
      var detail = await ComicApi.instance.getDetail(widget.comicId);
      if (detail.title == null || detail.title == "") {
        setState(() {
          _loading = false;
          _noCopyright = true;
        });
        return;
      }
      // await _cacheManager.putFile(
      //     'http://comic.cache/${widget.comicId}', responseBody,
      //     eTag: api, maxAge: Duration(days: 7), fileExtension: 'json');
      await checkSubscribe();
      await loadRelated();
      setState(() {
        _detail = detail;
      });
    } catch (e) {
      if (e is AppError && e.code == 2) {
        setState(() {
          _noCopyright = true;
          _loading = false;
        });
        return;
      }
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future loadRelated() async {
    try {
      var response =
          await http.get(Uri.parse(Api.comicRelated(widget.comicId)));

      var jsonMap = jsonDecode(response.body);

      ComicRelated detail = ComicRelated.fromJson(jsonMap);
      await checkSubscribe();
      setState(() {
        _related = detail;
      });
    } catch (e) {
      print(e);
    }
  }

  Future checkSubscribe() async {
    try {
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        return;
      }
      var response = await http.get(Uri.parse(Api.comicCheckSubscribe(
          widget.comicId,
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

class ComicChapterView extends StatefulWidget {
  final ComicDetailInfoResponse detail;
  final int comicId;
  final bool isSubscribe;
  final int historyChapter;
  final Function openReader;
  ComicChapterView(this.comicId, this.detail, this.historyChapter,
      {Key key, this.isSubscribe = false, this.openReader})
      : super(key: key);

  @override
  _ComicChapterViewState createState() => _ComicChapterViewState();
}

class _ComicChapterViewState extends State<ComicChapterView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
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
    return widget.detail.chapters != null && widget.detail.chapters.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 12),
            physics: ScrollPhysics(),
            itemCount: widget.detail.chapters.length,
            itemBuilder: (ctx, i) {
              var f = widget.detail.chapters[i];
              return Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                                f.title +
                                    "(共" +
                                    f.data.length.toString() +
                                    "话)",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (f.desc) {
                                f.data.sort((x, y) =>
                                    x.chapterOrder.compareTo(y.chapterOrder));
                              } else {
                                f.data.sort((x, y) =>
                                    y.chapterOrder.compareTo(x.chapterOrder));
                              }
                              f.desc = !f.desc;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(f.desc ? "排序 ↓" : "排序 ↑"),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount:
                          f.data.length > 14 ? (f.showNum + 1) : f.data.length,
                      padding: EdgeInsets.all(2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width ~/ 120,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 6 / 2),
                      itemBuilder: (context, i) {
                        if (f.data.length > 14 && f.showNum == 14 && i >= 14) {
                          return OutlineButton(
                            onPressed: () {
                              setState(() {
                                f.showNum = f.data.length - 1;
                              });
                            },
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.4)),
                            child: Text("· · ·"),
                          );
                        }
                        return OutlineButton(
                          borderSide: BorderSide(
                              color:
                                  f.data[i].chapterId == widget.historyChapter
                                      ? Theme.of(context).accentColor
                                      : Colors.grey.withOpacity(0.4)),
                          child: Text(
                            f.data[i].chapterTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:
                                    f.data[i].chapterId == widget.historyChapter
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color),
                          ),
                          onPressed: () {
                            Utils.openComicReader(
                                context,
                                widget.comicId,
                                widget.detail.title,
                                widget.isSubscribe,
                                f.data,
                                f.data[i]);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 8)
                  ],
                ),
              );
            })
        : Container(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text("岂可修！竟然没有可以看的章节！"),
            ),
          );
  }

  void openRead() async {
    if (widget.detail == null ||
        widget.detail.chapters == null ||
        widget.detail.chapters.length == 0 ||
        widget.detail.chapters[0].data.length == 0) {
      Fluttertoast.showToast(msg: '没有可读的章节');
      return;
    }
    if (widget.historyChapter != 0) {
      ComicDetailChapterInfoResponse _item;
      ComicDetailChapterResponse chpters;
      for (var item in widget.detail.chapters) {
        var first = item.data.firstWhere(
            (f) => f.chapterId == widget.historyChapter,
            orElse: () => null);
        if (first != null) {
          chpters = item;
          _item = first;
        }
      }
      if (_item != null) {
        Utils.openComicReader(context, widget.comicId, widget.detail.title,
            widget.isSubscribe, chpters.data, _item);
        return;
      }
    }
    Utils.openComicReader(
        context,
        widget.comicId,
        widget.detail.title,
        widget.isSubscribe,
        widget.detail.chapters[0].data,
        widget.detail.chapters[0].data.last);
  }
}
