import 'package:flutter/material.dart';

class CommnetDetailPage extends StatefulWidget {
  final int commentId;

  CommnetDetailPage(this.commentId, {Key key}) : super(key: key);

  @override
  _CommnetDetailPageState createState() => _CommnetDetailPageState();
}

class _CommnetDetailPageState extends State<CommnetDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('评论详情'),
      ),
      body: Text(widget.commentId.toString()),
    );
  }
}
