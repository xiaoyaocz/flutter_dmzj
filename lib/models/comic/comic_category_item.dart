import 'dart:convert' show json;

class ComicCategoryItem {
  int _tag_id;
  int get tag_id => _tag_id;
  String _title;
  String get title => _title;
  String _cover;
  String get cover => _cover;

    ComicCategoryItem({
int tag_id,
String title,
String cover,
}):_tag_id=tag_id,_title=title,_cover=cover;
  factory ComicCategoryItem.fromJson(jsonRes)=>jsonRes == null? null:ComicCategoryItem(    tag_id : jsonRes['tag_id'],
    title : jsonRes['title'],
    cover : jsonRes['cover'],
);
  Map<String, dynamic> toJson() => {
        'tag_id': _tag_id,
        'title': _title,
        'cover': _cover,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

