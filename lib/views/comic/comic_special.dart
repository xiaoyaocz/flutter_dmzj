import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_special_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ComicSpecialPage extends StatefulWidget {
  ComicSpecialPage({Key key}) : super(key: key);

  @override
  _ComicSpecialPageState createState() => _ComicSpecialPageState();
}

class _ComicSpecialPageState extends State<ComicSpecialPage>
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

  List<ComicSpecialItem> _list = [];
  bool _loading = false;
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        onRefresh: () async {
          _page = 0;
          await loadData();
        },
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onLoad: loadData,
        child: 
        ListView.builder(
              itemCount:_list.length,
              itemBuilder: (cxt,i){
                var f=_list[i];
              return Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Card(
                      child: RawMaterialButton(
                      onPressed: (){
                        Utils.openPage(context, f.id, 5);
                      },
                      child:Container(
                    padding: EdgeInsets.all(4),
                    child:  Column(
                        children: <Widget>[
                          Utils.createCacheImage(f.small_cover, 710, 280),
                          SizedBox(height: 4),
                          Row(
                            children: <Widget>[
                              Expanded(child: Text(f.title)),
                              Text(DateUtil.formatDate(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      f.create_time * 1000),
                                  format: "yyyy-MM-dd"),style: TextStyle(color: Colors.grey,fontSize: 12),),
                            ],
                          ),
                          SizedBox(height: 4),
                        ],
                      )),
                    ),
                  ));
            }
            
       
        ),);
  }

  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Api.comicSpecial(page: _page));
      List jsonMap = jsonDecode(response.body);
      List<ComicSpecialItem> detail =
          jsonMap.map((i) => ComicSpecialItem.fromJson(i)).toList();
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
