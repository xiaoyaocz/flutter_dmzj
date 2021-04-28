import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/models/user/user_subscribe_item.dart';
import 'package:flutter_dmzj/widgets/user_subscribe_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserSubscribePage extends StatefulWidget {
  final int index;
  UserSubscribePage({Key key, this.index = 0}) : super(key: key);

  @override
  _UserSubscribeStatePage createState() => _UserSubscribeStatePage();
}

class _UserSubscribeStatePage extends State<UserSubscribePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.index,
      child: Scaffold(
        appBar: AppBar(
          title: Text("我的订阅"),
          bottom: TabBar(tabs: [
            Tab(
              text: "漫画",
            ),
            Tab(
              text: "轻小说",
            )
          ]),
        ),
        body: TabBarView(
          children: [SubscribeTabView(0), SubscribeTabView(1)],
        ),
      ),
    );
  }
}

class SubscribeTabView extends StatefulWidget {
  final int type;
  SubscribeTabView(this.type, {Key key}) : super(key: key);

  @override
  _SubscribeTabViewState createState() => _SubscribeTabViewState();
}

class _SubscribeTabViewState extends State<SubscribeTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  int _subType = 1;
  List<String> _subTypes = ["全部订阅", "未读", "已读", "完结"];
  int _selectLetters = 0;
  Map _letters = {
    "全部": "all",
    "数字开头": "number",
    "A开头": "a",
    "B开头": "b",
    "C开头": "c",
    "D开头": "d",
    "E开头": "e",
    "F开头": "f",
    "G开头": "g",
    "H开头": "h",
    "I开头": "i",
    "J开头": "j",
    "K开头": "k",
    "L开头": "l",
    "M开头": "m",
    "N开头": "n",
    "O开头": "o",
    "P开头": "p",
    "Q开头": "q",
    "R开头": "r",
    "S开头": "s",
    "T开头": "t",
    "U开头": "u",
    "V开头": "v",
    "X开头": "x",
    "Y开头": "y",
    "Z开头": "z"
  };
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
      header: MaterialHeader(),
      footer: MaterialFooter(),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: PopupMenuButton<String>(
                    child: Container(
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(_selectLetters == 0
                              ? "字母筛选"
                              : _letters.keys.toList()[_selectLetters]),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                    onSelected: (v) async {
                      setState(() {
                        _selectLetters = _letters.values.toList().indexOf(v);
                      });
                      _page = 0;
                      await loadData();
                    },
                    itemBuilder: (c) => _letters.keys
                        .map((f) => CheckedPopupMenuItem<String>(
                              child: Text(f),
                              value: _letters[f],
                              checked: _selectLetters ==
                                  _letters.keys.toList().indexOf(f),
                            ))
                        .toList(),
                  ),
                ),
                Expanded(
                    child: PopupMenuButton<int>(
                  child: Container(
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(_subTypes[_subType - 1]),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          )
                        ],
                      )),
                  onSelected: (v) async {
                    setState(() {
                      _subType = v;
                    });
                    _page = 0;
                    await loadData();
                  },
                  itemBuilder: (c) => _subTypes
                      .map((f) => CheckedPopupMenuItem<int>(
                            child: Text(f),
                            value: _subTypes.indexOf(f) + 1,
                            checked: _subTypes.indexOf(f) + 1 == _subType,
                          ))
                      .toList(),
                ))
              ],
            ),
            _loading && _page == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : UserSubscribeWidget(
                    _list,
                    type: widget.type,
                  ),
          ],
        ),
      ),
      onRefresh: () async {
        _page = 0;

        await loadData();
      },
      onLoad: loadData,
    );
  }

  List<SubscribeItem> _list = [];
  int _page = 0;
  bool _loading = false;
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Uri.parse(Api.userSubscribe(
          widget.type,
          _subType,
          Provider.of<AppUserInfo>(context, listen: false).loginInfo.uid,
          Provider.of<AppUserInfo>(context, listen: false).loginInfo.dmzj_token,
          letter: _letters.values.toList()[_selectLetters],
          page: _page)));

      List jsonMap = jsonDecode(response.body);

      List<SubscribeItem> detail =
          jsonMap.map((f) => SubscribeItem.fromJson(f)).toList();
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
