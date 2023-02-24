import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/modules/comic/home/recommend/comic_recommend_controller.dart';
import 'package:flutter_dmzj/widgets/error.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/loadding.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class ComicRecommendView extends StatelessWidget {
  ComicRecommendView({Key? key}) : super(key: key);
  final ComicRecommendController controller = ComicRecommendController();
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: GetBuilder<ComicRecommendController>(
        init: controller,
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
                header: const MaterialHeader(),
                child: ListView.builder(
                  itemCount: controller.data?.length ?? 0,
                  padding: AppStyle.edgeInsetsA12,
                  itemBuilder: (_, i) {
                    var item = controller.data![i];
                    if (item.categoryId == 46) {
                      return buildBanner(item);
                    }
                    //近期必看\国漫\热门连载\最新上架
                    if (item.categoryId == 47 ||
                        item.categoryId == 52 ||
                        item.categoryId == 54 ||
                        item.categoryId == 56) {
                      return buildCard(
                        context,
                        child: buildTreeColumnGridView(item.data),
                        title: item.title.toString(),
                        action: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.refresh),
                        ),
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
                        action: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.refresh),
                        ),
                      );
                    }
                    if (item.categoryId == 51) {
                      return buildCard(
                        context,
                        child: buildAuthorGridView(item.data),
                        title: item.title.toString(),
                        action: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.refresh),
                        ),
                      );
                    }
                    return buildCard(
                      context,
                      child: Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                      title: item.title.toString(),
                      action: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.refresh),
                      ),
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

  Widget buildCard(
    BuildContext context, {
    required Widget child,
    required String title,
    Widget? action,
  }) {
    return Padding(
      padding: AppStyle.edgeInsetsB12,
      child: Material(
        borderRadius: AppStyle.radius8,
        color: Theme.of(context).cardColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppStyle.radius8,
          ),
          padding: AppStyle.edgeInsetsH12,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 16, height: 1.0),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 48,
                    child: action,
                  ),
                ],
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBanner(ComicRecommendModel item) {
    return Padding(
      padding: AppStyle.edgeInsetsB12,
      child: ClipRRect(
        borderRadius: AppStyle.radius8,
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
            pagination: const SwiperPagination(
                margin: AppStyle.edgeInsetsA8,
                alignment: Alignment.bottomRight),
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
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: items.length,
      itemBuilder: (_, i) {
        var item = items[i];
        return InkWell(
          onTap: () => controller.openDetail(item),
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
              Padding(
                padding: AppStyle.edgeInsetsV4,
                child: Text(
                  item.title,
                  maxLines: 1,
                  style: const TextStyle(height: 1.2),
                  overflow: TextOverflow.ellipsis,
                ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NetImage(
                item.cover,
                width: 64,
                height: 64,
                borderRadius: 32,
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

  Widget buildTwoColumnGridView(List<ComicRecommendItemModel> items) {
    return MasonryGridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: items.length,
      itemBuilder: (_, i) {
        var item = items[i];
        return InkWell(
          onTap: () => controller.openDetail(item),
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
