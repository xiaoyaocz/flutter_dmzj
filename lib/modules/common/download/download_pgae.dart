import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/common/download/download_controller.dart';
import 'package:flutter_dmzj/modules/common/download/downloading_view.dart';
import 'package:get/get.dart';

class DownloadPage extends StatelessWidget {
  final DownloadController controller;
  final int type;
  DownloadPage(this.type, {super.key})
      : controller = Get.put(
          DownloadController(),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: type,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 56),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.blue,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor:
                  Get.isDarkMode ? Colors.white70 : Colors.black87,
              tabs: const [
                Tab(text: "已完成"),
                Tab(text: "下载中"),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Text("0"),
            DownloadingView(),
          ],
        ),
      ),
    );
  }
}
