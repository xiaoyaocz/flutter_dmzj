import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comment/comment_item.dart';

class CommentController extends BasePageController<CommentItem> {
  final int type;
  final int objId;
  CommentController(this.type, this.objId);
}
