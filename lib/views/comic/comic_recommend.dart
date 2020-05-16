import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_home_banner_item.dart';
import 'package:flutter_dmzj/models/comic/comic_home_comic_item.dart';
import 'package:flutter_dmzj/models/comic/comic_home_new_item.dart';
import 'package:flutter_dmzj/views/comic/comic_detail.dart';
import 'package:flutter_dmzj/widgets/app_banner.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ComicRecommend extends StatefulWidget {
  ComicRecommend({Key key}) : super(key: key);

  ComicRecommendState createState() => ComicRecommendState();
}

class ComicRecommendState extends State<ComicRecommend>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<ComicHomeBannerItem> _banners = [];
  List<ComicHomeComicItem> _recommend = [];
  List<ComicHomeComicItem> _authors = [];
  List<ComicHomeComicItem> _special = [];
  List<ComicHomeNewItem> _like = [];
  List<ComicHomeComicItem> _guoman = [];
  List<ComicHomeComicItem> _meiman = [];
  List<ComicHomeComicItem> _hot = [];
  List<ComicHomeNewItem> _new = [];
  List<ComicHomeComicItem> _tiaoman = [];
  List<ComicHomeComicItem> _anime = [];
  List<ComicHomeNewItem> _my_sub = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  double getWidth() {
    var width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 600;
    }
    return (width - 24) / 3 - 32;
  }

  double getWidth2() {
    var width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 600;
    }
    return (width - 16) / 2 - 32;
  }

  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MediaQuery.of(context).size.width > 600
          ? FloatingActionButton(
            heroTag:'comic',
              child: Icon(_expand ? Icons.fullscreen_exit : Icons.zoom_out_map),
              onPressed: () {
                setState(() {
                  _expand = !_expand;
                });
              })
          : null,
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: _expand
                ? CrossAxisAlignment.stretch
                : CrossAxisAlignment.center,
            children: <Widget>[
              //banner
              AppBanner(
                  items: _banners
                      .map<Widget>((i) => BannerImageItem(
                            pic: i.cover,
                            title: i.title,
                            onTaped: () => Utils.openPage(context, i.id, i.type,
                                url: i.url, title: i.title),
                          ))
                      .toList()),
              _getItem2(
                "我的订阅",
                _my_sub,
                icon: Icon(Icons.chevron_right, color: Colors.grey),
                ontap: () => Utils.openSubscribePage(context),
                ratio: getWidth() / ((getWidth() * (360 / 270)) + 24),
              ),
              _getItem(
                "近期必看",
                _recommend,
                ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
              ),
              _getItem("火热专题", _special,
                  needSubTitle: false,
                  imgHeight: 170,
                  imgWidth: 320,
                  count: 2,
                  ratio: getWidth2() / ((getWidth2() * (170 / 320)) + 32),
                  icon: Icon(Icons.chevron_right, color: Colors.grey),
                  ontap: () => Utils.changeComicHomeTabIndex.fire(4)),
              _getItem2("猜你喜欢", _like,
                  icon: Icon(Icons.refresh, color: Colors.grey),
                  ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                  ontap: () async => await loadLike()),
              _getItem(
                "大师级作者怎能不看",
                _authors,
                ratio: getWidth() / ((getWidth() * (360 / 270)) + 24),
              ),
              _getItem("国漫也精彩", _guoman,
                  icon: Icon(Icons.refresh, color: Colors.grey),
                  ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                  ontap: () => loadGuoman()),
              _getItem(
                "美漫大事件",
                _meiman,
                needSubTitle: false,
                imgHeight: 170,
                imgWidth: 320,
                count: 2,
                ratio: getWidth2() / ((getWidth2() * (170 / 320)) + 32),
              ),
              _getItem("热门连载", _hot,
                  icon: Icon(Icons.refresh, color: Colors.grey),
                  ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                  ontap: () => loadHot()),
              _getItem(
                "条漫专区",
                _tiaoman,
                needSubTitle: false,
                imgHeight: 170,
                imgWidth: 320,
                count: 2,
                ratio: getWidth2() / ((getWidth2() * (170 / 320)) + 32),
              ),
              _getItem("动画专区", _anime,
                  icon: Icon(Icons.chevron_right, color: Colors.grey),
                  ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                  ontap: () => Utils.openPage(context, 17192, 11, title: "动画")),
              _getItem2("最新上架", _new,
                  icon: Icon(Icons.chevron_right, color: Colors.grey),
                  ratio: getWidth() / ((getWidth() * (360 / 270)) + 36),
                  ontap: () => Utils.changeComicHomeTabIndex.fire(1)),
              Container(
                width: double.infinity,
                //padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getItem(String title, List items,
      {Icon icon,
      Function ontap,
      bool needSubTitle = true,
      int count = 3,
      double ratio = 3 / 5.2,
      double imgWidth = 270,
      double imgHeight = 360}) {
    return Offstage(
      offstage: items == null || items.length == 0,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)),
          constraints: BoxConstraints(maxWidth: 584),
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
                    items[i].id, items[i].type, items[i].cover, items[i].title,
                    author: needSubTitle ? items[i].sub_title : "",
                    url: items[i].url,
                    width: imgWidth,
                    height: imgHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getItem2(String title, List items,
      {Icon icon,
      Function ontap,
      bool needSubTitle = true,
      int count = 3,
      double ratio = 3 / 5.2,
      double imgWidth = 270,
      double imgHeight = 360}) {
    return Offstage(
        offstage: items == null || items.length == 0,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)),
            constraints: BoxConstraints(maxWidth: 584),
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
                  itemBuilder: (context, i) => _getComicItemBuilder(items[i].id,
                      items[i].type, items[i].cover, items[i].title,
                      author: needSubTitle ? items[i].authors : "",
                      url: items[i].url,
                      width: imgWidth,
                      height: imgHeight),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _getTitle(String title, {Icon icon, Function ontap}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.fromLTRB(4, 4, 4, 0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
        ),
        Offstage(
          offstage: icon == null,
          child: Material(
              color: Theme.of(context).cardColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: ontap,
                child: Padding(
                    padding: EdgeInsets.all(4),
                    child: icon ??
                        Icon(
                          Icons.refresh,
                          color: Colors.grey,
                        )),
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
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: pic,
                  fit: BoxFit.cover,
                  httpHeaders: {"Referer": "http://www.dmzj.com/"},
                  placeholder: (context, url) => AspectRatio(
                    aspectRatio: width / height,
                    child: Container(
                      width: width,
                      height: height,
                      child: Icon(Icons.photo),
                    ),
                  ),
                  errorWidget: (context, url, error) => AspectRatio(
                    aspectRatio: width / height,
                    child: Container(
                      width: width,
                      height: height,
                      child: Icon(Icons.error),
                    ),
                  ),
                )),
            SizedBox(
              height: 4,
            ),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            author == ""
                ? Container()
                : Flexible(
                    child: Text(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ))
          ],
        ),
      ),
    );
  }

  Future refreshData() async {
    await loadData();
  }

  bool _loading = false;
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      _loading = true;
      var response = await http.get(Api.comicRecommend);
      List jsonMap = jsonDecode(response.body);
      //Banner
      {
        List banner_item = jsonMap[0]["data"];
        List<ComicHomeBannerItem> banners =
            banner_item.map((i) => ComicHomeBannerItem.fromJson(i)).toList();
        if (banners.length != 0) {
          setState(() {
            _banners = banners.where((e) => e.type != 10).toList();
          });
        }
      }
      //近期必看
      {
        List recommend_item = jsonMap[1]["data"];
        List<ComicHomeComicItem> recommends =
            recommend_item.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (recommends.length != 0) {
          setState(() {
            _recommend = recommends;
          });
        }
      }
      //火热专题
      {
        List special_item = jsonMap[2]["data"];
        List<ComicHomeComicItem> special =
            special_item.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (special.length != 0) {
          setState(() {
            _special = special;
          });
        }
      }
      //大师级作者
      {
        List author_item = jsonMap[3]["data"];
        List<ComicHomeComicItem> authors =
            author_item.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (authors.length != 0) {
          setState(() {
            _authors = authors;
          });
        }
      }
      //国漫
      {
        List guoman_item = jsonMap[4]["data"];
        List<ComicHomeComicItem> guoman =
            guoman_item.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (guoman.length != 0) {
          setState(() {
            _guoman = guoman;
          });
        }
      }
      //美漫
      {
        List meiman_item = jsonMap[5]["data"];
        List<ComicHomeComicItem> meiman =
            meiman_item.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (meiman.length != 0) {
          setState(() {
            _meiman = meiman;
          });
        }
      }
      //热门连载
      {
        List items = jsonMap[6]["data"];
        List<ComicHomeComicItem> _items =
            items.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (_items.length != 0) {
          setState(() {
            _hot = _items;
          });
        }
      }
      //条漫专区
      {
        List items = jsonMap[7]["data"];
        List<ComicHomeComicItem> _items =
            items.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (_items.length != 0) {
          setState(() {
            _tiaoman = _items;
          });
        }
      }
      //动画专区
      {
        List items = jsonMap[8]["data"];
        List<ComicHomeComicItem> _items =
            items.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (_items.length != 0) {
          setState(() {
            _anime = _items;
          });
        }
      }
      //最新
      {
        List items = jsonMap[9]["data"];
        List<ComicHomeNewItem> _items =
            items.map((i) => ComicHomeNewItem.fromJson(i)).toList();
        if (_items.length != 0) {
          setState(() {
            _new = _items;
          });
        }
      }
      await loadLike();
      await loadMySub();
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
    }
  }

  bool _loading_like = false;
  Future loadLike() async {
    try {
      if (_loading_like) {
        return;
      }
      _loading_like = true;
      var response = await http.get(Api.comicLike);
      var jsonMap = jsonDecode(response.body);
      //最新
      {
        List items = jsonMap["data"]["data"];
        List<ComicHomeNewItem> _items =
            items.map((i) => ComicHomeNewItem.fromJson(i)).toList();
        if (_items.length != 0) {
          setState(() {
            _like = _items;
          });
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _loading_like = false;
    }
  }

  bool _loading_guoman = false;
  Future loadGuoman() async {
    try {
      if (_loading_guoman) {
        return;
      }
      _loading_guoman = true;
      var response = await http.get(Api.comicGuoman);
      var jsonMap = jsonDecode(response.body);
      //最新
      {
        List items = jsonMap["data"]["data"];
        List<ComicHomeComicItem> _items =
            items.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (_items.length != 0) {
          setState(() {
            _guoman = _items;
          });
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _loading_guoman = false;
    }
  }

  bool _loading_hot = false;
  Future loadHot() async {
    try {
      if (_loading_hot) {
        return;
      }
      _loading_hot = true;
      var response = await http.get(Api.comicHot);
      var jsonMap = jsonDecode(response.body);
      //最新
      {
        List items = jsonMap["data"]["data"];
        List<ComicHomeComicItem> _items =
            items.map((i) => ComicHomeComicItem.fromJson(i)).toList();
        if (_items.length != 0) {
          setState(() {
            _hot = _items;
          });
        }
      }
    } catch (e) {
      print(e);
    } finally {
      _loading_hot = false;
    }
  }

  Future loadMySub() async {
    try {
      if (!Provider.of<AppUserInfo>(context, listen: false).isLogin) {
        return;
      }
      var response = await http.get(Api.comicMySub(
          Provider.of<AppUserInfo>(context, listen: false).loginInfo.uid));
      var jsonMap = jsonDecode(response.body);

      List items = jsonMap["data"]["data"];
      List<ComicHomeNewItem> _items =
          items.map((i) => ComicHomeNewItem.fromJson(i)).toList();
      if (_items.length != 0) {
        setState(() {
          _my_sub = _items;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}

class TestData {
  final String pic;
  final String title;
  final String desc;
  TestData(this.pic, this.title, this.desc);
}
