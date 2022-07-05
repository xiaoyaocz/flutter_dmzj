// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class NovelVolumeItem {
  int _volume_id;
  int get volume_id => _volume_id;
  int _id;
  int get id => _id;
  String _volume_name;
  String get volume_name => _volume_name;
  int _volume_order;
  int get volume_order => _volume_order;
  List<NovelVolumeChapterItem> _chapters;
  List<NovelVolumeChapterItem> get chapters => _chapters;

  NovelVolumeItem({
    int volume_id,
    int id,
    String volume_name,
    int volume_order,
    List<NovelVolumeChapterItem> chapters,
  })  : _volume_id = volume_id,
        _id = id,
        _volume_name = volume_name,
        _volume_order = volume_order,
        _chapters = chapters;
  factory NovelVolumeItem.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<NovelVolumeChapterItem> chapters =
        jsonRes['chapters'] is List ? [] : null;
    if (chapters != null) {
      for (var item in jsonRes['chapters']) {
        if (item != null) {
          chapters.add(NovelVolumeChapterItem.fromJson(item));
        }
      }
    }

    return NovelVolumeItem(
      volume_id: jsonRes['volume_id'],
      id: jsonRes['id'],
      volume_name: jsonRes['volume_name'],
      volume_order: jsonRes['volume_order'],
      chapters: chapters,
    );
  }
  Map<String, dynamic> toJson() => {
        'volume_id': _volume_id,
        'id': _id,
        'volume_name': _volume_name,
        'volume_order': _volume_order,
        'chapters': _chapters,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class NovelVolumeChapterItem {
  int _chapter_id;
  int get chapter_id => _chapter_id;
  String _chapter_name;
  String get chapter_name => _chapter_name;
  int _chapter_order;
  int get chapter_order => _chapter_order;

  int _volume_id;
  int get volume_id => _volume_id;
  set volume_id(e) {
    _volume_id = e;
  }

  String _volume_name;
  String get volume_name => _volume_name;
  set volume_name(e) {
    _volume_name = e;
  }

  NovelVolumeChapterItem({
    int chapter_id,
    String chapter_name,
    int chapter_order,
  })  : _chapter_id = chapter_id,
        _chapter_name = chapter_name,
        _chapter_order = chapter_order;
  factory NovelVolumeChapterItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : NovelVolumeChapterItem(
          chapter_id: jsonRes['chapter_id'],
          chapter_name: jsonRes['chapter_name'],
          chapter_order: jsonRes['chapter_order'],
        );
  Map<String, dynamic> toJson() => {
        'chapter_id': _chapter_id,
        'chapter_name': _chapter_name,
        'chapter_order': _chapter_order,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
