import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicSpecialModel {
  ComicSpecialModel({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.createTime,
    required this.smallCover,
    required this.pageType,
    required this.sort,
    required this.pageUrl,
  });

  factory ComicSpecialModel.fromJson(Map<String, dynamic> json) =>
      ComicSpecialModel(
        id: asT<int>(json['id'])!,
        title: asT<String>(json['title'])!,
        shortTitle: asT<String>(json['short_title'])!,
        createTime: asT<int>(json['create_time'])!,
        smallCover: asT<String>(json['small_cover'])!,
        pageType: asT<int>(json['page_type'])!,
        sort: asT<int>(json['sort'])!,
        pageUrl: asT<String>(json['page_url'])!,
      );

  int id;
  String title;
  String shortTitle;
  int createTime;
  String smallCover;
  int pageType;
  int sort;
  String pageUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'short_title': shortTitle,
        'create_time': createTime,
        'small_cover': smallCover,
        'page_type': pageType,
        'sort': sort,
        'page_url': pageUrl,
      };
}
