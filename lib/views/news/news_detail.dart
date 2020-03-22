import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/widgets/icon_text_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  int article_id;
  String page_url;
  String title;

  NewsDetailPage(this.article_id, this.page_url, this.title, {Key key})
      : super(key: key);

  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.title+ "\r\n"+widget.page_url);
            },
          )
        ],
      ),
      body: WebView(
            onWebViewCreated: (e){
              _controller=e;
            },
              navigationDelegate: (args) {
                var uri = Uri.parse(args.url);
                print(uri.scheme);
                if(uri.scheme=="dmzjimage"){
                  Utils.showImageViewDialog(context, uri.queryParameters["src"]);
                }else if(uri.scheme=="dmzjandroid"){
                   print(uri.queryParameters["id"]);
                }
                else if(uri.scheme=="https"||uri.scheme=="http"){
                  _controller.loadUrl(args.url);
                }
              
                return NavigationDecision.prevent;
              },
              initialUrl: widget.page_url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (e){
                _controller.evaluateJavascript("\$(\".news_box\").css(\"min-height\",\"680px\");");
              },
            ),
      bottomNavigationBar: Offstage(
        offstage: widget.article_id == null || widget.article_id == 0,
        child: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconTextButton(
                  Icon(
                    Icons.favorite_border,
                    size: 18.0,
                  ),
                  "点赞",
                  () => {}),
              IconTextButton(
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 16.0,
                  ),
                  "评论",
                  () => Utils.openCommentPage(context,widget.article_id,6,widget.title)),
              IconTextButton(
                  Icon(
                    Icons.star_border,
                    size: 18.0,
                  ),
                  "收藏",
                  () => {})
            ],
          ),
        ),
      ),
    );
  }

  
}
