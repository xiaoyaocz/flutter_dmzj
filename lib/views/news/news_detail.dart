import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/news/news_stat_detail.dart';
import 'package:flutter_dmzj/widgets/icon_text_button.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class NewsDetailPage extends StatefulWidget {
  final int articleId;
  final String pageUrl;
  final String title;

  NewsDetailPage(this.articleId, this.pageUrl, this.title, {Key key})
      : super(key: key);

  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
    loadStat();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool _isLike = false;
  bool _isSub = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.title + "\r\n" + widget.pageUrl);
            },
          )
        ],
      ),
      body: WebView(
        navigationDelegate: (args) {
          var uri = Uri.parse(args.url);
          print(args.url);
          if (uri.scheme == "dmzjimage") {
            Utils.showImageViewDialog(context, uri.queryParameters["src"]);
          } else if (uri.scheme == "dmzjandroid") {
            //print(uri.path);
            Utils.openPage(context, int.parse(uri.queryParameters["id"]),
                uri.path == "/cartoon_description" ? 1 : 2);
            //print(uri.queryParameters["id"]);
          } else if (uri.scheme == "https" || uri.scheme == "http") {
            //_controller.loadUrl(args.url);
            return NavigationDecision.navigate;
          }

          return NavigationDecision.prevent;
        },
        initialUrl: widget.pageUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (e) {
          //try {
          //_controller.evaluateJavascript(
          // "\$(\".news_box\").css(\"min-height\",\"680px\");");
          //} catch (e) {
          //}
        },
      ),
      bottomNavigationBar: Offstage(
        offstage: widget.articleId == null || widget.articleId == 0,
        child: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconTextButton(
                  Icon(
                    _isLike ? Icons.favorite : Icons.favorite_border,
                    size: 18.0,
                  ),
                  "点赞(${_stat?.mood_amount ?? 0})",
                  addLike),
              IconTextButton(
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 16.0,
                  ),
                  "评论(${_stat?.comment_amount ?? 0})",
                  () => Utils.openCommentPage(
                      context, widget.articleId, 6, widget.title)),
              IconTextButton(
                  Icon(
                    _isSub ? Icons.star : Icons.star_border,
                    size: 18.0,
                  ),
                  _isSub ? "已收藏" : "收藏",
                  addOrCancelSub)
            ],
          ),
        ),
      ),
    );
  }

  NewsStatDetail _stat = NewsStatDetail();
  Future loadStat() async {
    try {
      var api = Api.newsStat(widget.articleId);
      var response = await http.get(Uri.parse(api));
      var jsonMap = jsonDecode(response.body);
      var detail = NewsStatDetail.fromJson(jsonMap["data"]);
      setState(() {
        _stat = detail;
      });
      var result = await UserHelper.newsCheckSub(widget.articleId);
      setState(() {
        _isSub = result;
      });
    } catch (e) {
      print(e);
    }
  }

  void addLike() async {
    try {
      if (_isLike) {
        return;
      }
      var api = Api.addNewsLike(widget.articleId);
      var response = await http.get(Uri.parse(api));
      var jsonMap = jsonDecode(response.body);
      if (jsonMap["code"] == 0) {
        setState(() {
          _isLike = true;
          _stat.mood_amount++;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void addOrCancelSub() async {
    try {
      var result =
          await UserHelper.addOrCancelNewsSub(widget.articleId, _isSub);
      if (result == true) {
        setState(() {
          _isSub = !_isSub;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
