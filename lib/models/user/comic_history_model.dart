import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserComicHistoryModel {
  UserComicHistoryModel({
    required this.uid,
    required this.type,
    required this.comicId,
    this.chapterId,
    required this.record,
    required this.viewingTime,
    required this.comicName,
    required this.cover,
    this.chapterName,
  });

  factory UserComicHistoryModel.fromJson(Map<String, dynamic> json) =>
      UserComicHistoryModel(
        uid: asT<int>(json['uid'])!,
        type: asT<int>(json['type'])!,
        comicId: asT<int>(json['comic_id'])!,
        chapterId: asT<int?>(json['chapter_id']),
        record: asT<int?>(json['record']),
        viewingTime: asT<int>(json['viewing_time'])!,
        comicName: asT<String>(json['comic_name'])!,
        cover: asT<String>(json['cover'])!,
        chapterName: asT<String?>(json['chapter_name']),
      );

  int uid;
  int type;
  int comicId;
  int? chapterId;
  int? record;
  int viewingTime;
  String comicName;
  String cover;
  String? chapterName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'type': type,
        'comic_id': comicId,
        'chapter_id': chapterId,
        'record': record,
        'viewing_time': viewingTime,
        'comic_name': comicName,
        'cover': cover,
        'chapter_name': chapterName,
      };
}
