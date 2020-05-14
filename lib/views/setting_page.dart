import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _version = "";
  //String _cacheSize = "计算中";
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  PackageInfo _packageInfo;
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        _packageInfo = value;
        _version="Ver "+_packageInfo.version;
      });
    });
    //getCacheSize();
  }

  void getCacheSize()  {
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
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {
                Provider.of<AppTheme>(context, listen: false).changeDark(value);
              },
              secondary: Icon(Icons.brightness_4),
              title: Text("夜间模式"),
              value: Provider.of<AppTheme>(context).isDark,
            ),
          ),
          //主题设置
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("主题切换"),
              leading: Icon(Icons.color_lens),
              trailing: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  Provider.of<AppTheme>(context).themeColorName,
                  style: TextStyle(
                      color: Provider.of<AppTheme>(context).themeColor,
                      fontSize: 14.0),
                ),
              ),
              onTap: () => Provider.of<AppTheme>(context, listen: false)
                  .showThemeDialog(
                      context), //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("清除缓存"),
              leading: Icon(Icons.delete),
              // trailing: Text(
              //   _cacheSize,
              //   style: TextStyle(color: Colors.grey, fontSize: 14.0),
              // ),
               trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              onTap: () 
                  {
                    _cacheManager.emptyCache();
                    Fluttertoast.showToast(msg: '已清除');
                  }, //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("检查更新"),
              leading: Icon(Icons.update),
              trailing: Text(
                _version,
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
              onTap: () =>
                  {}, //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          Container(
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
                    applicationLegalese: "此程序仅供学习交流编程技术使用,如侵犯你的合法权益，请联系本人以第一时间删除");
              }, //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
        ],
      ),
    );
  }
}
