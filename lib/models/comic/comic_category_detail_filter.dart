// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class ComicCategoryDetailFilter {
  String _title;
  String get title => _title;
  List<ComicCategoryDetailFilterItem> _items;
  List<ComicCategoryDetailFilterItem> get items => _items;

  ComicCategoryDetailFilterItem _item;
  ComicCategoryDetailFilterItem get item => _item;
  set item(value) {
    _item = value;
  }

  ComicCategoryDetailFilter({
    String title,
    List<ComicCategoryDetailFilterItem> items,
  })  : _title = title,
        _items = items;
  factory ComicCategoryDetailFilter.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<ComicCategoryDetailFilterItem> items =
        jsonRes['items'] is List ? [] : null;
    if (items != null) {
      for (var item in jsonRes['items']) {
        if (item != null) {
          items.add(ComicCategoryDetailFilterItem.fromJson(item));
        }
      }
    }

    return ComicCategoryDetailFilter(
      title: jsonRes['title'],
      items: items,
    );
  }
  Map<String, dynamic> toJson() => {
        'title': _title,
        'items': _items,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicCategoryDetailFilterItem {
  int _tag_id;
  int get tag_id => _tag_id;
  String _tag_name;
  String get tag_name => _tag_name;

  ComicCategoryDetailFilterItem({
    int tag_id,
    String tag_name,
  })  : _tag_id = tag_id,
        _tag_name = tag_name;
  factory ComicCategoryDetailFilterItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicCategoryDetailFilterItem(
          tag_id: jsonRes['tag_id'],
          tag_name: jsonRes['tag_name'],
        );
  Map<String, dynamic> toJson() => {
        'tag_id': _tag_id,
        'tag_name': _tag_name,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
