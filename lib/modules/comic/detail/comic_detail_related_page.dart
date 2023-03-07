import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/comic/comic_related_model.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/shadow_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ComicDetailRelatedPage extends StatelessWidget {
  final ComicRelatedModel related;
  const ComicDetailRelatedPage(this.related, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          ListTile(
            title: const Text("作品相关"),
            trailing: IconButton(
              onPressed: () {
                AppNavigator.closePage();
              },
              icon: const Icon(Icons.close),
            ),
            contentPadding: AppStyle.edgeInsetsL12,
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: ListView(
              padding: AppStyle.edgeInsetsA12.copyWith(top: 0),
              children: [
                ...related.authorComics
                    .map(
                      (e) =>
                          buildCard("${e.authorName}的其他作品", e.data, onTap: () {
                        AppNavigator.toComicAuthorDetail(e.authorId);
                      }),
                    )
                    .toList(),
                buildCard("同类题材作品", related.themeComics),
                buildCard("轻小说", related.novels, isComic: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String title, List<ComicRelatedItemModel> list,
      {Function()? onTap, bool isComic = true}) {
    return Visibility(
      visible: list.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: AppStyle.edgeInsetsV8,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Get.textTheme.titleSmall,
                    ),
                  ),
                  Visibility(
                    visible: onTap != null,
                    child: IconButton(
                      onPressed: onTap,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ),
                ],
              )),
          LayoutBuilder(builder: (ctx, constraints) {
            var count = constraints.maxWidth ~/ 160;
            if (count < 3) count = 3;

            return MasonryGridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              crossAxisCount: count,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              itemBuilder: (_, i) {
                var item = list[i];
                return ShadowCard(
                  onTap: () {
                    if (isComic) {
                      AppNavigator.toComicDetail(item.id);
                    } else {
                      AppNavigator.toNovelDetail(item.id);
                    }
                  },
                  radius: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 27 / 36,
                            child: NetImage(
                              item.cover,
                              borderRadius: 4,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: item.status == "连载中"
                                    ? Colors.blue
                                    : Colors.orange,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                              padding: AppStyle.edgeInsetsH8
                                  .copyWith(top: 2, bottom: 2),
                              child: Text(
                                item.status,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppStyle.vGap4,
                      Padding(
                        padding: AppStyle.edgeInsetsA4,
                        child: Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          })
        ],
      ),
    );
  }
}
