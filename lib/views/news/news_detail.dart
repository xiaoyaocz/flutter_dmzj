import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/news/news_stat_detail.dart';
import 'package:flutter_dmzj/widgets/icon_text_button.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:http/http.dart' as http;
import 'package:universal_html/parsing.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatefulWidget {
  int article_id;
  String page_url;
  String title;

  NewsDetailPage(this.article_id, this.page_url, this.title, {Key key})
      : super(key: key);

  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
    loadHtml();
    loadStat();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  String _kHtml = "<p></p>";
  String _author = "",
      _photo =
          "https://avatar.dmzj.com/76/39/76399ae2f53695baa2638b67f37fdc17.png",
      _src = "动漫之家",
      _time = "";
  String _title = "";
  void loadHtml() async {
    try {
      var result = await http.get(widget.page_url);
      final htmlDocument = parseHtmlDocument(result.body);
      var news = htmlDocument.documentElement.querySelector('.news_box');
      var title = htmlDocument.documentElement.querySelector('.min_box_tit');
      print(htmlDocument.documentElement.innerHtml);
      setState(() {
        _kHtml = news.innerHtml;
        _title = title.innerText;
        _author = htmlDocument.documentElement.querySelector('.txt1').innerText;
        _src = htmlDocument.documentElement.querySelector('.txt2').innerText;
        _time = htmlDocument.documentElement.querySelector('.txt3').innerText;
      });
    } catch (e) {
      throw e;
    }
  }

  bool _is_like = false;
  bool _is_sub = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.page_url));
            },
          )
        ],
      ),
      body: CupertinoScrollbar(
        child: ListView(
          padding: EdgeInsets.all(12),
          children: [
            Text(
              _title,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "$_author $_src $_time",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(
              height: 12,
            ),
            HtmlWidget(
              _kHtml,
              customWidgetBuilder: (e) {
                if (e.localName == "img") {
                  var imgSrc = e.attributes["src"];
                  if (imgSrc == null) {
                    imgSrc = e.attributes["data-original"];
                  }
                  return InkWell(
                    child: Image.network(
                      imgSrc,
                      headers: {"Referer": "http://www.dmzj.com/"},
                    ),
                    onTap: () {
                      Utils.showImageViewDialog(
                        context,
                        imgSrc,
                      );
                    },
                  );
                }

                return null;
              },
              onTapUrl: (url) {
                var uri = Uri.parse(url);

                if (uri.scheme == "dmzjimage") {
                  Utils.showImageViewDialog(
                      context, uri.queryParameters["src"]);
                } else if (uri.scheme == "dmzjandroid") {
                  Utils.openPage(context, int.parse(uri.queryParameters["id"]),
                      uri.path == "/cartoon_description" ? 1 : 2);
                } else if (uri.scheme == "https" || uri.scheme == "http") {
                  launch(url);
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Offstage(
        offstage: widget.article_id == null || widget.article_id == 0,
        child: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconTextButton(
                  Icon(
                    _is_like ? Icons.favorite : Icons.favorite_border,
                    size: 18.0,
                  ),
                  "点赞(${_stat.mood_amount})",
                  addLike),
              IconTextButton(
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 16.0,
                  ),
                  "评论(${_stat.comment_amount})",
                  () => Utils.openCommentPage(
                      context, widget.article_id, 6, widget.title)),
              IconTextButton(
                  Icon(
                    _is_sub ? Icons.star : Icons.star_border,
                    size: 18.0,
                  ),
                  _is_sub ? "已收藏" : "收藏",
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
      var api = Api.newsStat(widget.article_id);
      var response = await http.get(api);
      var jsonMap = jsonDecode(response.body);
      var detail = NewsStatDetail.fromJson(jsonMap["data"]);
      setState(() {
        _stat = detail;
      });
      var result = await UserHelper.newsCheckSub(widget.article_id);
      setState(() {
        _is_sub = result;
      });
    } catch (e) {
      print(e);
    }
  }

  void addLike() async {
    try {
      if (_is_like) {
        return;
      }
      var api = Api.addNewsLike(widget.article_id);
      var response = await http.get(api);
      var jsonMap = jsonDecode(response.body);
      if (jsonMap["code"] == 0) {
        setState(() {
          _is_like = true;
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
          await UserHelper.addOrCancelNewsSub(widget.article_id, _is_sub);
      if (result == true) {
        setState(() {
          _is_sub = !_is_sub;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
