import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_setting.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/views/comic/comic_home.dart';
import 'package:flutter_dmzj/views/user/login_page.dart';
import 'package:flutter_dmzj/views/news/news_home.dart';
import 'package:flutter_dmzj/views/novel/novel_home.dart';
import 'package:flutter_dmzj/views/setting_page.dart';
import 'package:flutter_dmzj/views/user/personal_page.dart';
import 'package:flutter_dmzj/views/user/user_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_theme.dart';
import 'app/user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigHelper.prefs = await SharedPreferences.getInstance();

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
      ),
      home: MyHomePage(),
      initialRoute: "/",
      routes: {
        "/Setting": (_) => SettingPage(),
        "/Login": (_) => LoginPage(),
        "/User": (_) => UserPage(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
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
            title: Text("漫画"),
            icon: Icon(Icons.library_books),
          ),
          BottomNavigationBarItem(
            title: Text("新闻"),
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            title: Text("轻小说"),
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            title: Text("我的"),
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: pages,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
