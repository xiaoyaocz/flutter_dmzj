import 'dart:convert';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comment_model.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:html_unescape/html_unescape.dart';

class CommentWidget extends StatefulWidget {
  /// Type 4=漫画，6=新闻，2=专题，1=轻小说
  final int type;

  final int objId;

  CommentWidget(this.type, this.objId, {Key key}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _isHot = false;

  int _page = 1;

  int _commentCount = 0;

  List<CommentItem> _list = [];

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
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var text = "";
    if (widget.type == 4) {
      text = "漫画";
    } else if (widget.type == 6) {
      text = "新闻";
    } else if (widget.type == 2) {
      text = "专题";
    } else if (widget.type == 4) {
      text = "小说";
    }
    return EasyRefresh(
      //header: MaterialHeader(),
      footer: MaterialFooter(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    text + "评论" + "($_commentCount)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                PopupMenuButton<bool>(
                  child: Container(
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(_isHot ? "热门评论" : "最新评论"),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                          )
                        ],
                      )),
                  onSelected: (v) async {
                    setState(() {
                      _isHot = v;
                    });
                    _page = 1;
                    await loadData();
                  },
                  itemBuilder: (c) => [
                    CheckedPopupMenuItem<bool>(
                      child: Text("最新评论"),
                      value: false,
                      checked: !_isHot,
                    ),
                    CheckedPopupMenuItem<bool>(
                      child: Text("最热评论"),
                      value: true,
                      checked: _isHot,
                    )
                  ],
                )
              ],
            ),
          ),
          _list.length != 0
              ? ListView(
                  padding: EdgeInsets.all(4),
                  shrinkWrap: true,
                  controller: _controller,
                  children: _list.map<Widget>((f) => createItem(f)).toList(),
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      "什么都没有呢~",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
        ],
      ),
      onLoad: loadData,
      // onRefresh: () async {
      //   _page = 1;
      //   await loadData();
      // },
    );
  }

  Widget createItem(CommentItem item) {
    var text = _htmlUnescape.convert(item.content);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(item.nickname),
                    leading: Icon(Icons.account_circle),
                    onTap: () {
                      Utils.openPage(context, item.sender_uid, 12);
                    },
                  ),
                  ListTile(
                    title: Text("点赞"),
                    leading: Icon(Icons.thumb_up),
                    onTap: () {
                      setState(() {
                        item.like_amount++;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text("回复"),
                    leading: Icon(Icons.reply),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text("复制"),
                    leading: Icon(Icons.content_copy),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: item.content));
                      Fluttertoast.showToast(msg: '已将内容复制到剪贴板');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      child: Container(
        padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                Utils.openPage(context, item.sender_uid, 12);
              },
              child: Container(
                width: 48,
                height: 48,
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(item.avatar_url),
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
                        item.nickname,
                        maxLines: 1,
                        style: TextStyle(color: Theme.of(context).accentColor),
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
                item.masterCommentNum != 0
                    ? item.expand
                        ? createMasterCommentAll(item.masterComment)
                        : createMasterComment(item)
                    : Container(),
                Text(
                  text,
                ),
                item.upload_images != null && item.upload_images.length != 0
                    ? Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Wrap(
                          children:
                              item.upload_images.split(",").map<Widget>((f) {
                            var str = f.split(".").toList();
                            var fileImg = str[0];
                            var fileImgSuffix = str[1];
                            return InkWell(
                                onTap: () => Utils.showImageViewDialog(context,
                                    "https://images.dmzj.com/commentImg/${item.obj_id % 500}/$f"),
                                child: Container(
                                  padding: EdgeInsets.only(right: 8),
                                  width: 100,
                                  child: Utils.createCacheImage(
                                      "https://images.dmzj.com/commentImg/${item.obj_id % 500}/${fileImg}_small.$fileImgSuffix",
                                      100,
                                      100),
                                ));
                          }).toList(),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        TimelineUtil.format(
                          item.create_time * 1000,
                          locale: 'zh',
                        ),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "点赞" +
                            (item.like_amount == 0
                                ? ""
                                : "(${item.like_amount})"),
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 12),
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
                            color: Theme.of(context).accentColor, fontSize: 12),
                      ),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget createMasterComment(CommentItem comment) {
    var list = comment.masterComment;

    List<Widget> items = [];
    if (list.length > 2) {
      items.add(createMsterCommentItem(list.first));
      items.add(InkWell(
        onTap: () {
          setState(() {
            comment.expand = true;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4)),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Center(
              child: Text(
            "点击展开${list.length - 2}条评论",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )),
        ),
      ));
      items.add(SizedBox(height: 8));
      items.add(createMsterCommentItem(list.last));
    } else {
      for (var item in list) {
        items.add(createMsterCommentItem(item));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget createMasterCommentAll(List<MasterCommentItem> list) {
    List<Widget> items = list.map<Widget>((item) {
      return createMsterCommentItem(item);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget createMsterCommentItem(MasterCommentItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(item.nickname),
                      leading: Icon(Icons.account_circle),
                      onTap: () {
                        Utils.openPage(context, item.sender_uid, 12);
                      },
                    ),
                    ListTile(
                      title: Text("复制内容"),
                      leading: Icon(Icons.content_copy),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: item.content));
                        Fluttertoast.showToast(msg: '已将内容复制到剪贴板');
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        child: Container(
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
              item.upload_images != null && item.upload_images.length != 0
                  ? Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Wrap(
                        children:
                            item.upload_images.split(",").map<Widget>((f) {
                          var str = f.split(".").toList();
                          var fileImg = str[0];
                          var fileImgSuffix = str[1];
                          return InkWell(
                            onTap: () => Utils.showImageViewDialog(context,
                                "https://images.dmzj.com/commentImg/${item.obj_id % 500}/$f"),
                            child: Container(
                              width: 100,
                              child: Utils.createCacheImage(
                                  "https://images.dmzj.com/commentImg/${item.obj_id % 500}/${fileImg}_small.$fileImgSuffix",
                                  100,
                                  100),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
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
      if (_page == 1) {
        await loadCount();
      }
      var response = await http.get(
          Api.commentV2(widget.objId, widget.type, page: _page, ishot: _isHot));

      List jsonMap = jsonDecode(response.body);

      List<CommentItem> detail =
          jsonMap.map((f) => CommentItem.fromJson(f)).toList();
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
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future loadCount() async {
    try {
      var response =
          await http.get(Api.commentCountV2(widget.objId, widget.type));
      var jsonMap = jsonDecode(response.body);
      int num = jsonMap["data"];
      setState(() {
        _commentCount = num;
      });
    } catch (e) {
      print(e);
    }
  }
}
