import 'dart:convert' show json;

class ComicWebChapterDetail {
  int _id;
  int get id => _id;
  int _comic_id;
  int get comic_id => _comic_id;
  String _chapter_name;
  String get chapter_name => _chapter_name;
  int _chapter_order;
  int get chapter_order => _chapter_order;
  int _createtime;
  int get createtime => _createtime;
  String _folder;
  String get folder => _folder;
  List<String> _page_url;
  List<String> get page_url => _page_url;
  int _chapter_type;
  int get chapter_type => _chapter_type;
  int _chaptertype;
  int get chaptertype => _chaptertype;
  int _chapter_true_type;
  int get chapter_true_type => _chapter_true_type;
  double _chapter_num;
  double get chapter_num => _chapter_num;
  int _updatetime;
  int get updatetime => _updatetime;
  int _sum_pages;
  int get sum_pages => _sum_pages;
  int _sns_tag;
  int get sns_tag => _sns_tag;
  int _uid;
  int get uid => _uid;
  String _username;
  String get username => _username;
  String _translatorid;
  String get translatorid => _translatorid;
  String _translator;
  String get translator => _translator;
  String _link;
  String get link => _link;
  String _message;
  String get message => _message;
  String _download;
  String get download => _download;
  int _hidden;
  int get hidden => _hidden;
  int _direction;
  int get direction => _direction;
  int _filesize;
  int get filesize => _filesize;
  int _high_file_size;
  int get high_file_size => _high_file_size;
  int _picnum;
  int get picnum => _picnum;
  int _hit;
  int get hit => _hit;
  int _prev_chap_id;
  int get prev_chap_id => _prev_chap_id;
  int _comment_count;
  int get comment_count => _comment_count;

  ComicWebChapterDetail({
    int id,
    int comic_id,
    String chapter_name,
    int chapter_order,
    int createtime,
    String folder,
    List<String> page_url,
    int chapter_type,
    int chaptertype,
    int chapter_true_type,
    double chapter_num,
    int updatetime,
    int sum_pages,
    int sns_tag,
    int uid,
    String username,
    String translatorid,
    String translator,
    String link,
    String message,
    String download,
    int hidden,
    int direction,
    int filesize,
    int high_file_size,
    int picnum,
    int hit,
    int prev_chap_id,
    int comment_count,
  })  : _id = id,
        _comic_id = comic_id,
        _chapter_name = chapter_name,
        _chapter_order = chapter_order,
        _createtime = createtime,
        _folder = folder,
        _page_url = page_url,
        _chapter_type = chapter_type,
        _chaptertype = chaptertype,
        _chapter_true_type = chapter_true_type,
        _chapter_num = chapter_num,
        _updatetime = updatetime,
        _sum_pages = sum_pages,
        _sns_tag = sns_tag,
        _uid = uid,
        _username = username,
        _translatorid = translatorid,
        _translator = translator,
        _link = link,
        _message = message,
        _download = download,
        _hidden = hidden,
        _direction = direction,
        _filesize = filesize,
        _high_file_size = high_file_size,
        _picnum = picnum,
        _hit = hit,
        _prev_chap_id = prev_chap_id,
        _comment_count = comment_count;
  factory ComicWebChapterDetail.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> page_url = jsonRes['page_url'] is List ? [] : null;
    if (page_url != null) {
      for (var item in jsonRes['page_url']) {
        if (item != null) {
          page_url.add(item);
        }
      }
    }

    return ComicWebChapterDetail(
      id: jsonRes['id'],
      comic_id: jsonRes['comic_id'],
      chapter_name: jsonRes['chapter_name'],
      chapter_order: jsonRes['chapter_order'],
      createtime: jsonRes['createtime'],
      folder: jsonRes['folder'],
      page_url: page_url,
      chapter_type: jsonRes['chapter_type'],
      chaptertype: jsonRes['chaptertype'],
      chapter_true_type: jsonRes['chapter_true_type'],
      chapter_num: double.tryParse(jsonRes['chapter_num'].toString()) ?? 0,
      updatetime: jsonRes['updatetime'],
      sum_pages: jsonRes['sum_pages'],
      sns_tag: jsonRes['sns_tag'],
      uid: jsonRes['uid'],
      username: jsonRes['username'],
      translatorid: jsonRes['translatorid'],
      translator: jsonRes['translator'],
      link: jsonRes['link'],
      message: jsonRes['message'],
      download: jsonRes['download'],
      hidden: jsonRes['hidden'],
      direction: jsonRes['direction'],
      filesize: jsonRes['filesize'],
      high_file_size: jsonRes['high_file_size'],
      picnum: jsonRes['picnum'],
      hit: jsonRes['hit'],
      prev_chap_id: jsonRes['prev_chap_id'],
      comment_count: jsonRes['comment_count'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': _id,
        'comic_id': _comic_id,
        'chapter_name': _chapter_name,
        'chapter_order': _chapter_order,
        'createtime': _createtime,
        'folder': _folder,
        'page_url': _page_url,
        'chapter_type': _chapter_type,
        'chaptertype': _chaptertype,
        'chapter_true_type': _chapter_true_type,
        'chapter_num': _chapter_num,
        'updatetime': _updatetime,
        'sum_pages': _sum_pages,
        'sns_tag': _sns_tag,
        'uid': _uid,
        'username': _username,
        'translatorid': _translatorid,
        'translator': _translator,
        'link': _link,
        'message': _message,
        'download': _download,
        'hidden': _hidden,
        'direction': _direction,
        'filesize': _filesize,
        'high_file_size': _high_file_size,
        'picnum': _picnum,
        'hit': _hit,
        'prev_chap_id': _prev_chap_id,
        'comment_count': _comment_count,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
