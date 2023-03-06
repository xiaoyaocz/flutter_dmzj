import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/comic/author_model.dart';
import 'package:flutter_dmzj/modules/comic/author_detail/author_detail_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class ComicAuthorDetailPage extends StatelessWidget {
  final int id;
  final ComicAuthorDetailController controller;
  ComicAuthorDetailPage(this.id, {super.key})
      : controller = Get.put(
          ComicAuthorDetailController(id),
          tag: "$id",
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NetImage(
                controller.detail.value?.cover ?? "",
                borderRadius: 24,
                width: 32,
                height: 32,
              ),
              AppStyle.hGap8,
              Text(controller.detail.value?.nickname ?? "作者"),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: controller.subscribeAll,
            icon: const Icon(Remix.heart_line),
            label: const Text("全部订阅"),
          ),
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            Offstage(
              offstage: controller.detail.value == null,
              child: ListView.separated(
                itemCount: controller.detail.value?.data.length ?? 0,
                separatorBuilder: (context, i) => Divider(
                  endIndent: 12,
                  indent: 12,
                  color: Colors.grey.withOpacity(.2),
                  height: 1,
                ),
                itemBuilder: (_, i) {
                  var item = controller.detail.value!.data[i];
                  return buildItem(item);
                },
              ),
            ),
            Obx(
              () => Offstage(
                offstage: !controller.pageLoadding.value,
                child: const AppLoaddingWidget(),
              ),
            ),
            Obx(
              () => Offstage(
                offstage: !controller.pageError.value,
                child: AppErrorWidget(
                  errorMsg: controller.errorMsg.value,
                  onRefresh: () => controller.loadData(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(ComicAuthorComicModel item) {
    return InkWell(
      onTap: () {
        AppNavigator.toComicDetail(item.id);
      },
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NetImage(
              item.cover,
              width: 80,
              height: 110,
              borderRadius: 4,
            ),
            AppStyle.hGap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppStyle.vGap4,
                  Text(item.status,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            Center(
              child: Obx(
                () => UserService.instance.subscribedComicIds.contains(item.id)
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          UserService.instance.cancelSubscribe(
                            [item.id],
                            AppConstant.kTypeComic,
                          );
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          UserService.instance.addSubscribe(
                            [item.id],
                            AppConstant.kTypeComic,
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
