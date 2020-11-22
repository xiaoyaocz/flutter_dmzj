import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/helper/api.dart';
import 'package:flutter_dmzj/helper/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_dmzj/models/comic/comic_rank_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ComicRankPage extends StatefulWidget {
  ComicRankPage({Key key}) : super(key: key);

  @override
  _ComicUpdatePageState createState() => _ComicUpdatePageState();
}

class _ComicUpdatePageState extends State<ComicRankPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Map _types = {"全部分类": "0"};
  String _type = "全部分类";

  Map _ranks = {
    "日排行": "0",
    "周排行": "1",
    "月排行": "2",
    "总排行": "3",
  };
  String _rank = "日排行";

  Map _sorts = {
    "人气排行": "0",
    "吐槽排行": "1",
    "订阅排行": "2",
  };
  String _sort = "人气排行";

  @override
  void initState() {
    super.initState();

    loadFilter();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            children: <Widget>[
              Expanded(child: createFilter(_types)),
              Expanded(child: createFilter(_ranks, type: 1)),
              Expanded(child: createFilter(_sorts, type: 2))
            ],
          ),
        ),
        Expanded(
          child: EasyRefresh(
            onRefresh: () async {
              _page = 0;
              await loadData();
            },
            onLoad: loadData,
            header: MaterialHeader(),
            footer: MaterialFooter(),
            child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (cxt, i) {
                  return Utils.createDetailWidget(int.parse(_list[i].comic_id),
                      1, _list[i].cover, _list[i].title, context,
                      category: _list[i].types,
                      author: _list[i].authors,
                      //lastestChapter: _list[i].last_update_chapter_name,
                      updateTime: int.parse(_list[i].last_updatetime));
                }),
          ),
        )
      ],
    );
  }

  Widget createFilter(Map _subTypes, {int type = 0}) {
    String select = _type;
    if (type == 1) {
      select = _rank;
    } else if (type == 2) {
      select = _sort;
    }
    return PopupMenuButton<String>(
      child: Container(
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(select),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )
            ],
          )),
      onSelected: (v) async {
        setState(() {
          if (type == 1) {
            _rank = v;
          } else if (type == 2) {
            _sort = v;
          } else {
            _type = v;
          }
        });
        print(v);
        _page = 0;
        await loadData();
      },
      itemBuilder: (c) => _subTypes.keys
          .map(
            (f) => CheckedPopupMenuItem<String>(
              child: Text(f),
              value: f,
              checked: f == select,
            ),
          )
          .toList(),
    );
  }

  List<ComicRankItem> _list = [];
  bool _loading = false;
  int _page = 0;

  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Api.comicRank(
          tagId: _types[_type],
          rank: _ranks[_rank],
          sort: _sorts[_sort],
          page: _page));
      List jsonMap = jsonDecode(response.body);
      List<ComicRankItem> detail =
          jsonMap.map((i) => ComicRankItem.fromJson(i)).toList();
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

  Future loadFilter() async {
    try {
      var response = await http.get(Api.comicRankFilter());
      List jsonMap = jsonDecode(response.body);
      List<ComicDetailTagItem> detail =
          jsonMap.map((i) => ComicDetailTagItem.fromJson(i)).toList();
      if (detail != null) {
        Map list = {};
        for (var item in detail) {
          list.addAll({
            (item.tag_id == 0 ? "全部分类" : item.tag_name): item.tag_id.toString()
          });
        }
        setState(() {
          _types = list;
        });
        await loadData();
      }
    } catch (e) {
      print(e);
    }
  }
}
