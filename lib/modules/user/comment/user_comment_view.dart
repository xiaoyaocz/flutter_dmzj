import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comment/user_comment_item.dart';
import 'package:flutter_dmzj/modules/user/comment/user_comment_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class UserCommentView extends StatelessWidget {
  final int type;
  final int userId;
  final UserCommentController controller;
  UserCommentView({
    required this.type,
    required this.userId,
    Key? key,
  })  : controller = Get.put(
          UserCommentController(
            type: type,
            userId: userId,
          ),
          tag: "${userId}_$type",
        ),
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
        itemBuilder: (context, i) {
          var item = controller.list[i];
          //TODO 跳转评论详情
          return Container(
            padding: AppStyle.edgeInsetsA12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    toDetail(item);
                  },
                  child: NetImage(
                    item.objCover,
                    width: 60,
                    borderRadius: 4,
                  ),
                ),
                AppStyle.hGap12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.objName,
                      ),
                      AppStyle.vGap8,
                      Container(
                        padding: AppStyle.edgeInsetsA8,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.1),
                          borderRadius: AppStyle.radius4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(item.content),
                            Visibility(
                              visible: item.mastercomment != null,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.1),
                                  borderRadius: AppStyle.radius4,
                                ),
                                padding: AppStyle.edgeInsetsA4,
                                margin: AppStyle.edgeInsetsV4,
                                child: Text(
                                  "${item.mastercomment?.nickname}：${item.mastercomment?.content}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            AppStyle.vGap4,
                            Row(
                              children: [
                                const Icon(
                                  Remix.thumb_up_line,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                AppStyle.hGap4,
                                Text(
                                  "${item.likeAmount}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                AppStyle.hGap12,
                                const Icon(
                                  Remix.message_2_line,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                AppStyle.hGap4,
                                Text(
                                  "${item.likeAmount}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  Utils.formatTimestamp(item.createTime),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void toDetail(UserCommentItem item) {
    //漫画
    if (type == 0) {
      AppNavigator.toComicDetail(item.objId);
    } else if (type == 1) {
      AppNavigator.toNovelDetail(item.objId);
    } else if (type == 2) {
      AppNavigator.toNewsDetail(url: item.pageUrl ?? "");
    }
  }
}
