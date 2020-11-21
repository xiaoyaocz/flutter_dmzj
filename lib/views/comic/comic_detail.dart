import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import 'package:flutter_dmzj/widgets/comic_chapter_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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
  int _index = 0;
  double detailExpandHeight = 150 + kToolbarHeight + 24;
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
    var his = await ComicHistoryHelper.getItem(widget.comicId);
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
                    title: (_detail != null) ? Text(_detail.title) : Text(""),
                    actions: (_detail != null)
                        ? <Widget>[
                            IconButton(
                                icon: Icon(Icons.cloud_download),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ComicDownloadPage(_detail)));
                                }),
                            Provider.of<AppUserInfo>(context).isLogin &&
                                    _isSubscribe
                                ? IconButton(
                                    icon: Icon(Icons.favorite),
                                    onPressed: () async {
                                      var result =
                                          await UserHelper.comicSubscribe(
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
                                          await UserHelper.comicSubscribe(
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
                          : (_noCopyright)
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
              title: Text("评论"),
            ),
            body: SafeArea(
                child: (_detail != null && _related != null)
                    ? CommentWidget(4, widget.comicId)
                    : Container()),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("相关"),
            ),
            body: SafeArea(
                child: (_detail != null && _related != null)
                    ? createRelate()
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
              child: Text("评论"),
              onPressed: () {
                setState(() {
                  _index = 1;
                });
              },
            ),
            TextButton(
              child: Text("相关"),
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
        (_detail != null)
            ? Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _detail.title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "作者:" + tagsToString(_detail.authors ?? []),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    "点击:" + _detail.hot_num.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    "订阅:" + _detail.subscribe_num.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    "状态:" + tagsToString(_detail.status ?? []),
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    "最后更新:" +
                        DateUtil.formatDate(
                            DateTime.fromMillisecondsSinceEpoch(
                                _detail.last_updatetime * 1000),
                            format: "yyyy-MM-dd"),
                    style: TextStyle(fontSize: 12, color: Colors.white),
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
    );
  }

  Widget createDetail() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
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
                Container(
                  child: Wrap(
                    children: _detail.types
                        .map<Widget>((f) => createTagItem(f.tag_name, f.tag_id))
                        .toList(),
                  ),
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
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
          ),
        ],
      ),
    );
  }

  Widget createRelate() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: _related.author_comics
                .map<Widget>((f) => _getItem(f.author_name + "的其他作品", f.data,
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
    );
  }

  Widget createTagItem(String text, int id) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ButtonTheme(
        minWidth: 20,
        height: 24,
        child: RaisedButton(
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
