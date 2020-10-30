import 'dart:convert' show json;

class CommentItem {
  int _id;
  int get id => _id;
  int _is_passed;
  int get is_passed => _is_passed;
  int _top_status;
  int get top_status => _top_status;
  int _is_goods;
  int get is_goods => _is_goods;
  String _upload_images;
  String get upload_images => _upload_images;
  int _obj_id;
  int get obj_id => _obj_id;
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
  int _to_uid;
  int get to_uid => _to_uid;
  int _to_comment_id;
  int get to_comment_id => _to_comment_id;
  int _origin_comment_id;
  int get origin_comment_id => _origin_comment_id;
  int _reply_amount;
  int get reply_amount => _reply_amount;
  set reply_amount(value) {
    _reply_amount = value;
  }

  int _hot_comment_amount;
  int get hot_comment_amount => _hot_comment_amount;
  String _cover;
  String get cover => _cover;
  String _nickname;
  String get nickname => _nickname;
  String _avatar_url;
  String get avatar_url => _avatar_url;
  int _sex;
  int get sex => _sex;
  List<MasterCommentItem> _masterComment;
  List<MasterCommentItem> get masterComment => _masterComment;
  int _masterCommentNum;
  int get masterCommentNum => _masterCommentNum;

  bool _expand = false;
  bool get expand => _expand;
  set expand(value) {
    _expand = value;
  }

  CommentItem({
    int id,
    int is_passed,
    int top_status,
    int is_goods,
    String upload_images,
    int obj_id,
    String content,
    int sender_uid,
    int like_amount,
    int create_time,
    int to_uid,
    int to_comment_id,
    int origin_comment_id,
    int reply_amount,
    int hot_comment_amount,
    String cover,
    String nickname,
    String avatar_url,
    int sex,
    List<MasterCommentItem> masterComment,
    int masterCommentNum,
  })  : _id = id,
        _is_passed = is_passed,
        _top_status = top_status,
        _is_goods = is_goods,
        _upload_images = upload_images,
        _obj_id = obj_id,
        _content = content,
        _sender_uid = sender_uid,
        _like_amount = like_amount,
        _create_time = create_time,
        _to_uid = to_uid,
        _to_comment_id = to_comment_id,
        _origin_comment_id = origin_comment_id,
        _reply_amount = reply_amount,
        _hot_comment_amount = hot_comment_amount,
        _cover = cover,
        _nickname = nickname,
        _avatar_url = avatar_url,
        _sex = sex,
        _masterComment = masterComment,
        _masterCommentNum = masterCommentNum;
  factory CommentItem.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<MasterCommentItem> masterComment =
        jsonRes['masterComment'] is List ? [] : null;
    if (masterComment != null) {
      for (var item in jsonRes['masterComment']) {
        if (item != null) {
          masterComment.add(MasterCommentItem.fromJson(item));
        }
      }
    }

