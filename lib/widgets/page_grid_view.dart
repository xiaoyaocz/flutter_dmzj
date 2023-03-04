import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/widgets/status/app_empty_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';

class PageGridView extends StatelessWidget {
  final BasePageController pageController;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets? padding;
  final bool firstRefresh;
  final Function()? onLoginSuccess;
  final bool showPageLoadding;
  final double crossAxisSpacing, mainAxisSpacing;
  final int crossAxisCount;
  final bool loadMore;
  const PageGridView({
    required this.itemBuilder,
    required this.pageController,
    this.padding,
    this.firstRefresh = false,
    this.showPageLoadding = false,
    this.onLoginSuccess,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    required this.crossAxisCount,
    this.loadMore = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          EasyRefresh(
            header: const MaterialHeader(),
            footer: loadMore
                ? const MaterialFooter(
                    clamping: false, infiniteOffset: 70, triggerOffset: 70)
                : null,
            controller: pageController.easyRefreshController,
            refreshOnStart: firstRefresh,
            onLoad: loadMore ? pageController.loadData : null,
            onRefresh: pageController.refreshData,
            child: MasonryGridView.count(
              padding: padding,
              controller: pageController.scrollController,
              itemCount: pageController.list.length,
              itemBuilder: itemBuilder,
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ),
          ),
          Offstage(
            offstage: !pageController.pageEmpty.value,
            child: AppEmptyWidget(
              onRefresh: () => pageController.refreshData(),
            ),
          ),
          Offstage(
            offstage: !(showPageLoadding && pageController.pageLoadding.value),
            child: const AppLoaddingWidget(),
          ),
          Offstage(
            offstage: !pageController.pageError.value,
            child: AppErrorWidget(
              errorMsg: pageController.errorMsg.value,
              onRefresh: () => pageController.refreshData(),
            ),
          ),
        ],
      ),
    );
  }
}
