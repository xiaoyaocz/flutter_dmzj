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
  });

  int id;
  int objId;
  String content;
  int createTime;
  int likeAmount;
  int replyAmount;
  String nickname;
  String avatarUrl;
  List<String> images;
  int userId;
  List<CommentItem> children = [];
}
