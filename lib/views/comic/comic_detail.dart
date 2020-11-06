import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_dmzj/models/comic/comic_related_model.dart';
import 'package:flutter_dmzj/sql/comic_history.dart';
import 'package:flutter_dmzj/views/download/comic_download.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

class ComicDetailPage extends StatefulWidget {
  final int comicId;
  final String coverUrl;
  ComicDetailPage(this.comicId, this.coverUrl, {Key key}) : super(key: key);

  @override
  _ComicDetailPageState createState() => _ComicDetailPageState();
}

class _ComicDetailPageState extends State<ComicDetailPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController _tabController;
  int historyChapter = 0;
  double comicExpandHeight;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadData().whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
    updateHistory();
    Utils.changHistory.on<int>().listen((e) {
      updateHistory();
    });
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  void updateHistory() async {
    var his = await ComicHistoryProvider.getItem(widget.comicId);
    setState(() {
      historyChapter = his?.chapter_id ?? 0;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double getSafebar() {
    return MediaQuery.of(context).padding.top;
  }

  double getWidth() {
    return (MediaQuery.of(context).size.width - 24) / 3 - 32;
  }

  ComicDetail _detail;
  ComicRelated _related;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    comicExpandHeight = getSafebar() + 200 + kTextTabBarHeight;
    return Scaffold(
      body: extended.NestedScrollView(
        innerScrollPositionKeyBuilder: () {
          String index = 'tab${_tabController.index}';
          print(index);
          return Key(index);
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: comicExpandHeight,
              automaticallyImplyLeading: true,
              title: (_detail != null) ? Text(_detail.title) : Text(""),
              actions: (_detail != null)
                  ? <Widget>[
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
                                var result = await UserHelper.comicSubscribe(
                                    widget.comicId);
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
                                "${_detail.title}\r\nhttp://m.dmzj.com/info/${_detail.comic_py}.html");
                          } else {
                            if (_detail == null ||
                                _detail.chapters == null ||
                                _detail.chapters.length == 0) {
                              Fluttertoast.showToast(msg: '没有可以下载的章节');
                              return;
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ComicDownloadPage(_detail)));
                          }
                        },
                      )
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
                        height: comicExpandHeight + kToolbarHeight,
                        foregroundDecoration: BoxDecoration(
                            color:
                                Theme.of(context).shadowColor.withAlpha(100)),
                        child: ImageFiltered(
                          imageFilter:
                              ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Utils.createCacheImage(
                              widget.coverUrl,
                              MediaQuery.of(context).size.width,
                              comicExpandHeight,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                        top: getSafebar() + kToolbarHeight,
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Utils.createCover(
                                      widget.coverUrl, 100, 0.75, context),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  (_detail != null)
                                      ? Expanded(
                                          child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              _detail.title,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "作者:" +
                                                  tagsToString(
                                                      _detail.authors ?? []),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "点击:" +
                                                  _detail.hot_num.toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "订阅:" +
                                                  _detail.subscribe_num
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "状态:" +
                                                  tagsToString(
                                                      _detail.status ?? []),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "最后更新:" +
                                                  DateUtil.formatDate(
                                                      DateTime.fromMillisecondsSinceEpoch(
                                                          _detail.last_updatetime *
                                                              1000),
                                                      format: "yyyy-MM-dd"),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))
                                      : SizedBox(
                                          width: 12,
                                        ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                ],
                              ),
                              (_detail != null)
                                  ? Container(
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: _detail.types
                                            .map<Widget>((f) => createTagItem(
                                                f.tag_name, f.tag_id))
                                            .toList(),
                                      ),
                                    )
                                  : SizedBox(
                                      height: kTextTabBarHeight,
                                    ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              bottom: TabBar(
                  controller: _tabController,
                  indicatorWeight: 4,
                  labelStyle: new TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                  indicatorColor: Theme.of(context).indicatorColor,
                  tabs: [Tab(text: "详情"), Tab(text: "评论"), Tab(text: "相关")]),
            ),
          ];
        },
        body: (_detail != null && _related != null)
            ? TabBarView(
                controller: _tabController,
                children: <Widget>[
                  createDetail(),
                  extended.NestedScrollViewInnerScrollPositionKeyWidget(
                    Key('tab1'),
                    CommentWidget(4, widget.comicId),
                  ),
                  createRelate(),
                ],
              )
            : _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(24),
                    child: Text(_noCopyright
                        ? "漫画ID:${widget.comicId}\r\n因版权、国家法规等原因，该漫画暂时无法观看。"
                        : ""),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "comic_float",
          child: Icon(Icons.play_arrow),
          onPressed: openRead),
    );
  }

  Widget createDetail() {
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
        Key('tab0'),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
              _detail.copyright == 1
                  ? Column(
                      children: <Widget>[
                        SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          color: Theme.of(context).cardColor,
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("作者公告",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(
                                _detail.author_notice != null &&
                                        _detail.author_notice != ""
                                    ? _detail.author_notice
                                    : "无",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(),
              ComicChapterView(
                widget.comicId,
                _detail,
                historyChapter,
                isSubscribe: _isSubscribe,
              )
            ],
          ),
        ));
  }

  Widget createRelate() {
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
        Key('tab0'),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: _related.author_comics
                    .map<Widget>((f) => _getItem(
                            f.author_name + "的其他作品", f.data,
                            icon: Icon(Icons.chevron_right),
                            //ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                            ontap: () {
                          Utils.openPage(context, f.author_id, 8);
                        }))
                    .toList(),
              ),
              _getItem(
                "同类题材作品",
                _related.theme_comics,
                //ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
              ),
              _related.novels != null && _related.novels.length != 0
                  ? _getItem(
                      "相关小说",
                      _related.novels,
                      type: 2,
                      //ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                    )
                  : Container()
            ],
          ),
        ));
  }

  Widget createChpter() {
    return _detail.chapters != null && _detail.chapters.length != 0
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
                              color: f.data[i].chapter_id == historyChapter
                                  ? Theme.of(context).accentColor
                                  : Colors.grey.withOpacity(0.6)),
                          child: Text(
                            f.data[i].chapter_title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: f.data[i].chapter_id == historyChapter
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                          ),
                          onPressed: () async {
                            await Utils.openComicReader(context, widget.comicId,
                                _detail.title, _isSubscribe, f.data, f.data[i]);
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
          );
  }

  Widget createTagItem(String text, int id) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ButtonTheme(
        minWidth: 20,
        height: 24,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          //borderSide: BorderSide(color: Theme.of(context).accentColor),
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
      ComicDetailChapterItem _item;
      ComicDetailChapter chpters;
      for (var item in _detail.chapters) {
        var first = item.data.firstWhere((f) => f.chapter_id == historyChapter,
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
    _chapters.sort((x, y) => x.chapter_order.compareTo(y.chapter_order));
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
                    padding: EdgeInsets.all(4),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: count,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: ratio),
                    itemBuilder: (context, i) => Utils.createCoverWidget(
                        items[i].id,
                        type,
                        items[i].cover,
                        items[i].name,
                        context,
                        author: needSubTitle ? items[i].status : "",
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
    return Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(title),
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
        ));
  }

  Widget _getComicItemBuilder(int id, int type, String pic, String title,
      {String author = "",
      String url = "",
      double width = 270,
      double height = 360}) {
    return RawMaterialButton(
      onPressed: () =>
          Utils.openPage(context, id, type, url: pic, title: title),
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

  String tagsToString(List<ComicDetailTagItem> items) {
    var str = "";
    for (var item in items) {
      str += item.tag_name + " ";
    }
    return str;
  }

  bool _noCopyright = false;
  bool _loading = false;

  bool _isSubscribe = false;
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  Future loadData() async {
    if (_loading) {
      return;
    }
    setState(() {
      _loading = true;
      _noCopyright = false;
    });
    loadDetail();
    checkSubscribe();
    loadRelated();
  }

  Future loadDetail() async {
    try {
      var api = Api.comicDetail(widget.comicId);
      Uint8List responseBody;
      var response = await http.get(Api.comicDetail(widget.comicId));
      responseBody = response.bodyBytes;
      if (response.body == "漫画不存在!!!") {
        var file = await _cacheManager
            .getFileFromCache('http://comic.cache/${widget.comicId}');
        if (file == null) {
          setState(() {
            _loading = false;
            _noCopyright = true;
          });
          return;
        }
        responseBody = await file.file.readAsBytes();
      }

      var responseStr = utf8.decode(responseBody);
      var jsonMap = jsonDecode(responseStr);

      ComicDetail detail = ComicDetail.fromJson(jsonMap);

      if (detail.title == null || detail.title == "") {
        setState(() {
          _loading = false;
          _noCopyright = true;
        });
        return;
      }
      await _cacheManager.putFile(
          'http://comic.cache/${widget.comicId}', responseBody,
          eTag: api, maxAge: Duration(days: 7), fileExtension: 'json');
      setState(() {
        _detail = detail;
      });
    } catch (e) {
      print(e);
    }
  }

  Future loadRelated() async {
    try {
      var response = await http.get(Api.comicRelated(widget.comicId));

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
      var response = await http.get(Api.comicCheckSubscribe(widget.comicId,
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

class ComicChapterView extends StatefulWidget {
  final ComicDetail detail;
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
                                    x.chapter_order.compareTo(y.chapter_order));
                              } else {
                                f.data.sort((x, y) =>
                                    y.chapter_order.compareTo(x.chapter_order));
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
                      itemCount: f.data.length,
                      padding: EdgeInsets.all(2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width ~/ 120,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 6 / 2),
                      itemBuilder: (context, i) {
                        return OutlineButton(
                          borderSide: BorderSide(
                              color:
                                  f.data[i].chapter_id == widget.historyChapter
                                      ? Theme.of(context).accentColor
                                      : Colors.grey.withOpacity(0.4)),
                          child: Text(
                            f.data[i].chapter_title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: f.data[i].chapter_id ==
                                        widget.historyChapter
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
      ComicDetailChapterItem _item;
      ComicDetailChapter chpters;
      for (var item in widget.detail.chapters) {
        var first = item.data.firstWhere(
            (f) => f.chapter_id == widget.historyChapter,
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
