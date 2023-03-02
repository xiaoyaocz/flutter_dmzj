import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comment/comment_list_controller.dart';
import 'package:flutter_dmzj/widgets/comment_item_widget.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:get/get.dart';

class CommentListView extends StatelessWidget {
  final int type;
  final int objId;
  final bool isHot;
  final CommentListController controller;
  CommentListView({
    Key? key,
    required this.objId,
    required this.type,
    required this.isHot,
  })  : controller = Get.put(
          CommentListController(objId: objId, type: type, isHot: isHot),
          tag: "${objId}_${type}_${isHot ? 1 : 0}",
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
          height: 4,
        ),
        itemBuilder: (context, i) {
          var item = controller.list[i];
          return CommentItemWidget(item);
        },
      ),
    );
  }
}
