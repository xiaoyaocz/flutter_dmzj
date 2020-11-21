import 'dart:convert' show json;

class ComicChapterDetail {
  int _chapter_id;
  int get chapter_id => _chapter_id;
  int _comic_id;
  int get comic_id => _comic_id;
  String _title;
  String get title => _title;
  int _chapter_order;
  int get chapter_order => _chapter_order;
  int _direction;
  int get direction => _direction;
  List<String> _page_url;
  List<String> get page_url => _page_url;
  int _picnum;
  int get picnum => _picnum;
  int _comment_count;
  int get comment_count => _comment_count;

  ComicChapterDetail({
    int chapter_id,
    int comic_id,
    String title,
    int chapter_order,
    int direction,
    List<String> page_url,
    int picnum,
    int comment_count,
  })  : _chapter_id = chapter_id,
        _comic_id = comic_id,
        _title = title,
        _chapter_order = chapter_order,
        _direction = direction,
        _page_url = page_url,
        _picnum = picnum,
        _comment_count = comment_count;
  factory ComicChapterDetail.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> page_url = jsonRes['page_url'] is List ? [] : null;
    if (page_url != null) {
      for (var item in jsonRes['page_url']) {
        if (item != null) {
          page_url.add(item);
        }
      }
    }

    return ComicChapterDetail(
      chapter_id: jsonRes['chapter_id'],
      comic_id: jsonRes['comic_id'],
      title: jsonRes['title'],
      chapter_order: jsonRes['chapter_order'],
      direction: jsonRes['direction'],
      page_url: page_url,
      picnum: jsonRes['picnum'],
      comment_count: jsonRes['comment_count'],
    );
  }
  Map<String, dynamic> toJson() => {
        'chapter_id': _chapter_id,
        'comic_id': _comic_id,
        'title': _title,
        'chapter_order': _chapter_order,
        'direction': _direction,
        'page_url': _page_url,
        'picnum': _picnum,
        'comment_count': _comment_count,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
