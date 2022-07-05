// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class ComicCategoryDetailItem {
  int _id;
  int get id => _id;
  String _title;
  String get title => _title;
  String _authors;
  String get authors => _authors;
  String _status;
  String get status => _status;
  String _cover;
  String get cover => _cover;
  String _types;
  String get types => _types;
  int _last_updatetime;
  int get last_updatetime => _last_updatetime;
  int _num;
  int get num => _num;

  ComicCategoryDetailItem({
    int id,
    String title,
    String authors,
    String status,
    String cover,
    String types,
    int last_updatetime,
    int num,
  })  : _id = id,
        _title = title,
        _authors = authors,
        _status = status,
        _cover = cover,
        _types = types,
        _last_updatetime = last_updatetime,
        _num = num;
  factory ComicCategoryDetailItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicCategoryDetailItem(
          id: jsonRes['id'],
          title: jsonRes['title'],
          authors: jsonRes['authors'],
          status: jsonRes['status'],
          cover: jsonRes['cover'],
          types: jsonRes['types'],
          last_updatetime: jsonRes['last_updatetime'],
          num: jsonRes['num'],
        );
  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': _title,
        'authors': _authors,
        'status': _status,
        'cover': _cover,
        'types': _types,
        'last_updatetime': _last_updatetime,
        'num': _num,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
