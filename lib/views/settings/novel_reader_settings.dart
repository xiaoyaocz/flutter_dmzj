import 'package:flutter/material.dart';
import 'package:flutter_dmzj/provider/reader_config_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NovelReaderSettings extends StatefulWidget {
  NovelReaderSettings({Key key}) : super(key: key);

  @override
  _NovelReaderSettingsState createState() => _NovelReaderSettingsState();
}

class _NovelReaderSettingsState extends State<NovelReaderSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小说阅读设置'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 80,
                child: Text(
                  "字号  " +
                      Provider.of<ReaderConfigProvider>(context, listen: false)
                          .novelFontSize
                          .toStringAsFixed(0),
                ),
              ),
              Expanded(
                child: createOutlineButton("减小", onPressed: () async {
                  var size = Provider.of<ReaderConfigProvider>(context, listen: false)
                      .novelFontSize;
                  if (size == 10) {
                    Fluttertoast.showToast(msg: '不能再小了');
                    return;
                  }
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelFontSize(size - 1);
                }),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: createOutlineButton("增大", onPressed: () async {
                  var size = Provider.of<ReaderConfigProvider>(context, listen: false)
                      .novelFontSize;
                  if (size == 30) {
                    Fluttertoast.showToast(msg: '不能再大了');
                    return;
                  }
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelFontSize(size + 1);
                }),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 80,
                child: Text(
                  "行距  " +
                      Provider.of<ReaderConfigProvider>(context, listen: false)
                          .novelLineHeight
                          .toStringAsFixed(0),
                ),
              ),
              Expanded(
                child: createOutlineButton("减少", onPressed: () async {
                  var height = Provider.of<ReaderConfigProvider>(context, listen: false)
                      .novelLineHeight;
                  if (height == 0.8) {
                    Fluttertoast.showToast(msg: '不能再减少了');
                    return;
                  }
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelLineHeight(height - 0.1);
                }),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: createOutlineButton("增加", onPressed: () async {
                  var height = Provider.of<ReaderConfigProvider>(context, listen: false)
                      .novelLineHeight;
                  if (height == 2.0) {
                    Fluttertoast.showToast(msg: '不能再增加了');
                    return;
                  }
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelLineHeight(height + 0.1);
                }),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: 80,
                child: Text(
                  "方向",
                ),
              ),
              Expanded(
                child: createOutlineButton("左右",
                    borderColor:
                        Provider.of<ReaderConfigProvider>(context).novelReadDirection == 0
                            ? Colors.blue
                            : null, onPressed: () {
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelReadDirection(0);
                }),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: createOutlineButton("右左",
                    borderColor:
                        Provider.of<ReaderConfigProvider>(context).novelReadDirection == 1
                            ? Colors.blue
                            : null, onPressed: () {
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelReadDirection(1);
                }),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: createOutlineButton("上下",
                    borderColor:
                        Provider.of<ReaderConfigProvider>(context).novelReadDirection == 2
                            ? Colors.blue
                            : null, onPressed: () {
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelReadDirection(2);
                }),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 80,
                child: Text(
                  "主题",
                ),
              ),
              Expanded(
                child: createOutlineButtonColor(ReaderConfigProvider.bgColors[0],
                    borderColor:
                        Provider.of<ReaderConfigProvider>(context).novelReadTheme == 0
                            ? Colors.blue
                            : null, onPressed: () {
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelReadTheme(0);
                }),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: createOutlineButtonColor(ReaderConfigProvider.bgColors[1],
                    borderColor:
                        Provider.of<ReaderConfigProvider>(context).novelReadTheme == 1
                            ? Colors.blue
                            : null, onPressed: () {
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelReadTheme(1);
                }),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: createOutlineButtonColor(ReaderConfigProvider.bgColors[2],
                    borderColor:
                        Provider.of<ReaderConfigProvider>(context).novelReadTheme == 2
                            ? Colors.blue
                            : null, onPressed: () {
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelReadTheme(2);
                }),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: createOutlineButtonColor(ReaderConfigProvider.bgColors[3],
                    borderColor:
                        Provider.of<ReaderConfigProvider>(context).novelReadTheme == 3
                            ? Colors.blue
                            : null, onPressed: () {
                  Provider.of<ReaderConfigProvider>(context, listen: false)
                      .changeNovelReadTheme(3);
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget createOutlineButton(String text,
      {Function onPressed, Color borderColor}) {
    if (borderColor == null) {
      borderColor = Colors.grey.withOpacity(0.6);
    }
    return OutlineButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      borderSide: BorderSide(color: borderColor),
      child: Text(
        text,
      ),
      onPressed: onPressed,
    );
  }

  Widget createOutlineButtonColor(Color color,
      {Function onPressed, Color borderColor}) {
    if (borderColor == null) {
      borderColor = Colors.grey.withOpacity(0.6);
    }
    return InkWell(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
          color: color,
        ),
        height: 32,
      ),
      onTap: onPressed,
    );
  }
}
