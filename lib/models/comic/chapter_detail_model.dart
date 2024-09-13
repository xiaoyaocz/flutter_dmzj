import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicChapterDetailModel {
  ComicChapterDetailModel({
    required this.chapterId,
    required this.comicId,
    required this.title,
    required this.chapterOrder,
    required this.direction,
    required this.pageUrl,
    required this.picnum,
    required this.pageUrlHd,
  });

  factory ComicChapterDetailModel.fromJson(Map<String, dynamic> json) {
    final List<String>? pageUrl = json['page_url'] is List ? <String>[] : null;
    if (pageUrl != null) {
      for (final dynamic item in json['page_url']!) {
        if (item != null) {
          pageUrl.add(asT<String>(item)!);
        }
      }
    }

    final List<String>? pageUrlHd =
        json['page_url_hd'] is List ? <String>[] : null;
    if (pageUrlHd != null) {
      for (final dynamic item in json['page_url_hd']!) {
        if (item != null) {
          pageUrlHd.add(asT<String>(item)!);
        }
      }
    }
    return ComicChapterDetailModel(
      chapterId: asT<int>(json['chapter_id'])!,
      comicId: asT<int>(json['comic_id'])!,
      title: asT<String>(json['title'])!,
      chapterOrder: asT<int>(json['chapter_order'])!,
      direction: asT<int>(json['direction'])!,
      pageUrl: pageUrl!,
      picnum: asT<int>(json['picnum'])!,
      pageUrlHd: pageUrlHd!,
    );
  }

  int chapterId;
  int comicId;
  String title;
  int chapterOrder;
  int direction;
  List<String> pageUrl;
  int picnum;
  List<String> pageUrlHd;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chapter_id': chapterId,
        'comic_id': comicId,
        'title': title,
        'chapter_order': chapterOrder,
        'direction': direction,
        'page_url': pageUrl,
        'picnum': picnum,
        'page_url_hd': pageUrlHd,
      };
}
