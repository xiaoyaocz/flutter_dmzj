import 'dart:convert';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
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
                  return createItem(_list[i]);
                }),
          ),
        )
      ],
    );
  }

  Widget createItem(ComicUpdateItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.id, 1);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 80,
                    child: Utils.createCacheImage(item.cover, 270, 360),
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: 18,
                        )),
                        TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                            text: item.authors,
                            style: TextStyle(color: Colors.grey, fontSize: 14))
                      ]),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(item.types,
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(item.last_update_chapter_name,
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                        "更新于" +
                            TimelineUtil.format(
                              item.last_updatetime * 1000,
                              locale: 'zh',
                            ),
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              ),
              Center(
                child: IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      UserHelper.comicSubscribe(item.id);
                    }),
              )
            ],
          ),
        ),
      ),
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
