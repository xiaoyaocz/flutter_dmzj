import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_controller.dart';
import 'package:flutter_dmzj/modules/common/empty_page.dart';
import 'package:flutter_dmzj/modules/index/index_controller.dart';
import 'package:flutter_dmzj/modules/index/index_page.dart';
import 'package:flutter_dmzj/routes/route_path.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const kIndex = RoutePath.kIndex;
  static final routes = [
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexPage(),
      bindings: [
        BindingsBuilder.put(
          () => IndexController(),
        ),
        BindingsBuilder.put(
          () => ComicHomeController(),
        ),
      ],
    ),
  ];

  static Route<dynamic>? generateSubRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return GetPageRoute(
        settings: settings,
        page: () => const EmptyPage(),
      );
    }
    // if (settings.name == RoutePath.kNewsDetail) {
    //   return GetPageRoute(
    //     settings: settings,
    //     //transition: Transition.rightToLeft,
    //     page: () => NewsDetailPage(
    //       settings.arguments as int,
    //     ),
    //   );
    // }
    return GetPageRoute(page: () => Container());
  }
}
