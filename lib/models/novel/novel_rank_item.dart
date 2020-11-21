import 'dart:convert' show json;

class NovelRankItem {
  int _id;
  int get id => _id;
  int _last_update_time;
  int get last_update_time => _last_update_time;
  String _name;
  String get name => _name;
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

  String _cover;
  String get cover => _cover;
  String _authors;
  String get authors => _authors;
  String _last_update_chapter_name;
  String get last_update_chapter_name => _last_update_chapter_name;
  int _top;
  int get top => _top;
  int _subscribe_amount;
  int get subscribe_amount => _subscribe_amount;

  NovelRankItem({
    int id,
    int last_update_time,
    String name,
    List<String> types,
    String cover,
    String authors,
    String last_update_chapter_name,
    int top,
    int subscribe_amount,
  })  : _id = id,
        _last_update_time = last_update_time,
        _name = name,
        _types = types,
        _cover = cover,
        _authors = authors,
        _last_update_chapter_name = last_update_chapter_name,
        _top = top,
        _subscribe_amount = subscribe_amount;
  factory NovelRankItem.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> types = jsonRes['types'] is List ? [] : null;
    if (types != null) {
      for (var item in jsonRes['types']) {
        if (item != null) {
          types.add(item);
        }
      }
    }

    return NovelRankItem(
      id: jsonRes['id'],
      last_update_time: jsonRes['last_update_time'],
      name: jsonRes['name'],
      types: types,
      cover: jsonRes['cover'],
      authors: jsonRes['authors'],
      last_update_chapter_name: jsonRes['last_update_chapter_name'],
      top: jsonRes['top'],
      subscribe_amount: jsonRes['subscribe_amount'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': _id,
        'last_update_time': _last_update_time,
        'name': _name,
        'types': _types,
        'cover': _cover,
        'authors': _authors,
        'last_update_chapter_name': _last_update_chapter_name,
        'top': _top,
        'subscribe_amount': _subscribe_amount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
