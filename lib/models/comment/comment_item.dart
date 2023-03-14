import 'package:get/get.dart';

/// 动漫之家评论接口太TM混乱了
/// 使用此类统一Model

class CommentItem {
  CommentItem({
    required this.id,
    required this.objId,
    required this.content,
    required this.avatarUrl,
    required this.createTime,
    required this.images,
    required this.likeAmount,
    required this.nickname,
    required this.replyAmount,
    required this.userId,
    required this.gender,
    required this.type,
    required this.originId,
    this.isEmpty = false,
  });

  factory CommentItem.createEmpty() {
    return CommentItem(
      id: 0,
      objId: 0,
      content: "该评论不存在，可能已被删除",
      avatarUrl: "",
      createTime: 0,
      images: [],
      likeAmount: 0.obs,
      nickname: "-",
      replyAmount: 0,
      userId: 0,
      gender: 0,
      type: 0,
      originId: 0,
      isEmpty: true,
    );
  }

  int id;
  int objId;
  String content;
  int createTime;
  Rx<int> likeAmount;
  int replyAmount;
  String nickname;
  String avatarUrl;
  List<String> images;
  int userId;
  List<CommentItem> parents = [];
  bool isEmpty;
  int gender;
  int type;
  int originId;
}
