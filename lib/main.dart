import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/common/empty_page.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/routes/app_pages.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(const DMZJApp());
}

class DMZJApp extends StatelessWidget {
  const DMZJApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '动漫之家 Flutter',
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.kIndex,
      getPages: AppPages.routes,
    );
  }
}
