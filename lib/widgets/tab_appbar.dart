import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;
  final TabController controller;
  final Widget? action;
  const TabAppBar(
      {required this.tabs, required this.controller, this.action, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: DefaultTabController(
        length: 5,
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(
              top: AppStyle.statusBarHeight, left: 12, right: 4),
          height: 56 + AppStyle.statusBarHeight,
          child: Row(
            children: [
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  controller: controller,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.white70,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                  indicator: RectangularIndicator(
                    color: Colors.white.withOpacity(.8),
                    topLeftRadius: 24,
                    bottomLeftRadius: 24,
                    topRightRadius: 24,
                    bottomRightRadius: 24,
                    verticalPadding: 8,
                  ),
                  tabs: tabs,
                ),
              ),
              action ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56 + AppStyle.statusBarHeight);
}
