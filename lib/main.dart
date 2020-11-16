import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_setting.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/sql/comic_down.dart';
import 'package:flutter_dmzj/sql/comic_history.dart';
import 'package:flutter_dmzj/views/comic/comic_home.dart';
import 'package:flutter_dmzj/views/settings/comic_reader_settings.dart';
import 'package:flutter_dmzj/views/settings/novel_reader_settings.dart';
import 'package:flutter_dmzj/views/user/login_page.dart';
import 'package:flutter_dmzj/views/news/news_home.dart';
import 'package:flutter_dmzj/views/novel/novel_home.dart';
import 'package:flutter_dmzj/views/setting_page.dart';
import 'package:flutter_dmzj/views/user/personal_page.dart';
import 'package:flutter_dmzj/views/user/user_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'app/app_theme.dart';
import 'app/user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigHelper.prefs = await SharedPreferences.getInstance();
  await initDatabase();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme(), lazy: false),
      ChangeNotifierProvider<AppUserInfo>(
          create: (_) => AppUserInfo(), lazy: false),
      ChangeNotifierProvider<AppSetting>(
          create: (_) => AppSetting(), lazy: false),
    ],
    child: MyApp(),
  ));
  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //全局设置透明
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      //light:黑色图标 dark：白色图标
      //在此处设置statusBarIconBrightness为全局设置
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future initDatabase() async {
  var databasesPath = await getDatabasesPath();
  // File(databasesPath+"/nsplayer.db").deleteSync();
  var db = await openDatabase(databasesPath + "/comic_history.db", version: 1,
      onCreate: (Database _db, int version) async {
    await _db.execute('''
create table $comicHistoryTable ( 
  $comicHistoryColumnComicID integer primary key not null, 
  $comicHistoryColumnChapterID integer not null,
  $comicHistoryColumnPage double not null,
  $comicHistoryMode integer not null)
''');

    await _db.execute('''
create table $comicDownloadTableName (
$comicDownloadColumnChapterID integer primary key not null,
$comicDownloadColumnChapterName text not null,
$comicDownloadColumnComicID integer not null,
$comicDownloadColumnComicName text not null,
$comicDownloadColumnStatus integer not null,
$comicDownloadColumnVolume text not null,
$comicDownloadColumnPage integer ,
$comicDownloadColumnCount integer ,
$comicDownloadColumnSavePath text ,
$comicDownloadColumnUrls text )
''');
  });

  ComicHistoryProvider.db = db;
  ComicDownloadProvider.db = db;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '动漫之家Flutter',
      theme: ThemeData(
        brightness: Provider.of<AppTheme>(context).isDark
            ? Brightness.dark
            : Brightness.light,
        primarySwatch: Provider.of<AppTheme>(context).themeColor,
        accentColor: Provider.of<AppTheme>(context).themeColor,
        toggleableActiveColor: Provider.of<AppTheme>(context).themeColor,
        textSelectionColor: Provider.of<AppTheme>(context).themeColor,
      ),
      darkTheme: (Provider.of<AppTheme>(context).sysDark)
          ? ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Provider.of<AppTheme>(context).themeColor,
              accentColor: Provider.of<AppTheme>(context).themeColor,
              toggleableActiveColor: Provider.of<AppTheme>(context).themeColor,
              textSelectionColor: Provider.of<AppTheme>(context).themeColor,
            )
          : null,
      home: MyHomePage(),
      initialRoute: "/",
      routes: {
        "/Setting": (_) => SettingPage(),
        "/Login": (_) => LoginPage(),
        "/User": (_) => UserPage(),
        "/ComicReaderSettings": (_) => ComicReaderSettings(),
        "/NovelReaderSettings": (_) => NovelReaderSettings(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static NewsHomePage newsPage;
  static NovelHomePage novelPage;
  List<Widget> pages = [
    ComicHomePage(),
    Container(),
    Container(),
    PersonalPage()
  ];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    //checkUpdate();
  }

  // void checkUpdate() async {
  //   var newVer = await Utils.checkVersion();
  //   if (newVer == null) {
  //     return;
  //   }
  //   if (await Utils.showAlertDialogAsync(
  //       context, Text('有新版本可以更新'), Text(newVer.message))) {
  //     if (Platform.isAndroid) {
  //       launch(newVer.android_url);
  //     } else {
  //       launch(newVer.ios_url);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        unselectedItemColor: Theme.of(context).disabledColor,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: (index) {
          setState(() {
            if (index == 1 && newsPage == null) {
              newsPage = NewsHomePage();
              pages[1] = newsPage;
            }
            if (index == 2 && novelPage == null) {
              novelPage = NovelHomePage();
              pages[2] = novelPage;
            }
            _index = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "漫画",
            icon: Icon(Icons.photo_album),
          ),
          BottomNavigationBarItem(
            label: "新闻",
            icon: Icon(Icons.article),
          ),
          BottomNavigationBarItem(
            label: "轻小说",
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            label: "我的",
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Row(
        children: <Widget>[
          // NavigationRail(
          //   backgroundColor: Theme.of(context).bottomAppBarColor,
          //     onDestinationSelected: (int index) {
          //       setState(() {
          //         _index = index;
          //       });
          //     },
          //     labelType: NavigationRailLabelType.all,
          //     destinations: [
          //       NavigationRailDestination(
          //         icon: Icon(Icons.library_books),
          //         label: Text('漫画'),
          //       ),
          //       NavigationRailDestination(
          //         icon: Icon(Icons.whatshot),
          //         label: Text('新闻'),
          //       ),
          //       NavigationRailDestination(
          //         icon: Icon(Icons.book),
          //         label: Text('轻小说'),
          //       ),
          //       NavigationRailDestination(
          //         icon: Icon(Icons.account_circle),
          //         label: Text('我的'),
          //       ),
          //     ],
          //     selectedIndex: _index),
          // VerticalDivider(thickness: 1, width: 1),
          Expanded(
              child: IndexedStack(
            index: _index,
            children: pages,
          ))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
