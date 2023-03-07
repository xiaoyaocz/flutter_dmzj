import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserNovelHistoryModel {
  UserNovelHistoryModel({
    required this.uid,
    required this.type,
    required this.lnovelId,
    this.volumeId,
    this.chapterId,
    required this.record,
    required this.viewingTime,
    required this.totalNum,
    required this.cover,
    required this.novelName,
    this.volumeName,
    this.chapterName,
  });

  factory UserNovelHistoryModel.fromJson(Map<String, dynamic> json) =>
      UserNovelHistoryModel(
        uid: asT<int>(json['uid'])!,
        type: asT<int>(json['type'])!,
        lnovelId: int.tryParse(json['lnovel_id'].toString()) ?? 0,
        volumeId: asT<int?>(json['volume_id']),
        chapterId: asT<int?>(json['chapter_id']),
        record: asT<int>(json['record'])!,
        viewingTime: asT<int>(json['viewing_time'])!,
        totalNum: asT<int>(json['total_num'])!,
        cover: asT<String>(json['cover'])!,
        novelName: asT<String>(json['novel_name'])!,
        volumeName: asT<String?>(json['volume_name']),
        chapterName: asT<String?>(json['chapter_name']),
      );

  int uid;
  int type;
  int lnovelId;
  int? volumeId;
  int? chapterId;
  int record;
  int viewingTime;
  int totalNum;
  String cover;
  String novelName;
  String? volumeName;
  String? chapterName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'type': type,
        'lnovel_id': lnovelId,
        'volume_id': volumeId,
        'chapter_id': chapterId,
        'record': record,
        'viewing_time': viewingTime,
        'total_num': totalNum,
        'cover': cover,
        'novel_name': novelName,
        'volume_name': volumeName,
        'chapter_name': chapterName,
      };
}
