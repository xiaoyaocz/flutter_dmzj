import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NewsListItemModel {
  NewsListItemModel({
    required this.articleId,
    required this.title,
    this.createTime,
    this.intro,
    this.authorId,
    this.status,
    this.rowPicUrl,
    this.colPicUrl,
    this.pageUrl,
    this.authorUid,
    this.cover,
    this.nickname,
  });

  factory NewsListItemModel.fromJson(Map<String, dynamic> json) =>
      NewsListItemModel(
        articleId: asT<int>(json['article_id'])!,
        title: asT<String>(json['title'])!,
        createTime: asT<int?>(json['create_time']),
        intro: asT<String?>(json['intro']),
        authorId: asT<int?>(json['author_id']),
        status: asT<int?>(json['status']),
        rowPicUrl: asT<String?>(json['row_pic_url']),
        colPicUrl: asT<String?>(json['col_pic_url']),
        pageUrl: asT<String?>(json['page_url']),
        authorUid: asT<int?>(json['author_uid']),
        cover: asT<String?>(json['cover']),
        nickname: asT<String?>(json['nickname']),
      );

  int articleId;
  String title;
  int? createTime;
  String? intro;
  int? authorId;
  int? status;
  String? rowPicUrl;
  String? colPicUrl;
  String? pageUrl;
  int? authorUid;
  String? cover;
  String? nickname;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'article_id': articleId,
        'title': title,
        'create_time': createTime,
        'intro': intro,
        'author_id': authorId,
        'status': status,
        'row_pic_url': rowPicUrl,
        'col_pic_url': colPicUrl,
        'page_url': pageUrl,
        'author_uid': authorUid,
        'cover': cover,
        'nickname': nickname,
      };
}
