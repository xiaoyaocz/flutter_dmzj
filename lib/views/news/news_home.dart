import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/news/new_list_item_model.dart';
import 'package:flutter_dmzj/models/news/news_banner_model.dart';
import 'package:flutter_dmzj/models/news/news_tag_model.dart';
import 'package:flutter_dmzj/views/news/news_detail.dart';
import 'package:flutter_dmzj/widgets/app_banner.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class NewsHomePage extends StatefulWidget {
  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>
    with TickerProviderStateMixin {
  List<NewsTagItemModel> _tabItems = [];

  bool _loading = false;
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabItems.length, vsync: this);
    loadCate();
  }

  Future loadCate() async {
    try {
      var response = await http.get(Api.newsCategory);
      List jsonMap = jsonDecode(response.body);
      List<NewsTagItemModel> data =
          jsonMap.map((i) => NewsTagItemModel.fromJson(i)).toList();
      setState(() {
        data.insert(0, NewsTagItemModel(tag_id: 0, tag_name: "最新"));

        _tabItems = data;
      });
      print(_tabItems);
    } catch (e) {
      Utils.showSnackbarWithAction(context, "加载数据出现错误", "重试", () => loadCate());
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _tabController = new TabController(length: _tabItems.length, vsync: this);
    return Scaffold(
        appBar: AppBar(
          title: TabBar(
            controller: _tabController,
            tabs: _tabItems.map((x) => Tab(child: Text(x.tag_name))).toList(),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabItems.map((x) => createTabView(x)).toList(),
        ));
  }

  Widget createTabView(NewsTagItemModel item) {
    if (item.tag_id == 0) {
      return NewsNewTabView(item.tag_id, true);
    } else {
      return NewsNewTabView(item.tag_id, false);
    }
  }
}

class NewsNewTabView extends StatefulWidget {
  int id;
  bool hasBanner = false;
  NewsNewTabView(this.id, this.hasBanner, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NewsNewTabViewState();
  }
}

class NewsNewTabViewState extends State<NewsNewTabView>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();
  List<NewsBannerItemModel> _banners = [];
  List<NewsListItemModel> _news = [];
  int _page = 0;
  bool _loading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: refreshData,
      child: widget.hasBanner
          ? SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: <Widget>[
                  AppBanner(
                      items: _banners
                          .map<Widget>((i) => BannerImageItem(
                                pic: i.pic_url,
                                title: i.title,
                                onTaped: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => NewsDetailPage(
                                            i.object_id,
                                            i.object_url,
                                            i.title))),
                              ))
                          .toList()),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _news.length + 1,
                    itemBuilder: listItemBuilder,
                  )
                ],
              ))
          : ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: _news.length + 1,
              itemBuilder: listItemBuilder,
            ),
    );
  }

  Widget listItemBuilder(context, index) {
    return index != _news.length
        ? InkWell(
          onTap: ()=>Utils.openPage(context, _news[index].article_id, 7,title:_news[index].title,url:_news[index].page_url ),
          child: Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Container(
              padding: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                border: Border(bottom:BorderSide(color:Colors.grey.withOpacity(0.1)))
              ),
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 62,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Utils.createCacheImage(
                        _news[index].row_pic_url, 720, 450),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 44,
                        child: Text(_news[index].title),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              TimelineUtil.format(
                                  _news[index].create_time * 1000),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                child: Icon(
                                  Icons.thumb_up,
                                  size: 12.0,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                              ),
                              Text(
                                _news[index].mood_amount.toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Padding(
                                child: Icon(Icons.chat,
                                    size: 12.0, color: Colors.grey),
                                padding: EdgeInsets.fromLTRB(8, 0, 4, 0),
                              ),
                              Text(
                                _news[index].comment_amount.toString(),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                
              ],
            ),
            ),
          ),
        )
        : Offstage(
            child: Center(
              child: Padding(
                child: Text("加载中..."),
                padding: EdgeInsets.all(8),
              ),
            ),
            offstage: _loading,
          );
  }

  Future refreshData() async {
    _page = 0;
    _news = [];
    _banners = [];
    await loadData();
  }

  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      _loading = true;
      if (_page == 0 && widget.hasBanner) {
        await loadBanner();
      }
      var response = await http.get(Api.newsList(widget.id, page: _page));
      List jsonMap = jsonDecode(response.body);
      List<NewsListItemModel> data =
          jsonMap.map((i) => NewsListItemModel.fromJson(i)).toList();
      if (data.length != 0) {
        setState(() {
          _news.addAll(data);
        });
        _page++;
      }
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
    }
  }

  Future loadBanner() async {
    try {
      var response = await http.get(Api.newsBanner);

      NewsBannerModel data =
          NewsBannerModel.fromJson(jsonDecode(response.body));
      if (data.code == 0) {
        setState(() {
          _banners = data.data;
        });
      }
    } catch (e) {
      print(e);
    } finally {}
  }
}
