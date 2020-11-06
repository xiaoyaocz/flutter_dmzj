import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_update_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ComicUpdatePage extends StatefulWidget {
  ComicUpdatePage({Key key}) : super(key: key);

  @override
  _ComicUpdatePageState createState() => _ComicUpdatePageState();
}

class _ComicUpdatePageState extends State<ComicUpdatePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Map _types = {
    "全部漫画": "100",
    "原创漫画": "1",
    "译制漫画": "0",
  };
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

  String _mode = "100";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            children: _types.keys
                .map(
                  (f) => Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: ButtonTheme(
                      minWidth: 20,
                      height: 32,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        textColor: Theme.of(context).accentColor,
                        borderSide: BorderSide(
                            color: _types[f] == _mode
                                ? Theme.of(context).accentColor
                                : Colors.transparent),
                        child: Text(
                          f,
                          style: TextStyle(
                              color: _types[f] == _mode
                                  ? Theme.of(context).accentColor
                                  : Theme.of(context).textTheme.button.color),
                        ),
                        onPressed: () async {
                          _page = 0;
                          setState(() {
                            _mode = _types[f];
                          });
                          await loadData();
                        },
                      ),
                    ),
                  ),
                )
                .toList(),
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
                itemBuilder: (ctx, i) {
                  return Utils.createDetailWidget(
                      _list[i].id, 1, _list[i].cover, _list[i].title, context,
                      category: _list[i].types,
                      author: _list[i].authors,
                      latestChapter: _list[i].last_update_chapter_name,
                      updateTime: _list[i].last_updatetime);
                }),
          ),
        )
      ],
    );
  }

  List<ComicUpdateItem> _list = [];
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
      var response = await http.get(Api.comicUpdate(_mode, page: _page));
      List jsonMap = jsonDecode(response.body);
      List<ComicUpdateItem> detail =
          jsonMap.map((i) => ComicUpdateItem.fromJson(i)).toList();
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
}
