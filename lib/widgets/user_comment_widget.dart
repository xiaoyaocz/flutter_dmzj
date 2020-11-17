import 'dart:convert';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/user_comment_model.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:html_unescape/html_unescape.dart';

class UserCommentWidget extends StatefulWidget {
  /// Type 0=漫画，1=新闻，2=轻小说
  final int type;
  final int userId;

  UserCommentWidget(
    this.userId, {
    Key key,
    this.type = 0,
  }) : super(key: key);

  @override
  _UserCommentWidgetState createState() => _UserCommentWidgetState();
}

class _UserCommentWidgetState extends State<UserCommentWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int _page = 0;

  List<UserCommentItem> _list = [];

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

  HtmlUnescape _htmlUnescape = new HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      child: _list.length != 0
          ? ListView.builder(
              itemCount: _list.length,
              itemBuilder: (ctx, i) {
                return createItem(_list[i]);
              })
          : _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      "什么都没有呢~",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
      onLoad: loadData,
      onRefresh: () async {
        _page = 0;
        await loadData();
      },
      header: MaterialHeader(),
      footer: MaterialFooter(),
    );
  }

  Widget createItem(UserCommentItem item) {
    var text = _htmlUnescape.convert(item.content);
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: Colors.grey.withOpacity(0.1),
        ),
      )),
      padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 60,
            child: InkWell(
              onTap: () {
                if (widget.type == 2) {
                  Utils.openPage(context, item.obj_id, 7,
                      title: item.obj_name, url: item.obj_cover);
                } else {
                  Utils.openPage(context, item.obj_id, widget.type + 1,
                      url: item.obj_cover);
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Utils.createCacheImage(item.obj_cover, 270, 360),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item.obj_name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  print("打开评论");
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      item.masterComment != null
                          ? createMasterComment(item)
                          : Container(),
                      Text(
                        text,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            child: Text(
                              "点赞" +
                                  (item.like_amount == 0
                                      ? ""
                                      : "(${item.like_amount})"),
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: Text(
                              "回复" +
                                  (item.reply_amount == 0
                                      ? ""
                                      : "(${item.reply_amount})"),
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 12),
                            ),
                          ),
                          Expanded(child: Container()),
                          Text(
                            TimelineUtil.format(
                              item.create_time * 1000,
                              locale: 'zh',
                            ),
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget createMasterComment(UserCommentItem comment) {
    var item = comment.masterComment;
    List<Widget> items = [];

    items.add(createMsterCommentItem(item));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget createMsterCommentItem(UserMasterComment item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4)),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  child: InkWell(
                    child: Text(
                      item.nickname,
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
                TextSpan(
                    text: ": " + _htmlUnescape.convert(item.content),
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color))
              ]),
            ),
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

      var response = await http
          .get(Api.userComment(widget.userId, type: widget.type, page: _page));

      List jsonMap = jsonDecode(response.body);

      List<UserCommentItem> detail =
          jsonMap.map((f) => UserCommentItem.fromJson(f)).toList();
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
