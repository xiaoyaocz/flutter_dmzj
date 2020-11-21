import 'dart:convert' show json;

class ComicNSSearchItem {
  int _id;
  int get id => _id;
  String _title;
  String get title => _title;
  String _desc;
  String get desc => _desc;
  String _author;
  String get author => _author;
  String _cover;
  String get cover => _cover;
  String _status;
  String get status => _status;
  String _web;
  String get web => _web;
  String _ios;
  String get ios => _ios;
  String _android;
  String get android => _android;
  String _uwp;
  String get uwp => _uwp;

  ComicNSSearchItem({
    int id,
    String title,
    String desc,
    String author,
    String cover,
    String status,
    String web,
    String ios,
    String android,
    String uwp,
  })  : _id = id,
        _title = title,
        _desc = desc,
        _author = author,
        _cover = cover,
        _status = status,
        _web = web,
        _ios = ios,
        _android = android,
        _uwp = uwp;
  factory ComicNSSearchItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicNSSearchItem(
          id: jsonRes['id'],
          title: jsonRes['title'],
          desc: jsonRes['desc'],
          author: jsonRes['author'],
          cover: jsonRes['cover'],
          status: jsonRes['status'],
          web: jsonRes['web'],
          ios: jsonRes['ios'],
          android: jsonRes['android'],
          uwp: jsonRes['uwp'],
        );
  Map<String, dynamic> toJson() => {
        'id': _id,
        'title': _title,
        'desc': _desc,
        'author': _author,
        'cover': _cover,
        'status': _status,
        'web': _web,
        'ios': _ios,
        'android': _android,
        'uwp': _uwp,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
