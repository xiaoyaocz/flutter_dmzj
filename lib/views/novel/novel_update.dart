import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/helper/api.dart';
import 'package:flutter_dmzj/helper/utils.dart';
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
            return Utils.createDetailWidget(
                _list[i].id, 2, _list[i].cover, _list[i].name, context,
                category: _list[i].type,
                author: _list[i].authors,
                latestChapter: _list[i].last_update_chapter_name,
                updateTime: _list[i].last_update_time);
          }),
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
