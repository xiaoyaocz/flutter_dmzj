import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _version = "";
  //String _cacheSize = "计算中";

  PackageInfo _packageInfo;
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        _packageInfo = value;
        _version = "Ver " + _packageInfo.version;
      });
    });
    //getCacheSize();
  }

  void getCacheSize() {
    // var path = await _cacheManager.store.filePath;

    // var dir = await getTemporaryDirectory();
    // int size = 0;
    // for (var item in dir.listSync()) {
    //   size += item.statSync().size;
    // }
    // print(dir.path);
    // setState(() {
    //   _cacheSize = (size / 1024 / 1024).toStringAsFixed(2) + "MB";
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("漫画阅读设置"),
              leading: Icon(Icons.chrome_reader_mode),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () => Navigator.pushNamed(context,
                  '/ComicReaderSettings'), //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("漫画下载设置"),
              leading: Icon(Icons.file_download),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () {
                Fluttertoast.showToast(msg: '老子没写完呢');
                //下载使用API
                //下载允许使用数据
                //下载失败，跳过or失败
                //下载队列数量

                //_cacheManager.emptyCache();
                //Fluttertoast.showToast(msg: '已清除');
              }, //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("小说阅读设置"),
              leading: Icon(Icons.chrome_reader_mode),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () => Navigator.pushNamed(context,
                  '/NovelReaderSettings'), //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("小说下载设置"),
              leading: Icon(Icons.file_download),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () {
                Fluttertoast.showToast(msg: '老子没写完呢');
                //下载使用API
                //下载允许使用数据
                //下载失败，跳过or失败
                //下载队列数量

                //_cacheManager.emptyCache();
                //Fluttertoast.showToast(msg: '已清除');
              }, //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("检查更新"),
              leading: Icon(Icons.update),
              trailing: Text(
                _version,
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              onTap: () async {
                var newVer = await Utils.checkVersion();
                if (newVer == null) {
                  Fluttertoast.showToast(msg: "已经是最新版本了");
                  return;
                }
                if (await Utils.showAlertDialogAsync(
                    context, Text('有新版本可以更新'), Text(newVer.message))) {
                  if (Platform.isAndroid) {
                    launch(newVer.android_url);
                  } else {
                    launch(newVer.ios_url);
                  }
                }
              }, //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("关于"),
              leading: Icon(Icons.info_outline),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () {
                showAboutDialog(
                    applicationIcon: Image(
                      image: AssetImage("assets/ic_launcher.png"),
                      width: 48,
                    ),
                    context: context,
                    applicationVersion: "@xiaoyaocz",
                    applicationLegalese:
                        "此程序仅供学习交流编程技术使用,禁止用于任何商业用途。如侵犯你的合法权益，请联系本人以第一时间删除");
              }, //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
        ],
      ),
    );
  }
}
