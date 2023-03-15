import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/novel/category_detail/novel_category_detail_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_grid_view.dart';
import 'package:flutter_dmzj/widgets/shadow_card.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class NovelCategoryDetailPage extends StatelessWidget {
  final int id;
  final NovelCategoryDetailController controller;
  NovelCategoryDetailPage(this.id, {super.key})
      : controller = Get.put(
          NovelCategoryDetailController(id),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.getTitle(),
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) => IconButton(
              icon: const Icon(Remix.filter_line),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: Obx(
          () => SafeArea(
            child: ListView.builder(
              padding: AppStyle.edgeInsetsA12.copyWith(top: 12),
              itemCount: controller.filters.length,
              itemBuilder: (context, i) {
                var item = controller.filters[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: AppStyle.edgeInsetsV12,
                      child: Text(
                        item.title,
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: item.items
                          .map(
                            (x) => OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                foregroundColor: x.tagId == item.selectId.value
                                    ? Colors.blue
                                    : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: x.tagId == item.selectId.value
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              child: Text(
                                x.tagName,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              onPressed: () async {
                                item.selectId.value = x.tagId;

                                Navigator.pop(context);
                                controller.refreshData();
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
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
            return ShadowCard(
              onTap: () {
                AppNavigator.toNovelDetail(item.id);
              },
              radius: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 27 / 36,
                    child: NetImage(
                      item.cover,
                      borderRadius: 4,
                    ),
                  ),
                  AppStyle.vGap4,
                  Padding(
                    padding: AppStyle.edgeInsetsH4,
                    child: Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        height: 1.2,
                      ),
                    ),
                  ),
                  AppStyle.vGap4,
                  Padding(
                    padding: AppStyle.edgeInsetsH4,
                    child: Text(
                      item.authors,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        height: 1.2,
                      ),
                    ),
                  ),
                  AppStyle.vGap4,
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
