import 'dart:convert';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/api/comic.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_dmzj/models/comic/comic_rank_item.dart';
import 'package:flutter_dmzj/protobuf/comic/rank_list_response.pb.dart';
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
  Map<String, int> _tags = {"全部分类": 0};
  String _tag = "全部分类";

  Map<String, int> _byTimes = {
    "日排行": 0,
    "周排行": 1,
    "月排行": 2,
    "总排行": 3,
  };
  String _byTime = "日排行";

  Map<String, int> _types = {
    "人气排行": 0,
    "吐槽排行": 1,
    "订阅排行": 2,
  };
  String _type = "人气排行";

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
              Expanded(child: createFilter(_tags)),
              Expanded(child: createFilter(_types, type: 1)),
              Expanded(child: createFilter(_byTimes, type: 2))
            ],
          ),
        ),
        Expanded(
          child: EasyRefresh(
            onRefresh: () async {
              _page = 1;
              await loadData();
            },
            onLoad: loadData,
            header: MaterialHeader(),
            footer: MaterialFooter(),
            child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (cxt, i) {
                  return createItem(_list[i]);
                }),
          ),
        )
      ],
    );
  }

  Widget createFilter(Map _subTypes, {int type = 0}) {
    String select = _tag;
    if (type == 1) {
      select = _type;
    } else if (type == 2) {
      select = _byTime;
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
            _type = v;
          } else if (type == 2) {
            _byTime = v;
          } else {
            _tag = v;
          }
        });
        print(v);
        _page = 1;
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

  Widget createItem(ComicRankListItemResponse item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.comicId, 1);
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
                      height: 4,
                    ),
                    Text(item.types,
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                        "更新于" +
                            TimelineUtil.format(
                              int.parse(item.lastUpdatetime.toString()) * 1000,
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
                      UserHelper.comicSubscribe(item.comicId);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<ComicRankListItemResponse> _list = [];
  bool _loading = false;
  int _page = 1;

  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var detail = await ComicApi.instance.getRankList(
          tagId: _tags[_tag],
          rankType: _types[_type],
          byTime: _byTimes[_byTime],
          page: _page);
      // var response = await http.get(
      //   Uri.parse(
      //     Api.comicRank(
      //         tagId: _types[_type],
      //         rank: _ranks[_rank],
      //         sort: _sorts[_sort],
      //         page: _page),
      //   ),
      // );
      //List jsonMap = jsonDecode(response.body);

      if (detail != null) {
        setState(() {
          if (_page == 1) {
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
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future loadFilter() async {
    try {
      var response = await http.get(Uri.parse(Api.comicRankFilter()));
      List jsonMap = jsonDecode(response.body);
      List<ComicDetailTagItem> detail =
          jsonMap.map((i) => ComicDetailTagItem.fromJson(i)).toList();
      if (detail != null) {
        Map<String, int> list = {};
        for (var item in detail) {
          list.addAll(
              {(item.tag_id == 0 ? "全部分类" : item.tag_name): item.tag_id});
        }
        setState(() {
          _tags = list;
        });
        await loadData();
      }
    } catch (e) {
      print(e);
    }
  }
}
