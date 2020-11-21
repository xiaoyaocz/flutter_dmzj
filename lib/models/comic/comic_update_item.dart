import 'dart:convert' show json;

class ComicUpdateItem {
  int _id;
  int get id => _id;
  String _title;
  String get title => _title;
  int _islong;
  int get islong => _islong;
  String _authors;
  String get authors => _authors;
  String _types;
  String get types => _types;
  String _cover;
  String get cover => _cover;
  String _status;
  String get status => _status;
  String _last_update_chapter_name;
  String get last_update_chapter_name => _last_update_chapter_name;
  int _last_update_chapter_id;
  int get last_update_chapter_id => _last_update_chapter_id;
  int _last_updatetime;
  int get last_updatetime => _last_updatetime;

  ComicUpdateItem({
    int id,
    String title,
    int islong,
    String authors,
    String types,
    String cover,
    String status,
    String last_update_chapter_name,
    int last_update_chapter_id,
    int last_updatetime,
  })  : _id = id,
        _title = title,
        _islong = islong,
        _authors = authors,
        _types = types,
        _cover = cover,
        _status = status,
        _last_update_chapter_name = last_update_chapter_name,
        _last_update_chapter_id = last_update_chapter_id,
        _last_updatetime = last_updatetime;
  factory ComicUpdateItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicUpdateItem(
          id: jsonRes['id'],
          title: jsonRes['title'],
          islong: jsonRes['islong'],
          authors: jsonRes['authors'],
          types: jsonRes['types'],
          cover: jsonRes['cover'],
          status: jsonRes['status'],
          last_update_chapter_name: jsonRes['last_update_chapter_name'],
          last_update_chapter_id: jsonRes['last_update_chapter_id'],
          last_updatetime: jsonRes['last_updatetime'],
        );
  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': _title,
        'islong': _islong,
        'authors': _authors,
        'types': _types,
        'cover': _cover,
        'status': _status,
        'last_update_chapter_name': _last_update_chapter_name,
        'last_update_chapter_id': _last_update_chapter_id,
        'last_updatetime': _last_updatetime,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
