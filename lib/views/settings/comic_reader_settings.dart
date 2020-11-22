import 'package:flutter/material.dart';
import 'package:flutter_dmzj/provider/reader_config_provider.dart';
import 'package:provider/provider.dart';

class ComicReaderSettings extends StatefulWidget {
  ComicReaderSettings({Key key}) : super(key: key);

  @override
  _ComicReaderSettingsState createState() => _ComicReaderSettingsState();
}

class _ComicReaderSettingsState extends State<ComicReaderSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('漫画阅读设置'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
              title: Text(
                "使用系统亮度",
              ),
              value: Provider.of<ReaderConfigProvider>(context).comicSystemBrightness,
              onChanged: (e) {
                Provider.of<ReaderConfigProvider>(context, listen: false)
                    .changeComicSystemBrightness(e);
              }),
          !Provider.of<ReaderConfigProvider>(context).comicSystemBrightness
              ? Row(
                  children: <Widget>[
                    SizedBox(width: 12),
                    Icon(
                      Icons.brightness_2,
                      size: 18,
                    ),
                    Expanded(
                        child: Slider(
                            value: Provider.of<ReaderConfigProvider>(context)
                                .comicBrightness,
                            max: 1,
                            min: 0.01,
                            onChanged: (e) {
                              Provider.of<ReaderConfigProvider>(context, listen: false)
                                  .changeBrightness(e);
                            })),
                    Icon(Icons.brightness_5, size: 18),
                    SizedBox(width: 12),
                  ],
                )
              : Container(),
          SwitchListTile(
              title: Text(
                "使用网页API",
              ),
              subtitle: Text(
                "网页API部分单行本不分页",
                style: TextStyle(color: Colors.grey),
              ),
              value: Provider.of<ReaderConfigProvider>(context).comicWebApi,
              onChanged: (e) {
                Provider.of<ReaderConfigProvider>(context, listen: false)
                    .changeComicWebApi(e);
              }),
          SwitchListTile(
              title: Text(
                "竖向阅读",
              ),
              value: Provider.of<ReaderConfigProvider>(context).comicVerticalMode,
              onChanged: (e) {
                Provider.of<ReaderConfigProvider>(context, listen: false)
                    .changeComicVertical(e);
                //Navigator.pop(context);
              }),
          !Provider.of<ReaderConfigProvider>(context).comicVerticalMode
              ? SwitchListTile(
                  title: Text(
                    "日漫模式",
                  ),
                  value: Provider.of<ReaderConfigProvider>(context).comicReadReverse,
                  onChanged: (e) {
                    Provider.of<ReaderConfigProvider>(context, listen: false)
                        .changeReadReverse(e);
                  })
              : Container(),
          SwitchListTile(
              title: Text(
                "屏幕常亮",
              ),
              value: Provider.of<ReaderConfigProvider>(context).comicWakelock,
              onChanged: (e) {
                Provider.of<ReaderConfigProvider>(context, listen: false)
                    .changeComicWakelock(e);
              }),
          SwitchListTile(
              title: Text(
                "全屏阅读",
              ),
              value: Provider.of<ReaderConfigProvider>(context).comicReadShowStatusBar,
              onChanged: (e) {
                Provider.of<ReaderConfigProvider>(context, listen: false)
                    .changeComicReadShowStatusBar(e);
              }),
          SwitchListTile(
              title: Text(
                "显示状态信息",
              ),
              value: Provider.of<ReaderConfigProvider>(context).comicReadShowstate,
              onChanged: (e) {
                Provider.of<ReaderConfigProvider>(context, listen: false)
                    .changeComicReadShowState(e);
              }),
          // SwitchListTile(
          //     title: Text(
          //       "音量键翻页",
          //
          //     ),
          //     value: false,
          //     onChanged: (e) => {})
        ],
      ),
    );
  }
}
