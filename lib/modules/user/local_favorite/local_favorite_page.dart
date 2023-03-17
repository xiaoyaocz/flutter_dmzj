import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/db/local_favorite.dart';
import 'package:flutter_dmzj/modules/user/local_favorite/local_favorite_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_grid_view.dart';
import 'package:flutter_dmzj/widgets/shadow_card.dart';
import 'package:get/get.dart';

class LocalFavoritePage extends StatelessWidget {
  final LocalFavoriteController controller;
  LocalFavoritePage({super.key})
      : controller = Get.put(LocalFavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("本机收藏"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        var count = constraints.maxWidth ~/ 160;
        if (count < 3) count = 3;
        return PageGridView(
          pageController: controller,
          firstRefresh: true,
          crossAxisCount: count,
          padding: AppStyle.edgeInsetsA12,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemBuilder: (context, i) {
            var item = controller.list[i];
            return buildItem(item);
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => Offstage(
          offstage: !controller.editMode.value,
          child: SizedBox(
            height: 48,
            child: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: controller.cancelFavorite,
                    icon: const Icon(Icons.favorite_border),
                    label: const Text("取消收藏"),
                  ),
                  AppStyle.hGap8,
                  TextButton.icon(
                    onPressed: controller.cancelEdit,
                    icon: const Icon(Icons.cancel_outlined),
                    label: const Text("取消"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(LocalFavorite item) {
    return ShadowCard(
      onTap: () {
        if (controller.editMode.value) {
          item.isChecked.value = !item.isChecked.value;
          return;
        }

        AppNavigator.toComicDetail(item.objId);
      },
      onLongPress: () {
        if (controller.editMode.value) {
          return;
        }

        item.isChecked.value = true;
        controller.editMode.value = true;
      },
      radius: 4,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 27 / 36,
                child: NetImage(
                  item.cover,
                  borderRadius: 4,
                ),
              ),
              Padding(
                padding: AppStyle.edgeInsetsA8,
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Positioned(
              right: 0,
              top: 0,
              child: Offstage(
                offstage: !controller.editMode.value,
                child: Checkbox(
                  value: item.isChecked.value,
                  onChanged: (e) {
                    item.isChecked.value = e!;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
