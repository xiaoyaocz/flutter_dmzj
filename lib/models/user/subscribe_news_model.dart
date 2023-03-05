import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserSubscribeNewsModel {
  UserSubscribeNewsModel({
    required this.subId,
    required this.subTime,
    required this.title,
    required this.authorId,
    required this.rowPicUrl,
    required this.colPicUrl,
    required this.isForeign,
    required this.foreignUrl,
    required this.userPhoto,
    required this.userNickname,
    required this.pageUrl,
    required this.commentAmount,
    required this.moodAmount,
  });

  factory UserSubscribeNewsModel.fromJson(Map<String, dynamic> json) =>
      UserSubscribeNewsModel(
        subId: asT<int>(json['sub_id'])!,
        subTime: asT<int>(json['sub_time'])!,
        title: asT<String>(json['title'])!,
        authorId: asT<int>(json['author_id'])!,
        rowPicUrl: asT<String>(json['row_pic_url'])!,
        colPicUrl: asT<String>(json['col_pic_url'])!,
        isForeign: asT<int>(json['is_foreign'])!,
        foreignUrl: asT<String>(json['foreign_url'])!,
        userPhoto: asT<String>(json['user_photo'])!,
        userNickname: asT<String>(json['user_nickname'])!,
        pageUrl: asT<String>(json['page_url'])!,
        commentAmount: int.tryParse(json['comment_amount'].toString()) ?? 0,
        moodAmount: int.tryParse(json['mood_amount'].toString()) ?? 0,
      );

  int subId;
  int subTime;
  String title;
  int authorId;
  String rowPicUrl;
  String colPicUrl;
  int isForeign;
  String foreignUrl;
  String userPhoto;
  String userNickname;
  String pageUrl;
  int commentAmount;
  int moodAmount;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'sub_id': subId,
        'sub_time': subTime,
        'title': title,
        'author_id': authorId,
        'row_pic_url': rowPicUrl,
        'col_pic_url': colPicUrl,
        'is_foreign': isForeign,
        'foreign_url': foreignUrl,
        'user_photo': userPhoto,
        'user_nickname': userNickname,
        'page_url': pageUrl,
        'comment_amount': commentAmount,
        'mood_amount': moodAmount,
      };
}
