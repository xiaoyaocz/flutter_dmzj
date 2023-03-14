import 'package:flutter/widgets.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comment/comment_item.dart';
import 'package:flutter_dmzj/requests/comment_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AddCommentController extends BaseController {
  final int type;
  final int objId;
  final CommentItem? replyItem;
  AddCommentController({
    required this.objId,
    required this.type,
    this.replyItem,
  });
  final CommentRequest request = CommentRequest();
  final TextEditingController textEditingController = TextEditingController();

  void submit() async {
    if (textEditingController.text.isEmpty) {
      SmartDialog.showToast("内容不能为空");
      return;
    }
    try {
      SmartDialog.showLoading();
      if (replyItem == null) {
        await request.sendComment(
          objId: objId,
          type: type,
          content: textEditingController.text,
        );
      } else {
        await request.sendComment(
          objId: objId,
          type: type,
          content: textEditingController.text,
          toCommentId: replyItem!.id.toString(),
          originCommentId: replyItem!.originId.toString(),
          toUid: replyItem!.userId.toString(),
        );
      }

      SmartDialog.showToast("发表成功");
      AppNavigator.closePage();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
