import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/author_detail/author_detail_page.dart';
import 'package:flutter_dmzj/modules/comic/category_detail/category_detail_page.dart';
import 'package:flutter_dmzj/modules/comic/detail/comic_detail_page.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_controller.dart';
import 'package:flutter_dmzj/modules/comic/reader/comic_reader_controller.dart';
import 'package:flutter_dmzj/modules/comic/reader/comic_reader_page.dart';
import 'package:flutter_dmzj/modules/comic/search/comic_search_page.dart';
import 'package:flutter_dmzj/modules/comic/special_detail/special_detail_page.dart';
import 'package:flutter_dmzj/modules/comment/comment_page.dart';
import 'package:flutter_dmzj/modules/common/empty_page.dart';
import 'package:flutter_dmzj/modules/common/test_subroute_page.dart';
import 'package:flutter_dmzj/modules/common/webview/webview_page.dart';
import 'package:flutter_dmzj/modules/index/index_controller.dart';
import 'package:flutter_dmzj/modules/index/index_page.dart';
import 'package:flutter_dmzj/modules/news/detail/news_detail_page.dart';
import 'package:flutter_dmzj/modules/novel/category_detail/novel_category_detail_page.dart';
import 'package:flutter_dmzj/modules/novel/search/novel_search_page.dart';
import 'package:flutter_dmzj/modules/user/history/user_history_page.dart';
import 'package:flutter_dmzj/modules/user/local_history/local_history_page.dart';
import 'package:flutter_dmzj/modules/user/subscribe/user_subscribe_pgae.dart';
import 'package:flutter_dmzj/modules/user/user_home_controller.dart';
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
        BindingsBuilder.put(
          () => UserHomeController(),
        ),
      ],
    ),
    GetPage(
      name: RoutePath.kComicReader,
      page: () => const ComicReaderPage(),
      binding: BindingsBuilder.put(
        () => ComicReaderController(
          comicId: Get.arguments["comicId"],
          comicTitle: Get.arguments["comicTitle"],
          comicCover: Get.arguments["comicCover"],
          chapters: Get.arguments["chapters"],
          chapter: Get.arguments["chapter"],
        ),
      ),
    ),
  ];

  /// 定义子路由
  static Route<dynamic>? generateSubRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return GetPageRoute(
          settings: settings,
          page: () => const EmptyPage(),
        );
      case RoutePath.kTestSubRoute:
        return GetPageRoute(
          settings: settings,
          transition: Transition.native,
          page: () => const TestSubRoutePage(),
        );
      case RoutePath.kNewsDetail:
        var parameter = settings.arguments as Map;
        return GetPageRoute(
          settings: settings,
          page: () => NewsDetailPage(
            title: parameter["title"],
            newsUrl: parameter["newsUrl"],
            newsId: parameter["newsId"],
          ),
        );
      case RoutePath.kComment:
        var parameter = settings.arguments as Map;
        return GetPageRoute(
          settings: settings,
          page: () => CommentPage(
            objId: parameter["objId"],
            type: parameter["type"],
          ),
        );
      case RoutePath.kWebView:
        return GetPageRoute(
          settings: settings,
          page: () => WebViewPage(
            url: settings.arguments.toString(),
          ),
        );
      case RoutePath.kComicCategoryDetail:
        return GetPageRoute(
          settings: settings,
          page: () => CategoryDetailPage(
            settings.arguments as int,
          ),
        );
      case RoutePath.kSpecialDetail:
        return GetPageRoute(
          settings: settings,
          page: () => SpecialDetailPage(
            settings.arguments as int,
          ),
        );
      case RoutePath.kComicAuthorDetail:
        return GetPageRoute(
          settings: settings,
          page: () => ComicAuthorDetailPage(
            settings.arguments as int,
          ),
        );
      case RoutePath.kComicDetail:
        return GetPageRoute(
          settings: settings,
          page: () => ComicDetailPage(
            settings.arguments as int,
          ),
        );
      case RoutePath.kComicSearch:
        return GetPageRoute(
          settings: settings,
          page: () => ComicSearchPage(
            keyword: settings.arguments.toString(),
          ),
        );
      case RoutePath.kNovelSearch:
        return GetPageRoute(
          settings: settings,
          page: () => NovelSearchPage(
            keyword: settings.arguments.toString(),
          ),
        );
      case RoutePath.kNovelCategoryDetail:
        return GetPageRoute(
          settings: settings,
          page: () => NovelCategoryDetailPage(
            settings.arguments as int,
          ),
        );
      case RoutePath.kUserSubscribe:
        return GetPageRoute(
          settings: settings,
          page: () => UserSubscribePage(
            type: settings.arguments as int,
          ),
        );
      case RoutePath.kUserHistory:
        return GetPageRoute(
          settings: settings,
          page: () => UserHistoryPage(
            type: settings.arguments as int,
          ),
        );
      case RoutePath.kLocalHistory:
        return GetPageRoute(
          settings: settings,
          page: () => LocalHistoryPage(
            type: settings.arguments as int,
          ),
        );
      default:
        return GetPageRoute(page: () => const EmptyPage());
    }
  }
}