    return CommentItem(
      id: jsonRes['id'],
      is_passed: jsonRes['is_passed'],
      top_status: jsonRes['top_status'],
      is_goods: jsonRes['is_goods'],
      upload_images: jsonRes['upload_images'],
      obj_id: jsonRes['obj_id'],
      content: jsonRes['content'],
      sender_uid: jsonRes['sender_uid'],
      like_amount: jsonRes['like_amount'],
      create_time: jsonRes['create_time'],
      to_uid: jsonRes['to_uid'],
      to_comment_id: jsonRes['to_comment_id'],
      origin_comment_id: jsonRes['origin_comment_id'],
      reply_amount: jsonRes['reply_amount'],
      hot_comment_amount: jsonRes['hot_comment_amount'],
      cover: jsonRes['cover'],
      nickname: jsonRes['nickname'],
      avatar_url: jsonRes['avatar_url'],
      sex: jsonRes['sex'],
      masterComment: masterComment,
      masterCommentNum: jsonRes['masterCommentNum'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': _id,
        'is_passed': _is_passed,
        'top_status': _top_status,
        'is_goods': _is_goods,
        'upload_images': _upload_images,
        'obj_id': _obj_id,
        'content': _content,
        'sender_uid': _sender_uid,
        'like_amount': _like_amount,
        'create_time': _create_time,
        'to_uid': _to_uid,
        'to_comment_id': _to_comment_id,
        'origin_comment_id': _origin_comment_id,
        'reply_amount': _reply_amount,
        'hot_comment_amount': _hot_comment_amount,
        'cover': _cover,
        'nickname': _nickname,
        'avatar_url': _avatar_url,
        'sex': _sex,
        'masterComment': _masterComment,
        'masterCommentNum': _masterCommentNum,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class MasterCommentItem {
  int _id;
  int get id => _id;
  int _is_passed;
  int get is_passed => _is_passed;
  int _top_status;
  int get top_status => _top_status;
  int _is_goods;
  int get is_goods => _is_goods;
  String _upload_images;
  String get upload_images => _upload_images;
  int _obj_id;
  int get obj_id => _obj_id;
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
  int _to_uid;
  int get to_uid => _to_uid;
  int _to_comment_id;
  int get to_comment_id => _to_comment_id;
  int _origin_comment_id;
  int get origin_comment_id => _origin_comment_id;
  int _reply_amount;
  int get reply_amount => _reply_amount;
  set reply_amount(value) {
    _reply_amount = value;
  }

  String _cover;
  String get cover => _cover;
  String _nickname;
  String get nickname => _nickname;
  int _hot_comment_amount;
  int get hot_comment_amount => _hot_comment_amount;
  int _sex;
  int get sex => _sex;

  MasterCommentItem({
    int id,
    int is_passed,
    int top_status,
    int is_goods,
    String upload_images,
    int obj_id,
    String content,
    int sender_uid,
    int like_amount,
    int create_time,
    int to_uid,
    int to_comment_id,
    int origin_comment_id,
    int reply_amount,
    String cover,
    String nickname,
    int hot_comment_amount,
    int sex,
  })  : _id = id,
        _is_passed = is_passed,
        _top_status = top_status,
        _is_goods = is_goods,
        _upload_images = upload_images,
        _obj_id = obj_id,
        _content = content,
        _sender_uid = sender_uid,
        _like_amount = like_amount,
        _create_time = create_time,
        _to_uid = to_uid,
        _to_comment_id = to_comment_id,
        _origin_comment_id = origin_comment_id,
        _reply_amount = reply_amount,
        _cover = cover,
        _nickname = nickname,
        _hot_comment_amount = hot_comment_amount,
        _sex = sex;
  factory MasterCommentItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : MasterCommentItem(
          id: jsonRes['id'],
          is_passed: jsonRes['is_passed'],
          top_status: jsonRes['top_status'],
          is_goods: jsonRes['is_goods'],
          upload_images: jsonRes['upload_images'],
          obj_id: jsonRes['obj_id'],
          content: jsonRes['content'],
          sender_uid: jsonRes['sender_uid'],
          like_amount: jsonRes['like_amount'],
          create_time: jsonRes['create_time'],
          to_uid: jsonRes['to_uid'],
          to_comment_id: jsonRes['to_comment_id'],
          origin_comment_id: jsonRes['origin_comment_id'],
          reply_amount: jsonRes['reply_amount'],
          cover: jsonRes['cover'],
          nickname: jsonRes['nickname'],
          hot_comment_amount: jsonRes['hot_comment_amount'],
          sex: jsonRes['sex'],
        );
  Map<String, dynamic> toJson() => {
        'id': _id,
        'is_passed': _is_passed,
        'top_status': _top_status,
        'is_goods': _is_goods,
        'upload_images': _upload_images,
        'obj_id': _obj_id,
        'content': _content,
        'sender_uid': _sender_uid,
        'like_amount': _like_amount,
        'create_time': _create_time,
        'to_uid': _to_uid,
        'to_comment_id': _to_comment_id,
        'origin_comment_id': _origin_comment_id,
        'reply_amount': _reply_amount,
        'cover': _cover,
        'nickname': _nickname,
        'hot_comment_amount': _hot_comment_amount,
        'sex': _sex,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
