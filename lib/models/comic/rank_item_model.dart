import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicRankListItemModel {
  ComicRankListItemModel({
    required this.comicId,
    required this.title,
    this.authors,
    this.status,
    this.cover,
    this.types,
    this.lastUpdatetime,
    this.lastUpdateChapterName,
    this.comicPy,
    this.num,
    this.tagId,
  });

  factory ComicRankListItemModel.fromJson(Map<String, dynamic> json) =>
      ComicRankListItemModel(
        comicId: asT<int>(json['comic_id'])!,
        title: asT<String>(json['title'])!,
        authors: asT<String?>(json['authors']),
        status: asT<String?>(json['status']),
        cover: asT<String?>(json['cover']),
        types: asT<String?>(json['types']),
        lastUpdatetime: asT<int?>(json['last_updatetime']),
        lastUpdateChapterName: asT<String?>(json['last_update_chapter_name']),
        comicPy: asT<String?>(json['comic_py']),
        num: asT<int?>(json['num']),
        tagId: asT<int?>(json['tag_id']),
      );

  int comicId;
  String title;
  String? authors;
  String? status;
  String? cover;
  String? types;
  int? lastUpdatetime;
  String? lastUpdateChapterName;
  String? comicPy;
  int? num;
  int? tagId;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comic_id': comicId,
        'title': title,
        'authors': authors,
        'status': status,
        'cover': cover,
        'types': types,
        'last_updatetime': lastUpdatetime,
        'last_update_chapter_name': lastUpdateChapterName,
        'comic_py': comicPy,
        'num': num,
        'tag_id': tagId,
      };
}
