import 'dart:convert' show json;

class ComicChapterViewPoint {
  int _id;
  int get id => _id;
  int _uid;
  int get uid => _uid;
  String _content;
  String get content => _content;
  int _num;
  int get num => _num;
  set num(value) {
    _num = value;
  }

  int _page;
  int get page => _page;

  ComicChapterViewPoint({
    int id,
    int uid,
    String content,
    int num,
    int page,
  })  : _id = id,
        _uid = uid,
        _content = content,
        _num = num,
        _page = page;
  factory ComicChapterViewPoint.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicChapterViewPoint(
          id: jsonRes['id'],
          uid: jsonRes['uid'],
          content: jsonRes['content'],
          num: jsonRes['num'],
          page: jsonRes['page'],
        );
  Map<String, dynamic> toJson() => {
        'id': _id,
        'uid': _uid,
        'content': _content,
        'num': _num,
        'page': _page,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
