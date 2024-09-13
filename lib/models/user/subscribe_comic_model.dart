import 'dart:convert';

import 'package:get/get.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserSubscribeComicItemModel {
  UserSubscribeComicItemModel({
    required this.id,
    required this.title,
    required this.cover,
    required this.subReaded,
    required this.lastUpdateChapterId,
    required this.lastUpdateChapterName,
    required this.comicPy,
    required this.status,
    required this.readingRecord,
    required this.hasNew,
  });

  factory UserSubscribeComicItemModel.fromJson(Map<String, dynamic> json) =>
      UserSubscribeComicItemModel(
        id: asT<int>(json['id'])!,
        title: asT<String>(json['title'])!,
        cover: asT<String>(json['cover'])!,
        subReaded: asT<int>(json['sub_readed'])!,
        lastUpdateChapterId: asT<int>(json['last_update_chapter_id'])!,
        lastUpdateChapterName: asT<String>(json['last_update_chapter_name'])!,
        comicPy: asT<String>(json['comic_py'])!,
        status: asT<String>(json['status'])!,
        readingRecord: ReadingRecord.fromJson(
            asT<Map<String, dynamic>>(json['readingRecord'])!),
        hasNew: (asT<int>(json['sub_readed']) == 0).obs,
      );

  int id;
  String title;
  String cover;
  int subReaded;
  int lastUpdateChapterId;
  String lastUpdateChapterName;
  String comicPy;
  String status;
  ReadingRecord readingRecord;

  var isChecked = false.obs;
  var hasNew = false.obs;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'cover': cover,
        'sub_readed': subReaded,
        'last_update_chapter_id': lastUpdateChapterId,
        'last_update_chapter_name': lastUpdateChapterName,
        'comic_py': comicPy,
        'status': status,
        'readingRecord': readingRecord,
      };
}

class ReadingRecord {
  ReadingRecord({
    required this.typeName,
    required this.uid,
    required this.source,
    required this.bizId,
    required this.chapterId,
    required this.viewingTime,
    required this.record,
    required this.volumeId,
    required this.totalNum,
    required this.chapterName,
    required this.volumeName,
  });

  factory ReadingRecord.fromJson(Map<String, dynamic> json) => ReadingRecord(
        typeName: asT<String>(json['type_name'])!,
        uid: asT<int>(json['uid'])!,
        source: asT<int>(json['source'])!,
        bizId: asT<int>(json['biz_id'])!,
        chapterId: asT<int>(json['chapter_id'])!,
        viewingTime: asT<int>(json['viewing_time'])!,
        record: asT<int>(json['record'])!,
        volumeId: asT<int>(json['volume_id'])!,
        totalNum: asT<int>(json['total_num'])!,
        chapterName: asT<String>(json['chapter_name'])!,
        volumeName: asT<String>(json['volume_name'])!,
      );

  String typeName;
  int uid;
  int source;
  int bizId;
  int chapterId;
  int viewingTime;
  int record;
  int volumeId;
  int totalNum;
  String chapterName;
  String volumeName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type_name': typeName,
        'uid': uid,
        'source': source,
        'biz_id': bizId,
        'chapter_id': chapterId,
        'viewing_time': viewingTime,
        'record': record,
        'volume_id': volumeId,
        'total_num': totalNum,
        'chapter_name': chapterName,
        'volume_name': volumeName,
      };
}
