import 'dart:convert' show json;

class NovelCategoryDetailItem {
  String _cover;
  String get cover => _cover;
  String _name;
  String get name => _name;
  String _authors;
  String get authors => _authors;
  int _id;
  int get id => _id;

  NovelCategoryDetailItem({
    String cover,
    String name,
    String authors,
    int id,
  })  : _cover = cover,
        _name = name,
        _authors = authors,
        _id = id;
  factory NovelCategoryDetailItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : NovelCategoryDetailItem(
          cover: jsonRes['cover'],
          name: jsonRes['name'],
          authors: jsonRes['authors'],
          id: jsonRes['id'],
        );
  Map<String, dynamic> toJson() => {
        'cover': _cover,
        'name': _name,
        'authors': _authors,
        'id': _id,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
