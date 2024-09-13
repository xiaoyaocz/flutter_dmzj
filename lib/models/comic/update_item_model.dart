import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicUpdateItemModel {
  ComicUpdateItemModel({
    required this.comicId,
    required this.title,
    this.islong,
    this.authors,
    this.types,
    this.cover,
    this.status,
    this.lastUpdateChapterName,
    this.lastUpdateChapterId,
    this.lastUpdatetime,
  });

  factory ComicUpdateItemModel.fromJson(Map<String, dynamic> json) =>
      ComicUpdateItemModel(
        comicId: asT<int>(json['comic_id'])!,
        title: asT<String>(json['title'])!,
        islong: asT<int?>(json['islong']),
        authors: asT<String?>(json['authors']),
        types: asT<String?>(json['types']),
        cover: asT<String?>(json['cover']),
        status: asT<String?>(json['status']),
        lastUpdateChapterName: asT<String?>(json['last_update_chapter_name']),
        lastUpdateChapterId: asT<int?>(json['last_update_chapter_id']),
        lastUpdatetime: asT<int?>(json['last_updatetime']),
      );

  int comicId;
  String title;
  int? islong;
  String? authors;
  String? types;
  String? cover;
  String? status;
  String? lastUpdateChapterName;
  int? lastUpdateChapterId;
  int? lastUpdatetime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'comic_id': comicId,
        'title': title,
        'islong': islong,
        'authors': authors,
        'types': types,
        'cover': cover,
        'status': status,
        'last_update_chapter_name': lastUpdateChapterName,
        'last_update_chapter_id': lastUpdateChapterId,
        'last_updatetime': lastUpdatetime,
      };
}
