import 'dart:convert';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/novel/novel_update_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class NovelUpdatePage extends StatefulWidget {
  NovelUpdatePage({Key key}) : super(key: key);

  @override
  _NovelUpdatePageState createState() => _NovelUpdatePageState();
}

class _NovelUpdatePageState extends State<NovelUpdatePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
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
    );
  }

  Widget createItem(NovelUpdateItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.id, 2, url: item.cover, title: item.name);
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
                      child: Hero(
                        tag: item.id,
                        child: Utils.createCacheImage(item.cover, 270, 360),
                      ))),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      maxLines: 1,
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
                    Text(item.type ?? "",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(item.last_update_chapter_name ?? "",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                        "更新于" +
                            TimelineUtil.format(
                              item.last_update_time * 1000,
                              locale: 'zh',
                            ),
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<NovelUpdateItem> _list = [];
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
      var response = await http.get(Api.novelUpdate(page: _page));
      List jsonMap = jsonDecode(response.body);
      List<NovelUpdateItem> detail =
          jsonMap.map((i) => NovelUpdateItem.fromJson(i)).toList();
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
