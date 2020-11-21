import 'dart:convert' show json;

class NovelSearchResultItem {
  int _addtime;
  int get addtime => _addtime;
  String _authors;
  String get authors => _authors;
  int _copyright;
  int get copyright => _copyright;
  String _cover;
  String get cover => _cover;
  int _hot_hits;
  int get hot_hits => _hot_hits;
  String _last_name;
  String get last_name => _last_name;
  int _status;
  int get status => _status;
  String _title;
  String get title => _title;
  String _types;
  String get types => _types;
  int _id;
  int get id => _id;

  NovelSearchResultItem({
    int addtime,
    String authors,
    int copyright,
    String cover,
    int hot_hits,
    String last_name,
    int status,
    String title,
    String types,
    int id,
  })  : _addtime = addtime,
        _authors = authors,
        _copyright = copyright,
        _cover = cover,
        _hot_hits = hot_hits,
        _last_name = last_name,
        _status = status,
        _title = title,
        _types = types,
        _id = id;
  factory NovelSearchResultItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : NovelSearchResultItem(
          addtime: jsonRes['addtime'],
          authors: jsonRes['authors'],
          copyright: jsonRes['copyright'],
          cover: jsonRes['cover'],
          hot_hits: jsonRes['hot_hits'],
          last_name: jsonRes['last_name'],
          status: jsonRes['status'],
          title: jsonRes['title'],
          types: jsonRes['types'],
          id: jsonRes['id'],
        );
  Map<String, dynamic> toJson() => {
        'addtime': _addtime,
        'authors': _authors,
        'copyright': _copyright,
        'cover': _cover,
        'hot_hits': _hot_hits,
        'last_name': _last_name,
        'status': _status,
        'title': _title,
        'types': _types,
        'id': _id,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
