import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/news/news_tag_model.dart';
import 'package:flutter_dmzj/modules/news/home/news_list_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';

class NewsListView extends StatelessWidget {
  final NewsTagModel tag;
  final NewsListController controller;
  NewsListView({Key? key, required this.tag})
      : controller =
            Get.put(NewsListController(tag), tag: tag.tagId.toString()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: PageListView(
        pageController: controller,
        firstRefresh: true,
        separatorBuilder: (context, i) => Divider(
          endIndent: 12,
          indent: 12,
          color: Colors.grey.withOpacity(.2),
          height: 1,
        ),
        header: tag.tagId == 0 ? buildBanner() : null,
        itemBuilder: (context, i) {
          var item = controller.list[i];
          return InkWell(
            onTap: () {
              AppNavigator.toNewsDetail(
                newsId: item.articleId.toInt(),
                title: item.title,
                url: item.pageUrl,
              );
            },
            child: Container(
              padding: AppStyle.edgeInsetsA12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NetImage(
                    item.rowPicUrl,
                    width: 100,
                    height: 62,
                    borderRadius: 4,
                  ),
                  AppStyle.hGap12,
                  Expanded(
                    child: SizedBox(
                      height: 62,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              item.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                Utils.formatTimestamp(item.createTime.toInt()),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.thumb_up,
                                    size: 12.0,
                                    color: Colors.grey,
                                  ),
                                  AppStyle.hGap4,
                                  Text(
                                    item.moodAmount.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  AppStyle.hGap8,
                                  const Icon(
                                    Icons.chat,
                                    size: 12.0,
                                    color: Colors.grey,
                                  ),
                                  AppStyle.hGap4,
                                  Text(
                                    item.commentAmount.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBanner() {
    return Padding(
      padding: AppStyle.edgeInsetsH12.copyWith(bottom: 4),
      child: Obx(
        () => ClipRRect(
          borderRadius: AppStyle.radius4,
          child: AspectRatio(
            aspectRatio: 75 / 40,
            child: controller.banners.isEmpty
                ? const SizedBox()
                : Swiper(
                    itemWidth: 750,
                    itemHeight: 400,
                    autoplay: true,
                    itemCount: controller.banners.length,
                    onTap: (i) {
                      controller.openBanner(controller.banners[i]);
                    },
                    itemBuilder: (_, i) => NetImage(
                      controller.banners[i].picUrl,
                      width: 750,
                      height: 400,
                    ),
                    pagination: SwiperCustomPagination(
                      builder:
                          (BuildContext context, SwiperPluginConfig config) {
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
                                    controller
                                        .banners[config.activeIndex].title,
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
      ),
    );
  }
}
