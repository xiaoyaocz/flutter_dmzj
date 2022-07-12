import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/common/empty_page.dart';
import 'package:flutter_dmzj/modules/index/index_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

/// 进入分栏的宽度
const double tabletWidth = 1000;

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = _buildContentNavigator();
    final indexStack = _buildIndexStack();
    return MediaQuery.of(context).size.width > tabletWidth
        ? _buildWide(context, indexStack, content)
        : _buildNarrow(context, indexStack, content);
  }

  Widget _buildNarrow(BuildContext context, Widget indexStack, Widget content) {
    return Stack(
      children: [
        Obx(
          () => Scaffold(
            body: indexStack,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: controller.setIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Remix.bear_smile_line),
                  activeIcon: Icon(Remix.bear_smile_fill),
                  label: "漫画",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Remix.article_line),
                  activeIcon: Icon(Remix.article_fill),
                  label: "资讯",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Remix.book_open_line),
                  activeIcon: Icon(Remix.book_open_fill),
                  label: "轻小说",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Remix.user_smile_line),
                  activeIcon: Icon(Remix.user_smile_fill),
                  label: "我的",
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => IgnorePointer(
            ignoring: !controller.showContent.value,
            child: content,
          ),
        )
      ],
    );
  }

  Widget _buildWide(BuildContext context, Widget indexStack, Widget content) {
    return Scaffold(
      body: Row(
        children: [
          Obx(
            () => Visibility(
              visible: MediaQuery.of(context).size.width > tabletWidth,
              child: Material(
                elevation: 2,
                child: NavigationRail(
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: controller.setIndex,
                  selectedIndex: controller.index.value,
                  backgroundColor: Get.theme.colorScheme.surface,
                  leading: SizedBox(
                    height: Get.statusBarHeight,
                  ),
                  selectedLabelTextStyle: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  unselectedLabelTextStyle: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Remix.bear_smile_line),
                      label: Text("漫画"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Remix.article_line),
                      label: Text("资讯"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Remix.book_open_line),
                      label: Text("轻小说"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Remix.user_smile_line),
                      label: Text("我的"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey.withOpacity(.1),
                  ),
                ),
              ),
              child: indexStack,
            ),
          ),
          Expanded(
            flex: 6,
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildIndexStack() {
    return Obx(
      () => IndexedStack(
        key: controller.indexKey,
        index: controller.index.value,
        children: controller.pages,
      ),
    );
  }

  /// 子路由
  Widget _buildContentNavigator() {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.canPop(Get.context!)) {
          return true;
        }
        if (AppNavigator.contentKey!.currentState!.canPop()) {
          AppNavigator.contentKey!.currentState!.pop();
          return false;
        }
        return true;
      },
      child: ClipRect(
        child: Navigator(
          key: AppNavigator.contentKey,
          initialRoute: '/',
          onUnknownRoute: (settings) => GetPageRoute(
            page: () => const EmptyPage(),
          ),
          observers: [
            SubNavigatorObserver(),
          ],
          onGenerateRoute: AppPages.generateSubRoute,
        ),
      ),
    );
  }
}

/// 子路由监听
class SubNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      var routeName = route.settings.name ?? "";
      AppNavigator.currentContentRouteName = routeName;
      Get.find<IndexController>().showContent.value = routeName != '/';
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    var routeName = previousRoute?.settings.name ?? "";
    AppNavigator.currentContentRouteName = routeName;
    Get.find<IndexController>().showContent.value = routeName != '/';
  }
}
