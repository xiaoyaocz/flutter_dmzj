import 'dart:convert' show json;

class ComicHistoryItem {
  int uid;
  int type;
  int comic_id;
  int chapter_id;
  int record;
  int viewing_time;
  String comic_name;
  String cover;
  String chapter_name = "";
  int progress;

  ComicHistoryItem({
    int uid,
    int type,
    int comic_id,
    int chapter_id,
    int record,
    int viewing_time,
    String comic_name,
    String cover,
    String chapter_name,
    int progress,
  })  : uid = uid,
        type = type,
        comic_id = comic_id,
        chapter_id = chapter_id ?? 0,
        record = record,
        viewing_time = viewing_time ?? DateTime.now(),
        comic_name = comic_name,
        cover = cover,
        chapter_name = chapter_name,
        progress = progress;
  factory ComicHistoryItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicHistoryItem(
          uid: jsonRes['uid'],
          type: jsonRes['type'],
          comic_id: jsonRes['comic_id'],
          chapter_id: jsonRes['chapter_id'],
          record: jsonRes['record'],
          viewing_time: jsonRes['viewing_time'],
          comic_name: jsonRes['comic_name'],
          cover: jsonRes['cover'],
          chapter_name: jsonRes['chapter_name'],
          progress: jsonRes['progress'],
        );
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'type': type,
        'comic_id': comic_id,
        'chapter_id': chapter_id,
        'record': record,
        'viewing_time': viewing_time,
        'comic_name': comic_name,
        'cover': cover,
        'chapter_name': chapter_name,
        'progress': progress,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
