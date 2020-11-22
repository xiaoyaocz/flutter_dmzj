import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/helper/api.dart';
import 'package:flutter_dmzj/helper/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class LocalComicPage extends StatefulWidget {
  LocalComicPage({Key key}) : super(key: key);

  @override
  _LocalComicPageState createState() => _LocalComicPageState();
}

class _LocalComicPageState extends State<LocalComicPage> {
  String downloadPath = '';
  List<ComicDetail> _list = [];
  bool _loading = true;

  @override
  void initState() {
    initDir().whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _loading && _list.length != 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : EasyRefresh(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Utils.createDetailWidget(_list[index].id, 1,
                      _list[index].cover, _list[index].title, context);
                },
                itemCount: _list.length,
              ),
            ),
    );
  }

  Future initDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory downloadDir = Directory(appDocDir.path + '/downloads');
    assert(await downloadDir.exists() == true);
    downloadPath = downloadDir.path;
    print(downloadPath);
    downloadDir
        .list(recursive: false)
        .toList()
        .then((value) => value.forEach((item) async {
              int id = int.parse(getDirName(item.path));
              print(id);
              await loadDetail(id);
            }));
  }

  Future loadDetail(int comicId) async {
    try {
      var api = Api.comicDetail(comicId);
      Uint8List responseBody;
      var response = await http.get(Api.comicDetail(comicId));
      responseBody = response.bodyBytes;
      var responseStr = utf8.decode(responseBody);
      var jsonMap = jsonDecode(responseStr);

      ComicDetail detail = ComicDetail.fromJson(jsonMap);
      setState(() {
        _list.add(detail);
      });
    } catch (e) {
      print(e);
    }
  }

  String getDirName(String dir) {
    return dir.substring(dir.lastIndexOf('/') + 1);
  }
}
