import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_author_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:http/http.dart' as http;

class ComicAuthorPage extends StatefulWidget {
  int auhtor_id;
  ComicAuthorPage(this.auhtor_id, {Key key}) : super(key: key);

  @override
  _ComicAuthorPageState createState() => _ComicAuthorPageState();
}

class _ComicAuthorPageState extends State<ComicAuthorPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_detail==null? "作者":_detail.nickname+"的作品"),
      ),
      body: EasyRefresh(
        enableControlFinishLoad: false,
        header: MaterialHeader(),
        onRefresh: loadData,
        child: ListView(
          children: _detail!=null? _detail.data.map<Widget>((f) => createItem(f)).toList():[],
        ),
      ),
    );
  }

  ComicAuthor _detail;
  Widget createItem(ComicAuthorItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.id, 1);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 100,
              child: Utils.createCacheImage(item.cover, 270, 360),
            ),
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
                    height: 4,
                  ),
                  Text(item.status,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      maxLines: 1),
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
    );
  }

  bool _loading = false;

  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Api.comicAuthorDetail(widget.auhtor_id));

      var jsonMap = jsonDecode(response.body);

      ComicAuthor detail = ComicAuthor.fromJson(jsonMap);

      setState(() {
        _detail = detail;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
