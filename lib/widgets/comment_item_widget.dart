import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/dialog_utils.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comment/comment_item.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:remixicon/remixicon.dart';

// ignore: must_be_immutable
class CommentItemWidget extends StatelessWidget {
  final CommentItem item;
  CommentItemWidget(this.item, {Key? key}) : super(key: key);
  var expand = false.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyle.edgeInsetsA12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: NetImage(
              item.avatarUrl,
              width: 48,
              height: 48,
              borderRadius: 24,
            ),
          ),
          AppStyle.hGap12,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      item.nickname,
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const Text(
                  //   "-",
                  //   style: TextStyle(color: Colors.grey),
                  // )
                ],
              ),
              AppStyle.vGap12,
              item.parents.isNotEmpty
                  ? Obx(
                      () => expand.value
                          ? createMasterCommentAll(item.parents)
                          : createMasterComment(item),
                    )
                  : Container(),
              Text(
                item.content,
                style: Get.theme.textTheme.bodyMedium,
              ),
              item.images.isNotEmpty
                  ? Padding(
                      padding: AppStyle.edgeInsetsT12,
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: item.images.map<Widget>((f) {
                          var str = f.split(".").toList();
                          var fileImg = str[0];
                          var fileImgSuffix = str[1];
                          return InkWell(
                            onTap: () {
                              DialogUtils.showImageViewer(0, [
                                "https://images.dmzj.com/commentImg/${item.objId % 500}/$f"
                              ]);
                            },
                            child: NetImage(
                              "https://images.dmzj.com/commentImg/${item.objId % 500}/${fileImg}_small.$fileImgSuffix",
                              width: 100,
                              height: 100,
                              borderRadius: 4,
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const SizedBox(),
              AppStyle.vGap12,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      Utils.formatTimestamp(item.createTime),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Remix.thumb_up_fill,
                        size: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Visibility(
                        visible: item.likeAmount > 0,
                        child: Padding(
                          padding: AppStyle.edgeInsetsL4,
                          child: Text(
                            item.likeAmount.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget createMasterComment(CommentItem comment) {
    var list = comment.parents;
    if (list.isEmpty) return const SizedBox();
    List<Widget> items = [];
    if (list.length > 2) {
      items.add(createMsterCommentItem(list.first));
      items.add(InkWell(
        onTap: () {
          expand.value = true;
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4)),
          padding: AppStyle.edgeInsetsA8,
          child: Center(
              child: Text(
            "点击展开${list.length - 2}条评论",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )),
        ),
      ));
      items.add(AppStyle.vGap8);
      items.add(createMsterCommentItem(list.last));
    } else {
      for (var item in list) {
        items.add(createMsterCommentItem(item));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget createMasterCommentAll(List<CommentItem> list) {
    List<Widget> items = list.map<Widget>((item) {
      return createMsterCommentItem(item);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget createMsterCommentItem(CommentItem item) {
    return Padding(
      padding: AppStyle.edgeInsetsB8,
      child: InkWell(
        onTap: () {
          // showModalBottomSheet(
          //     context: context,
          //     builder: (ctx) {
          //       return Column(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           ListTile(
          //             title: Text(item.nickname),
          //             leading: Icon(Icons.account_circle),
          //             onTap: () {
          //               Utils.openPage(context, item.sender_uid, 12);
          //             },
          //           ),
          //           ListTile(
          //             title: Text("复制内容"),
          //             leading: Icon(Icons.content_copy),
          //             onTap: () {
          //               Clipboard.setData(ClipboardData(text: item.content));
          //               Fluttertoast.showToast(msg: '已将内容复制到剪贴板');
          //               Navigator.of(context).pop();
          //             },
          //           )
          //         ],
          //       );
          //     });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4)),
          padding: AppStyle.edgeInsetsA8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    alignment: ui.PlaceholderAlignment.middle,
                    child: InkWell(
                      child: Text(
                        item.nickname,
                        style:
                            TextStyle(color: Get.theme.colorScheme.secondary),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ": ${item.content}",
                    style: Get.theme.textTheme.bodyMedium,
                  )
                ]),
              ),
              item.images.isNotEmpty
                  ? Padding(
                      padding: AppStyle.edgeInsetsT8,
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: item.images.map<Widget>((f) {
                          var str = f.split(".").toList();
                          var fileImg = str[0];
                          var fileImgSuffix = str[1];
                          return InkWell(
                            onTap: () {
                              DialogUtils.showImageViewer(0, [
                                "https://images.dmzj.com/commentImg/${item.objId % 500}/$f"
                              ]);
                            },
                            child: NetImage(
                              "https://images.dmzj.com/commentImg/${item.objId % 500}/${fileImg}_small.$fileImgSuffix",
                              width: 100,
                              height: 100,
                              borderRadius: 4,
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
