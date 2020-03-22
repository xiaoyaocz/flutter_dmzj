import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String url;
  WebViewPage(this.url, {Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController _controller;
  String _title="网页加载中...";

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title),actions: <Widget>[
        IconButton(icon: Icon(Icons.share), onPressed: () async{
          Share.share(
                          "${await _controller.getTitle()}\r\n${await _controller.currentUrl()}");
        }),
        IconButton(icon: Icon(Icons.open_in_browser), onPressed: () async{
          launch(await _controller.currentUrl());
        })
      ],),
      body:WebView(
        onWebViewCreated: (c){
          _controller=c;
        },
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        userAgent:"",
        onPageFinished: (e) async{
          var title=await _controller.getTitle();
          setState(() {
            _title= title;
          });
        },
      ),
    );
  }
}