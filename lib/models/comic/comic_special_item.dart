import 'dart:convert' show json;

class ComicSpecialItem {
  int _id;
  int get id => _id;
  String _title;
  String get title => _title;
  String _short_title;
  String get short_title => _short_title;
  int _create_time;
  int get create_time => _create_time;
  String _small_cover;
  String get small_cover => _small_cover;
  int _page_type;
  int get page_type => _page_type;
  int _sort;
  int get sort => _sort;
  String _page_url;
  String get page_url => _page_url;

    ComicSpecialItem({
int id,
String title,
String short_title,
int create_time,
String small_cover,
int page_type,
int sort,
String page_url,
}):_id=id,_title=title,_short_title=short_title,_create_time=create_time,_small_cover=small_cover,_page_type=page_type,_sort=sort,_page_url=page_url;
  factory ComicSpecialItem.fromJson(jsonRes)=>jsonRes == null? null:ComicSpecialItem(    id : jsonRes['id'],
    title : jsonRes['title'],
    short_title : jsonRes['short_title'],
    create_time : jsonRes['create_time'],
    small_cover : jsonRes['small_cover'],
    page_type : jsonRes['page_type'],
    sort : jsonRes['sort'],
    page_url : jsonRes['page_url'],
);
  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': _title,
        'short_title': _short_title,
        'create_time': _create_time,
        'small_cover': _small_cover,
        'page_type': _page_type,
        'sort': _sort,
        'page_url': _page_url,
};

  @override
String  toString() {
    return json.encode(this);
  }
}

