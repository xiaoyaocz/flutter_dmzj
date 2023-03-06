import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/proto/comic.pb.dart';
import 'package:flutter_dmzj/modules/comic/home/latest/comic_latest_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:get/get.dart';

class ComicLatestView extends StatelessWidget {
  final ComicLatestController controller;
  ComicLatestView({Key? key})
      : controller = Get.put(ComicLatestController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Column(
        children: [
          Row(
            children: [
              AppStyle.hGap12,
              ...controller.types.keys.map(
                (e) => buildFilterButton(
                  title: e,
                  value: controller.types[e],
                ),
              ),
            ],
          ),
          AppStyle.vGap12,
          Expanded(
            child: PageListView(
              pageController: controller,
              firstRefresh: true,
              showPageLoadding: false,
              separatorBuilder: (context, i) => Divider(
                endIndent: 12,
                indent: 12,
                color: Colors.grey.withOpacity(.2),
                height: 1,
              ),
              itemBuilder: (context, i) {
                var item = controller.list[i];
                return buildItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(ComicUpdateListInfoProto item) {
    return InkWell(
      onTap: () {
        AppNavigator.toComicDetail(item.comicId.toInt());
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
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                          text: item.authors,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                  const SizedBox(height: 2),
                  Text(item.types,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(item.lastUpdateChapterName,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(
                      "更新于${Utils.formatTimestamp(item.lastUpdatetime.toInt())}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            Center(
              child: Obx(
                () => UserService.instance.subscribedComicIds
                        .contains(item.comicId.toInt())
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          UserService.instance.cancelSubscribe(
                            [item.comicId.toInt()],
                            AppConstant.kTypeComic,
                          );
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          UserService.instance.addSubscribe(
                            [item.comicId.toInt()],
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

  Widget buildFilterButton({required String title, required int value}) {
    return Container(
      height: 32,
      margin: AppStyle.edgeInsetsR8,
      child: Obx(
        () => TextButton(
          style: TextButton.styleFrom(
            foregroundColor:
                controller.type.value == value ? Colors.blue : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: AppStyle.radius24,
              side: BorderSide(
                color:
                    controller.type.value == value ? Colors.blue : Colors.grey,
              ),
            ),
            textStyle: const TextStyle(fontSize: 14),
            padding: AppStyle.edgeInsetsH16,
          ),
          onPressed: () {
            if (controller.type.value == value) {
              return;
            }
            controller.type.value = value;
            controller.refreshData();
          },
          child: Text(title),
        ),
      ),
    );
  }
}
