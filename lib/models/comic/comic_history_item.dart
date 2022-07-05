// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class ComicHistoryItem {
  int _uid;
  int get uid => _uid;
  int _type;
  int get type => _type;
  int _comic_id;
  int get comic_id => _comic_id;
  int _chapter_id;
  int get chapter_id => _chapter_id ?? 0;
  int _record;
  int get record => _record;
  int _viewing_time;
  int get viewing_time => _viewing_time ?? 946656001;
  String _comic_name;
  String get comic_name => _comic_name;
  String _cover;
  String get cover => _cover;
  String _chapter_name = "";
  String get chapter_name => _chapter_name ?? "";
  int _progress;
  int get progress => _progress;
  set progress(value) {
    _progress = value;
  }

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
  })  : _uid = uid,
        _type = type,
        _comic_id = comic_id,
        _chapter_id = chapter_id,
        _record = record,
        _viewing_time = viewing_time,
        _comic_name = comic_name,
        _cover = cover,
        _chapter_name = chapter_name,
        _progress = progress;
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
        'uid': _uid,
        'type': _type,
        'comic_id': _comic_id,
        'chapter_id': _chapter_id,
        'record': _record,
        'viewing_time': _viewing_time,
        'comic_name': _comic_name,
        'cover': _cover,
        'chapter_name': _chapter_name,
        'progress': _progress,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
