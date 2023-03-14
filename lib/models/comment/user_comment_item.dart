import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserCommentItem {
  UserCommentItem({
    required this.commentId,
    required this.content,
    required this.replyAmount,
    required this.likeAmount,
    this.originCommentId,
    required this.objId,
    required this.createTime,
    this.toCommentId,
    required this.objCover,
    required this.objName,
    this.pageUrl,
    this.mastercomment,
  });

  factory UserCommentItem.fromJson(Map<String, dynamic> json) =>
      UserCommentItem(
        commentId: asT<int>(json['comment_id'])!,
        content: asT<String>(json['content'])!,
        replyAmount: asT<int>(json['reply_amount'])!,
        likeAmount: asT<int>(json['like_amount'])!,
        originCommentId: asT<int?>(json['origin_comment_id']),
        objId: asT<int>(json['obj_id'])!,
        createTime: asT<int>(json['create_time'])!,
        toCommentId: asT<int?>(json['to_comment_id']),
        objCover: asT<String>(json['obj_cover'])!,
        objName: asT<String>(json['obj_name'])!,
        pageUrl: asT<String?>(json['page_url']),
        mastercomment: json['masterComment'] == null
            ? null
            : UserMasterComment.fromJson(
                asT<Map<String, dynamic>>(json['masterComment'])!),
      );

  int commentId;
  String content;
  int replyAmount;
  int likeAmount;
  int? originCommentId;
  int objId;
  int createTime;
  int? toCommentId;
  String objCover;
  String objName;
  String? pageUrl;
  UserMasterComment? mastercomment;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comment_id': commentId,
        'content': content,
        'reply_amount': replyAmount,
        'like_amount': likeAmount,
        'origin_comment_id': originCommentId,
        'obj_id': objId,
        'create_time': createTime,
        'to_comment_id': toCommentId,
        'obj_cover': objCover,
        'obj_name': objName,
        'page_url': pageUrl,
        'masterComment': mastercomment,
      };
}

class UserMasterComment {
  UserMasterComment({
    required this.id,
    required this.content,
    this.senderUid,
    this.likeAmount,
    required this.createTime,
    this.replyAmount,
    required this.nickname,
  });

  factory UserMasterComment.fromJson(Map<String, dynamic> json) =>
      UserMasterComment(
        id: asT<int>(json['id'])!,
        content: asT<String>(json['content'])!,
        senderUid: asT<int?>(json['sender_uid']),
        likeAmount: asT<int?>(json['like_amount']),
        createTime: asT<int>(json['create_time'])!,
        replyAmount: asT<int?>(json['reply_amount']),
        nickname: asT<String>(json['nickname'])!,
      );

  int id;
  String content;
  int? senderUid;
  int? likeAmount;
  int createTime;
  int? replyAmount;
  String nickname;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'content': content,
        'sender_uid': senderUid,
        'like_amount': likeAmount,
        'create_time': createTime,
        'reply_amount': replyAmount,
        'nickname': nickname,
      };
}
