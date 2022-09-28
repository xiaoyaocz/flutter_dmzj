import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_category_item.dart';
import 'package:http/http.dart' as http;

class ComicCategoryPage extends StatefulWidget {
  ComicCategoryPage({Key key}) : super(key: key);

  @override
  _ComicCategoryPageState createState() => _ComicCategoryPageState();
}

class _ComicCategoryPageState extends State<ComicCategoryPage>
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

  double getWidth() {
    var count = MediaQuery.of(context).size.width ~/ 160;
    if (count < 3) count = 3;
    return (MediaQuery.of(context).size.width - count * 8) / count - 8;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: loadData,
      child: GridView.builder(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: _list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 160 < 3
                ? 3
                : MediaQuery.of(context).size.width ~/ 160,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: getWidth() / (getWidth() + 32)),
        itemBuilder: (context, i) => Container(
          child: Card(
            child: InkWell(
              onTap: () {
                Utils.openPage(context, _list[i].tag_id, 11,
                    title: _list[i].title);
              },
              child: Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Utils.createCacheImage(_list[i].cover, 200, 200)),
                  SizedBox(height: 4),
                  Flexible(
                    child: Text(_list[i].title),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<ComicCategoryItem> _list = [];
  bool _loading = false;
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Uri.parse(Api.comicCategory()));
      List jsonMap = jsonDecode(response.body);
      List<ComicCategoryItem> detail =
          jsonMap.map((i) => ComicCategoryItem.fromJson(i)).toList();
      if (detail != null) {
        setState(() {
          _list = detail;
        });
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
