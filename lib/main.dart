import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/db/comic_download_info.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/models/db/novel_download_info.dart';
import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:flutter_dmzj/models/db/novel_history.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dmzj/routes/app_pages.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //初始化服务
  await initServices();
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runZonedGuarded(
    () {
      runApp(const DMZJApp());
    },
    (error, stackTrace) {
      //全局异常
      Log.e(error.toString(), stackTrace);
    },
  );
}

Future initServices() async {
  //包信息
  Utils.packageInfo = await PackageInfo.fromPlatform();
  //本地存储
  Log.d("Init LocalStorage Service");
  await Get.put(LocalStorageService()).init();

  //用户信息
  Log.d("Init User Service");
  Get.put(UserService()).init();

  //注册Hive适配器
  Hive.registerAdapter(ComicHistoryAdapter());
  Hive.registerAdapter(NovelHistoryAdapter());
  Hive.registerAdapter(DownloadStatusAdapter());
  Hive.registerAdapter(ComicDownloadInfoAdapter());
  Hive.registerAdapter(NovelDownloadInfoAdapter());
  await Get.put(DBService()).init();

  //初始化设置服务
  Get.put(AppSettingsService());

  //初始化漫画下载服务
  Get.put(ComicDownloadService()).init();
  //初始化小说下载服务
  Get.put(NovelDownloadService()).init();
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class DMZJApp extends StatelessWidget {
  const DMZJApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '动漫之家 X',
      scrollBehavior: AppScrollBehavior(),
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode:
          ThemeMode.values[Get.find<AppSettingsService>().themeMode.value],
      initialRoute: AppPages.kIndex,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale("zh", "CN"),
      supportedLocales: const [Locale("zh", "CN")],
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(
        loadingBuilder: ((msg) => const AppLoaddingWidget()),
        //字体大小不跟随系统变化
        builder: (context, child) => Obx(
          () => MediaQuery(
            data: AppSettingsService.instance.useSystemFontSize.value
                ? MediaQuery.of(context)
                : MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          ),
        ),
      ),
    );
  }
}
