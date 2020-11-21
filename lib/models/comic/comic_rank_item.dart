import 'dart:convert' show json;

class ComicRankItem {
  String _comic_id;
  String get comic_id => _comic_id;
  set comic_id(value) {
    _comic_id = value;
  }

  String _title;
  String get title => _title;
  set title(value) {
    _title = value;
  }

  String _authors;
  String get authors => _authors;
  set authors(value) {
    _authors = value;
  }

  String _status;
  String get status => _status;
  set status(value) {
    _status = value;
  }

  String _cover;
  String get cover => _cover;
  set cover(value) {
    _cover = value;
  }

  String _types;
  String get types => _types;
  set types(value) {
    _types = value;
  }

  String _last_updatetime;
  String get last_updatetime => _last_updatetime;
  set last_updatetime(value) {
    _last_updatetime = value;
  }

  String _last_update_chapter_name;
  String get last_update_chapter_name => _last_update_chapter_name;
  set last_update_chapter_name(value) {
    _last_update_chapter_name = value;
  }

  String _comic_py;
  String get comic_py => _comic_py;
  set comic_py(value) {
    _comic_py = value;
  }

  String _num;
  String get num => _num;
  set num(value) {
    _num = value;
  }

  String _tag_id;
  String get tag_id => _tag_id;
  set tag_id(value) {
    _tag_id = value;
  }

  ComicRankItem({
    String comic_id,
    String title,
    String authors,
    String status,
    String cover,
    String types,
    String last_updatetime,
    String last_update_chapter_name,
    String comic_py,
    String num,
    String tag_id,
  })  : _comic_id = comic_id,
        _title = title,
        _authors = authors,
        _status = status,
        _cover = cover,
        _types = types,
        _last_updatetime = last_updatetime,
        _last_update_chapter_name = last_update_chapter_name,
        _comic_py = comic_py,
        _num = num,
        _tag_id = tag_id;
  factory ComicRankItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicRankItem(
          comic_id: jsonRes['comic_id'],
          title: jsonRes['title'],
          authors: jsonRes['authors'],
          status: jsonRes['status'],
          cover: jsonRes['cover'],
          types: jsonRes['types'],
          last_updatetime: jsonRes['last_updatetime'],
          last_update_chapter_name: jsonRes['last_update_chapter_name'],
          comic_py: jsonRes['comic_py'],
          num: jsonRes['num'].toString(),
          tag_id: jsonRes['tag_id'],
        );
  Map<String, dynamic> toJson() => {
        'comic_id': _comic_id,
        'title': _title,
        'authors': _authors,
        'status': _status,
        'cover': _cover,
        'types': _types,
        'last_updatetime': _last_updatetime,
        'last_update_chapter_name': _last_update_chapter_name,
        'comic_py': _comic_py,
        'num': _num,
        'tag_id': _tag_id,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
