// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class NovelUpdateItem {
  int _id;
  int get id => _id;
  String _status;
  String get status => _status;
  String _name;
  String get name => _name;
  String _authors;
  String get authors => _authors;
  String _cover;
  String get cover => _cover;
  List<String> _types;
  List<String> get types => _types;

  String get type {
    if (_types == null || _types.length == 0) {
      return "";
    }
    var str = "";
    for (var item in _types) {
      str += item + " ";
    }
    return str;
  }

  int _last_update_chapter_id;
  int get last_update_chapter_id => _last_update_chapter_id;
  int _last_update_volume_id;
  int get last_update_volume_id => _last_update_volume_id;
  String _last_update_volume_name;
  String get last_update_volume_name => _last_update_volume_name;
  String _last_update_chapter_name;
  String get last_update_chapter_name => _last_update_chapter_name;
  int _last_update_time;
  int get last_update_time => _last_update_time;

  NovelUpdateItem({
    int id,
    String status,
    String name,
    String authors,
    String cover,
    List<String> types,
    int last_update_chapter_id,
    int last_update_volume_id,
    String last_update_volume_name,
    String last_update_chapter_name,
    int last_update_time,
  })  : _id = id,
        _status = status,
        _name = name,
        _authors = authors,
        _cover = cover,
        _types = types,
        _last_update_chapter_id = last_update_chapter_id,
        _last_update_volume_id = last_update_volume_id,
        _last_update_volume_name = last_update_volume_name,
        _last_update_chapter_name = last_update_chapter_name,
        _last_update_time = last_update_time;
  factory NovelUpdateItem.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> types = jsonRes['types'] is List ? [] : null;
    if (types != null) {
      for (var item in jsonRes['types']) {
        if (item != null) {
          types.add(item);
        }
      }
    }

    return NovelUpdateItem(
      id: jsonRes['id'],
      status: jsonRes['status'],
      name: jsonRes['name'],
      authors: jsonRes['authors'],
      cover: jsonRes['cover'],
      types: types,
      last_update_chapter_id: jsonRes['last_update_chapter_id'],
      last_update_volume_id: jsonRes['last_update_volume_id'],
      last_update_volume_name: jsonRes['last_update_volume_name'],
      last_update_chapter_name: jsonRes['last_update_chapter_name'],
      last_update_time: jsonRes['last_update_time'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': _id,
        'status': _status,
        'name': _name,
        'authors': _authors,
        'cover': _cover,
        'types': _types,
        'last_update_chapter_id': _last_update_chapter_id,
        'last_update_volume_id': _last_update_volume_id,
        'last_update_volume_name': _last_update_volume_name,
        'last_update_chapter_name': _last_update_chapter_name,
        'last_update_time': _last_update_time,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
