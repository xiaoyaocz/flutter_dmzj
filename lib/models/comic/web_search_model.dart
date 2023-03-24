import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicWebSearchModel {
  ComicWebSearchModel({
    required this.id,
    required this.comicName,
    required this.comicAuthor,
    required this.comicCover,
    required this.cover,
    required this.lastUpdateChapterName,
    required this.comicUrlRaw,
    required this.comicUrl,
    required this.status,
    required this.chapterUrlRaw,
    required this.chapterUrl,
  });

  factory ComicWebSearchModel.fromJson(Map<String, dynamic> json) =>
      ComicWebSearchModel(
        id: asT<int>(json['id'])!,
        comicName: asT<String>(json['comic_name'])!,
        comicAuthor: asT<String?>(json['comic_author']) ?? "",
        comicCover: asT<String?>(json['comic_cover']) ?? "",
        cover: asT<String?>(json['cover']) ?? "",
        lastUpdateChapterName:
            asT<String?>(json['last_update_chapter_name']) ?? "",
        comicUrlRaw: asT<String?>(json['comic_url_raw']) ?? "",
        comicUrl: asT<String?>(json['comic_url']) ?? "",
        status: asT<String?>(json['status']) ?? "",
        chapterUrlRaw: asT<String?>(json['chapter_url_raw']) ?? "",
        chapterUrl: asT<String?>(json['chapter_url']) ?? "",
      );

  int id;
  String comicName;
  String comicAuthor;
  String comicCover;
  String cover;
  String lastUpdateChapterName;
  String comicUrlRaw;
  String comicUrl;
  String status;
  String chapterUrlRaw;
  String chapterUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'comic_name': comicName,
        'comic_author': comicAuthor,
        'comic_cover': comicCover,
        'cover': cover,
        'last_update_chapter_name': lastUpdateChapterName,
        'comic_url_raw': comicUrlRaw,
        'comic_url': comicUrl,
        'status': status,
        'chapter_url_raw': chapterUrlRaw,
        'chapter_url': chapterUrl,
      };
}
