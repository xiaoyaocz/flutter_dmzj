import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_chapter_view_point.dart';

class ComicTCPage extends StatefulWidget {
  List<ComicChapterViewPoint> list;
  int comic_id;
  int chapter_id;
  ComicTCPage(this.list, this.comic_id, this.chapter_id, {Key key})
      : super(key: key);

  @override
  ComicTCPageState createState() => ComicTCPageState();
}

class ComicTCPageState extends State<ComicTCPage> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("吐槽"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 48),
        child: Wrap(
          children: widget.list.map<Widget>((f) {
            var color = 0.2;
            if (f.num / 100 >= 1) {
              color = 1;
            } else {
              color = (f.num / 100) + 0.2;
              if (color > 1) {
                color = 1;
              }
            }
            return Padding(
              padding: EdgeInsets.all(2),
              child: InkWell(
                onTap: () async {
                  var result =
                      await UserHelper.comicLikeViewPoint(f.id);
                  if (result) {
                    setState(() {
                      f.num++;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(color),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    f.content,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))),
        height: 48,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      hintText: "说点什么吧~"),
                ),
              ),
            ),
            FlatButton.icon(
                onPressed: () async {
                  if (_textEditingController.text.isEmpty) {
                    return;
                  }
                  var result = await UserHelper.comicAddViewPoint(
                      widget.comic_id,
                      widget.chapter_id,
                      _textEditingController.text);
                  if (result) {
                    setState(() {
                      widget.list.add(ComicChapterViewPoint(
                          content: _textEditingController.text,
                          num: 0,
                          page: 0));
                    });
                    _textEditingController.text="";
                  }
                },
                icon: Icon(Icons.send),
                label: Text("发送"))
          ],
        ),
      ),
    );
  }
}
