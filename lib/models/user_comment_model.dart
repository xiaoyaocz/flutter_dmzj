import 'dart:convert' show json;

class UserCommentItem {
  int _comment_id;
  int get comment_id => _comment_id;
  String _content;
  String get content => _content;
  int _reply_amount;
  int get reply_amount => _reply_amount;
  set reply_amount(value) {
    _reply_amount = value;
  }

  int _like_amount;
  int get like_amount => _like_amount;
  set like_amount(value) {
    _like_amount = value;
  }

  int _origin_comment_id;
  int get origin_comment_id => _origin_comment_id;
  int _obj_id;
  int get obj_id => _obj_id;
  int _create_time;
  int get create_time => _create_time;
  int _to_comment_id;
  int get to_comment_id => _to_comment_id;
  String _obj_cover;
  String get obj_cover => _obj_cover;
  String _obj_name;
  String get obj_name => _obj_name;
  String _page_url;
  String get page_url => _page_url;
  UserMasterComment _masterComment;
  UserMasterComment get masterComment => _masterComment;

  UserCommentItem({
    int comment_id,
    String content,
    int reply_amount,
    int like_amount,
    int origin_comment_id,
    int obj_id,
    int create_time,
    int to_comment_id,
    String obj_cover,
    String obj_name,
    String page_url,
    UserMasterComment masterComment,
  })  : _comment_id = comment_id,
        _content = content,
        _reply_amount = reply_amount,
        _like_amount = like_amount,
        _origin_comment_id = origin_comment_id,
        _obj_id = obj_id,
        _create_time = create_time,
        _to_comment_id = to_comment_id,
        _obj_cover = obj_cover,
        _obj_name = obj_name,
        _page_url = page_url,
        _masterComment = masterComment;
  factory UserCommentItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : UserCommentItem(
          comment_id: jsonRes['comment_id'],
          content: jsonRes['content'],
          reply_amount: jsonRes['reply_amount'],
          like_amount: jsonRes['like_amount'],
          origin_comment_id: jsonRes['origin_comment_id'],
          obj_id: jsonRes['obj_id'],
          create_time: jsonRes['create_time'],
          to_comment_id: jsonRes['to_comment_id'],
          obj_cover: jsonRes['obj_cover'],
          obj_name: jsonRes['obj_name'],
          page_url: jsonRes['page_url'],
          masterComment: UserMasterComment.fromJson(jsonRes['masterComment']),
        );
  Map<String, dynamic> toJson() => {
        'comment_id': _comment_id,
        'content': _content,
        'reply_amount': _reply_amount,
        'like_amount': _like_amount,
        'origin_comment_id': _origin_comment_id,
        'obj_id': _obj_id,
        'create_time': _create_time,
        'to_comment_id': _to_comment_id,
        'obj_cover': _obj_cover,
        'obj_name': _obj_name,
        'page_url': _page_url,
        'masterComment': _masterComment,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class UserMasterComment {
  int _id;
  int get id => _id;
  String _content;
  String get content => _content;
  int _sender_uid;
  int get sender_uid => _sender_uid;
  int _like_amount;
  int get like_amount => _like_amount;
  set like_amount(value) {
    _like_amount = value;
  }

  int _create_time;
  int get create_time => _create_time;
  int _reply_amount;
  int get reply_amount => _reply_amount;
  set reply_amount(value) {
    _reply_amount = value;
  }

  String _nickname;
  String get nickname => _nickname;

  UserMasterComment({
    int id,
    String content,
    int sender_uid,
    int like_amount,
    int create_time,
    int reply_amount,
    String nickname,
  })  : _id = id,
        _content = content,
        _sender_uid = sender_uid,
        _like_amount = like_amount,
        _create_time = create_time,
        _reply_amount = reply_amount,
        _nickname = nickname;
  factory UserMasterComment.fromJson(jsonRes) => jsonRes == null
      ? null
      : UserMasterComment(
          id: jsonRes['id'],
          content: jsonRes['content'],
          sender_uid: jsonRes['sender_uid'],
          like_amount: jsonRes['like_amount'],
          create_time: jsonRes['create_time'],
          reply_amount: jsonRes['reply_amount'],
          nickname: jsonRes['nickname'],
        );
  Map<String, dynamic> toJson() => {
        'id': _id,
        'content': _content,
        'sender_uid': _sender_uid,
        'like_amount': _like_amount,
        'create_time': _create_time,
        'reply_amount': _reply_amount,
        'nickname': _nickname,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
