import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserComicHistoryModel {
  UserComicHistoryModel({
    this.uid,
    this.type,
    required this.comicId,
    this.chapterId,
    this.record,
    this.viewingTime,
    required this.comicName,
    required this.cover,
    this.chapterName,
  });

  factory UserComicHistoryModel.fromJson(Map<String, dynamic> json) =>
      // 接口不知道那些可能为空，所以全部变为可空
      UserComicHistoryModel(
        uid: asT<int?>(json['uid']) ?? 0,
        type: asT<int?>(json['type']) ?? 0,
        comicId: asT<int?>(json['comic_id']) ?? 0,
        chapterId: asT<int?>(json['chapter_id']) ?? 0,
        record: asT<int?>(json['record']) ?? 0,
        viewingTime: asT<int?>(json['viewing_time']) ?? 0,
        comicName: asT<String?>(json['comic_name']) ?? "未知漫画",
        cover: asT<String?>(json['cover']) ?? "",
        chapterName: asT<String?>(json['chapter_name']) ?? "-",
      );

  int? uid;
  int? type;
  int comicId;
  int? chapterId;
  int? record;
  int? viewingTime;
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
