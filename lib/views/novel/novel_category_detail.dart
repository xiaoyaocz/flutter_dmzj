import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_category_detail_filter.dart';
import 'package:flutter_dmzj/models/novel/novel_category_detail_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class NovelCategoryDetailPage extends StatefulWidget {
  final String title;
  final int id;
  NovelCategoryDetailPage(this.id, this.title, {Key key}) : super(key: key);

  @override
  _NovelCategoryDetailPageState createState() =>
      _NovelCategoryDetailPageState();
}

class _NovelCategoryDetailPageState extends State<NovelCategoryDetailPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadFiters();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  double getWidth() {
    var count = MediaQuery.of(context).size.width ~/ 160;
    if (count < 3) count = 3;
    return (MediaQuery.of(context).size.width - count * 8) / count - 8;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: createFilter(),
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        child: _list.length != 0
            ? GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                physics: ScrollPhysics(),
                itemCount: _list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width ~/ 160 < 3
                        ? 3
                        : MediaQuery.of(context).size.width ~/ 160,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio:
                        getWidth() / ((getWidth() * (360 / 270)) + 48)),
                itemBuilder: (context, i) => _getComicItemBuilder(
                    _list[i].id, _list[i].cover, _list[i].name,
                    author: _list[i].authors ?? ""),
              )
            : _loading
                ? _page == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
                : Center(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        "什么都没有呢~",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
        onRefresh: () async {
          _page = 0;

          await loadData();
        },
        onLoad: loadData,
      ),
    );
  }

  Widget createFilter() {
    var list = _fiters
        .map<Widget>(
          (f) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  f.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: f.items
                    .map((x) => Padding(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          child: ButtonTheme(
                            minWidth: 20,
                            height: 28,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: x == f.item
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.transparent),
                                  ),
                                ),
                                foregroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.secondary),
                              ),
                              child: Text(
                                x.tag_name,
                                style: TextStyle(
                                    color: x == f.item
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Theme.of(context)
                                            .textTheme
                                            .button
                                            .color),
                              ),
                              onPressed: () async {
                                _page = 0;
                                setState(() {
                                  f.item = x;
                                });
                                Navigator.pop(context);
                                await loadData();
                              },
                            ),
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        )
        .toList();
    list.insert(
        0,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                "排序",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  child: ButtonTheme(
                    minWidth: 20,
                    height: 28,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: _sort == 0
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.transparent),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      child: Text(
                        "人气排序",
                        style: TextStyle(
                            color: _sort == 0
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).textTheme.button.color),
                      ),
                      onPressed: () async {
                        _page = 0;
                        setState(() {
                          _sort = 0;
                        });
                        Navigator.pop(context);
                        await loadData();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4, right: 4),
                  child: ButtonTheme(
                    minWidth: 20,
                    height: 28,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: _sort == 1
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.transparent),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      child: Text(
                        "更新排序",
                        style: TextStyle(
                            color: _sort == 1
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).textTheme.button.color),
                      ),
                      onPressed: () async {
                        _page = 0;
                        setState(() {
                          _sort = 1;
                        });
                        Navigator.pop(context);
                        await loadData();
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ));
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(children: list),
    );
  }

  Widget _getComicItemBuilder(int id, String pic, String title,
      {String author = ""}) {
    return Card(
      child: InkWell(
          onTap: () => Utils.openPage(context, id, 2, title: title),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Utils.createCacheImage(pic, 270, 360),
                Padding(
                  padding:
                      EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                )),
              ],
            ),
          )),
    );
  }

  List<NovelCategoryDetailItem> _list = [];
  int _page = 0;
  bool _loading = false;

  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Uri.parse(Api.novelCategoryDetail(
          cateId: _fiters[0].item.tag_id,
          status: _fiters[1].item.tag_id,
          sort: _sort,
          page: _page)));

      List jsonMap = jsonDecode(response.body);

      List<NovelCategoryDetailItem> detail =
          jsonMap.map((f) => NovelCategoryDetailItem.fromJson(f)).toList();
      if (detail != null) {
        setState(() {
          if (_page == 0) {
            _list = detail;
          } else {
            _list.addAll(detail);
          }
        });
        if (detail.length != 0) {
          _page++;
        } else {
          Fluttertoast.showToast(msg: "加载完毕");
        }
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  List<ComicCategoryDetailFilter> _fiters = [];
  int _sort = 0;
  Future loadFiters() async {
    try {
      var response = await http.get(Uri.parse(Api.novelCategoryFilter));
      List jsonMap = jsonDecode(response.body);
      List<ComicCategoryDetailFilter> detail =
          jsonMap.map((f) => ComicCategoryDetailFilter.fromJson(f)).toList();
      if (detail != null) {
        for (var item in detail) {
          var _item = item.items
              .firstWhere((f) => f.tag_id == widget.id, orElse: () => null);
          if (_item != null) {
            item.item = _item;
          } else {
            item.item = item.items[0];
          }
        }
        setState(() {
          _fiters = detail;
        });
        loadData();
      }
    } catch (e) {
      print(e);
    }
  }
}
