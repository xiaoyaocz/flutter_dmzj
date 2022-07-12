import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/home/recommend/comic_recommend_controller.dart';
import 'package:flutter_dmzj/widgets/error.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/loadding.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class ComicRecommendView extends StatelessWidget {
  const ComicRecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: GetBuilder<ComicRecommendController>(
        init: Get.put(ComicRecommendController()),
        builder: (controller) {
          // 页面错误
          if (controller.pageError) {
            return AppErrorWidget(
              controller.errorMsg,
              onRefresh: () => controller.loadData(),
            );
          }
          return Stack(
            children: [
              EasyRefresh(
                onRefresh: controller.loadData,
                header: MaterialHeader(),
                child: ListView.builder(
                  itemCount: controller.data?.length ?? 0,
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(controller.data![i].title),
                    );
                  },
                ),
              ),
              Visibility(
                visible: controller.pageLoadding,
                child: const LoaddingWidget(),
              ),
            ],
          );
        },
      ),
    );
  }
}
