import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserNovelHistoryModel {
  UserNovelHistoryModel({
    this.uid,
    this.type,
    required this.lnovelId,
    this.volumeId,
    this.chapterId,
    this.record,
    this.viewingTime,
    this.totalNum,
    required this.cover,
    required this.novelName,
    this.volumeName,
    this.chapterName,
  });

  factory UserNovelHistoryModel.fromJson(Map<String, dynamic> json) =>
      // 接口不知道那些可能为空，所以全部变为可空
      UserNovelHistoryModel(
        uid: asT<int?>(json['uid']) ?? 0,
        type: asT<int?>(json['type']) ?? 0,
        lnovelId: int.tryParse(json['lnovel_id'].toString()) ?? 0,
        volumeId: asT<int?>(json['volume_id']) ?? 0,
        chapterId: asT<int?>(json['chapter_id']) ?? 0,
        record: asT<int?>(json['record']) ?? 0,
        viewingTime: asT<int?>(json['viewing_time']) ?? 0,
        totalNum: asT<int?>(json['total_num']) ?? 0,
        cover: asT<String?>(json['cover']) ?? "",
        novelName: asT<String?>(json['novel_name']) ?? "未知小说",
        volumeName: asT<String?>(json['volume_name']) ?? "-",
        chapterName: asT<String?>(json['chapter_name']) ?? "-",
      );

  int? uid;
  int? type;
  int lnovelId;
  int? volumeId;
  int? chapterId;
  int? record;
  int? viewingTime;
  int? totalNum;
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
