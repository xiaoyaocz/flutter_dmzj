import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/modules/comic/home/recommend/comic_recommend_controller.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:flutter_dmzj/widgets/refresh_until_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class ComicRecommendView extends StatelessWidget {
  final ComicRecommendController controller;
  ComicRecommendView({Key? key})
      : controller = Get.put(ComicRecommendController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        padding: AppStyle.edgeInsetsH12,
        firstRefresh: true,
        loadMore: false,
        showPageLoadding: true,
        itemBuilder: (context, i) {
          var item = controller.list[i];
          if (item.categoryId == 46) {
            return buildBanner(item);
          }
          //随便看看
          if (item.categoryId == 50) {
            return buildCard(
              context,
              child: buildTreeColumnGridView(item.data),
              title: item.title.toString(),
              action: buildRefresh(onRefresh: controller.loadRandom),
            );
          }
          //我的订阅
          if (item.categoryId == 49) {
            return buildCard(
              context,
              child: buildTreeColumnGridView(item.data),
              title: item.title.toString(),
              action: buildShowMore(onTap: controller.toMySubscribe),
            );
          }
          //近期必看\国漫\热门连载\最新上架
          if (item.categoryId == 47 ||
              item.categoryId == 52 ||
              item.categoryId == 54 ||
              item.categoryId == 56) {
            Widget? action;
            //刷新国漫
            if (item.categoryId == 52) {
              action = buildRefresh(onRefresh: controller.refreshGuoman);
            }
            if (item.categoryId == 54) {
              action = buildRefresh(onRefresh: controller.refreshHot);
            }
            return buildCard(
              context,
              child: buildTreeColumnGridView(item.data),
              title: item.title.toString(),
              action: action,
            );
          }
          //火热专题\美漫大事件\条漫
          if (item.categoryId == 48 ||
              item.categoryId == 53 ||
              item.categoryId == 55) {
            return buildCard(
              context,
              child: buildTwoColumnGridView(item.data),
              title: item.title.toString(),
              action: item.categoryId == 48
                  ? buildShowMore(onTap: controller.toSpecial)
                  : null,
            );
          }
          //大师
          if (item.categoryId == 51) {
            return buildCard(
              context,
              child: buildAuthorGridView(item.data),
              title: item.title.toString(),
            );
          }
          return buildCard(
            context,
            child: Container(
              height: 100,
              color: Colors.blue,
            ),
            title: item.title.toString(),
          );
        },
      ),
    );
  }

  Widget buildCard(
    BuildContext context, {
    required Widget child,
    required String title,
    Widget? action,
  }) {
    return Padding(
      padding: AppStyle.edgeInsetsB8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppStyle.radius8,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, height: 1.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: action,
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }

  Widget buildShowMore({required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const Row(
        children: [
          Text(
            "查看更多",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Icon(Icons.chevron_right, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget buildRefresh({required Future Function() onRefresh}) {
    return RefreshUntilWidget(onRefresh: onRefresh, text: "换一批");
  }

  Widget buildBanner(ComicRecommendModel item) {
    return Padding(
      padding: AppStyle.edgeInsetsB12,
      child: ClipRRect(
        borderRadius: AppStyle.radius4,
        child: AspectRatio(
          aspectRatio: 75 / 40,
          child: Swiper(
            itemWidth: 750,
            itemHeight: 400,
            autoplay: true,
            itemCount: item.data.length,
            itemBuilder: (_, i) => NetImage(
              item.data[i].cover,
              width: 750,
              height: 400,
            ),
            onTap: (i) {
              controller.openDetail(item.data[i]);
            },
            pagination: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 12,
                      top: 4,
                      bottom: 4,
                    ),
                    //color: Colors.black12,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black38,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            item.data[config.activeIndex].title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                        AppStyle.hGap8,
                        PageIndicator(
                          controller: config.pageController!,
                          count: config.itemCount,
                          size: 10,
                          layout: PageIndicatorLayout.SCALE,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTreeColumnGridView(List<ComicRecommendItemModel> items) {
    return MasonryGridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: items.length,
      itemBuilder: (_, i) {
        var item = items[i];
        return InkWell(
          onTap: () => controller.openDetail(item),
          borderRadius: AppStyle.radius4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: AppStyle.radius4,
                child: AspectRatio(
                  aspectRatio: 27 / 36,
                  child: NetImage(
                    item.cover,
                    width: 270,
                    height: 360,
                  ),
                ),
              ),
              AppStyle.vGap8,
              Text(
                item.title,
                maxLines: 1,
                style: const TextStyle(height: 1.2),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                item.subTitle ?? item.status ?? '',
                maxLines: 1,
                style: const TextStyle(
                  height: 1.2,
                  fontSize: 12,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AppStyle.vGap8,
            ],
          ),
        );
      },
    );
  }

  Widget buildAuthorGridView(List<ComicRecommendItemModel> items) {
    return MasonryGridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: items.length,
      itemBuilder: (_, i) {
        var item = items[i];
        return InkWell(
          onTap: () => controller.openDetail(item),
          borderRadius: AppStyle.radius8,
          child: Padding(
            padding: AppStyle.edgeInsetsA12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NetImage(
                  item.cover,
                  width: 56,
                  height: 56,
                  borderRadius: 32,
                ),
                Padding(
                  padding: AppStyle.edgeInsetsV8,
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.2, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTwoColumnGridView(List<ComicRecommendItemModel> items) {
    return MasonryGridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: items.length,
      itemBuilder: (_, i) {
        var item = items[i];
        return InkWell(
          onTap: () => controller.openDetail(item),
          borderRadius: AppStyle.radius4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: AppStyle.radius4,
                child: AspectRatio(
                  aspectRatio: 32 / 17,
                  child: NetImage(
                    item.cover,
                    width: 320,
                    height: 170,
                  ),
                ),
              ),
              Padding(
                padding: AppStyle.edgeInsetsV8,
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
