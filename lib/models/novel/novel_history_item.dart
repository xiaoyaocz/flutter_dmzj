// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class NovelHistoryItem {
  int uid;
  int type;
  String lnovel_id;
  int volume_id;
  int chapter_id;
  int record;
  int viewing_time;
  int total_num;
  String cover;
  String novel_name;
  String volume_name;
  String chapter_name;

  NovelHistoryItem({
    this.uid,
    this.type,
    this.lnovel_id,
    this.volume_id,
    this.chapter_id,
    this.record,
    this.viewing_time,
    this.total_num,
    this.cover,
    this.novel_name,
    this.volume_name,
    this.chapter_name,
  });

  factory NovelHistoryItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : NovelHistoryItem(
          uid: jsonRes['uid'],
          type: jsonRes['type'],
          lnovel_id: jsonRes['lnovel_id'],
          volume_id: jsonRes['volume_id'],
          chapter_id: jsonRes['chapter_id'],
          record: jsonRes['record'],
          viewing_time: jsonRes['viewing_time'],
          total_num: jsonRes['total_num'],
          cover: jsonRes['cover'],
          novel_name: jsonRes['novel_name'],
          volume_name: jsonRes['volume_name'],
          chapter_name: jsonRes['chapter_name'],
        );
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'type': type,
        'lnovel_id': lnovel_id,
        'volume_id': volume_id,
        'chapter_id': chapter_id,
        'record': record,
        'viewing_time': viewing_time,
        'total_num': total_num,
        'cover': cover,
        'novel_name': novel_name,
        'volume_name': volume_name,
        'chapter_name': chapter_name,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
