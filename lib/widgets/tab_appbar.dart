import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:get/get.dart';

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
      value: Get.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Container(
        padding: EdgeInsets.only(top: AppStyle.statusBarHeight, right: 4),
        height: 56 + AppStyle.statusBarHeight,
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                isScrollable: true,
                controller: controller,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor:
                    Get.isDarkMode ? Colors.white70 : Colors.black87,
                labelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                labelPadding: AppStyle.edgeInsetsH12,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.transparent,
                tabs: tabs,
              ),
            ),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56 + AppStyle.statusBarHeight);
}
