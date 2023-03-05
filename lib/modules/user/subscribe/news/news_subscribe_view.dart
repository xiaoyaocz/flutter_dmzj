import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/modules/user/subscribe/news/news_subscribe_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';

import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:get/get.dart';

class NewsSubscribeView extends StatelessWidget {
  final NewsSubscribeController controller;
  NewsSubscribeView({super.key})
      : controller = Get.put(NewsSubscribeController());

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
        itemBuilder: (context, i) {
          var item = controller.list[i];
          return InkWell(
            onTap: () {
              AppNavigator.toNewsDetail(
                newsId: item.subId.toInt(),
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
                                Utils.formatTimestamp(item.subTime.toInt()),
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
}
