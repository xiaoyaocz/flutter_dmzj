import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/comic/special_detail_model.dart';
import 'package:flutter_dmzj/modules/comic/special_detail/special_detail_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/status/app_error_widget.dart';
import 'package:flutter_dmzj/widgets/status/app_loadding_widget.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class SpecialDetailPage extends StatelessWidget {
  final int id;
  final SpecialDetailController controller;
  SpecialDetailPage(this.id, {super.key})
      : controller = Get.put(
          SpecialDetailController(id),
          tag: "$id",
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.detail.value?.title ?? "专题"),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Offstage(
              offstage: controller.detail.value == null,
              child: ListView.separated(
                itemCount: (controller.detail.value?.comics.length ?? 0) + 1,
                separatorBuilder: (context, i) => Divider(
                  endIndent: 12,
                  indent: 12,
                  color: Colors.grey.withOpacity(.2),
                  height: 1,
                ),
                itemBuilder: (_, i) {
                  if (i == 0) {
                    return buildHeader();
                  }
                  var item = controller.detail.value!.comics[i - 1];
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
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: controller.subscribeAll,
                  icon: const Icon(
                    Remix.heart_line,
                    size: 20,
                  ),
                  label: const Text("订阅全部"),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: controller.share,
                  icon: const Icon(
                    Remix.share_box_line,
                    size: 20,
                  ),
                  label: const Text("分享"),
                ),
              ),
              Expanded(
                child: Obx(
                  () => TextButton.icon(
                    onPressed: controller.comment,
                    icon: const Icon(
                      Remix.chat_2_line,
                      size: 20,
                    ),
                    label: Text(
                        "评论(${controller.detail.value?.commentAmount ?? 0})"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(ComicSpecialComicModel item) {
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
                  Text(item.recommendBrief,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  AppStyle.vGap4,
                  Text(item.recommendReason,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            Center(
              //TODO 订阅处理
              child: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  UserService.instance.subscribeComic(item.id);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    if (controller.detail.value == null) {
      return const SizedBox();
    }
    var detail = controller.detail.value!;
    return Padding(
      padding: AppStyle.edgeInsetsA12,
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: AspectRatio(
              aspectRatio: 710 / 354,
              child: NetImage(
                detail.mobileHeaderPic,
                borderRadius: 8,
                width: 710,
                height: 354,
              ),
            ),
          ),
          AppStyle.vGap12,
          Text(
            detail.description,
          ),
        ],
      ),
    );
  }
}
