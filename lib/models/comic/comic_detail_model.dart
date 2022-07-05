// ignore_for_file: non_constant_identifier_names, unnecessary_getters_setters

import 'dart:convert' show json;

class ComicDetail {
  int _id;
  int get id => _id;
  int _islong;
  int get islong => _islong;
  int _direction;
  int get direction => _direction;
  String _title;
  String get title => _title;
  int _is_dmzj;
  int get is_dmzj => _is_dmzj;
  String _cover;
  String get cover => _cover;
  String _description;
  String get description => _description;
  int _last_updatetime;
  int get last_updatetime => _last_updatetime;
  String _last_update_chapter_name;
  String get last_update_chapter_name => _last_update_chapter_name;
  int _copyright;
  int get copyright => _copyright;
  String _first_letter;
  String get first_letter => _first_letter;
  String _comic_py;
  String get comic_py => _comic_py;
  int _hidden;
  int get hidden => _hidden;
  int _hot_num;
  int get hot_num => _hot_num;
  int _hit_num;
  int get hit_num => _hit_num;
  Object _uid;
  Object get uid => _uid;
  int _is_lock;
  int get is_lock => _is_lock;
  int _last_update_chapter_id;
  int get last_update_chapter_id => _last_update_chapter_id;
  List<ComicDetailTagItem> _types;
  List<ComicDetailTagItem> get types => _types;
  List<ComicDetailTagItem> _status;
  List<ComicDetailTagItem> get status => _status;
  List<ComicDetailTagItem> _authors;
  List<ComicDetailTagItem> get authors => _authors;
  int _subscribe_num;
  int get subscribe_num => _subscribe_num;
  List<ComicDetailChapter> _chapters;
  List<ComicDetailChapter> get chapters => _chapters;
  String _isHideChapter;
  String get isHideChapter => _isHideChapter;
  String _is_dot;
  String get is_dot => _is_dot;

  String _author_notice;
  String get author_notice => _author_notice;

  String _comic_notice;
  String get comic_notice => _comic_notice;

  ComicDetail({
    int id,
    int islong,
    int direction,
    String title,
    int is_dmzj,
    String cover,
    String description,
    int last_updatetime,
    String last_update_chapter_name,
    int copyright,
    String first_letter,
    String comic_py,
    int hidden,
    int hot_num,
    int hit_num,
    Object uid,
    int is_lock,
    int last_update_chapter_id,
    List<ComicDetailTagItem> types,
    List<ComicDetailTagItem> status,
    List<ComicDetailTagItem> authors,
    int subscribe_num,
    List<ComicDetailChapter> chapters,
    String isHideChapter,
    String is_dot,
    String comic_notice,
    String author_notice,
  })  : _id = id,
        _islong = islong,
        _direction = direction,
        _title = title,
        _is_dmzj = is_dmzj,
        _cover = cover,
        _description = description,
        _last_updatetime = last_updatetime,
        _last_update_chapter_name = last_update_chapter_name,
        _copyright = copyright,
        _first_letter = first_letter,
        _comic_py = comic_py,
        _hidden = hidden,
        _hot_num = hot_num,
        _hit_num = hit_num,
        _uid = uid,
        _is_lock = is_lock,
        _last_update_chapter_id = last_update_chapter_id,
        _types = types,
        _status = status,
        _authors = authors,
        _subscribe_num = subscribe_num,
        _chapters = chapters,
        _isHideChapter = isHideChapter,
        _comic_notice = comic_notice,
        _author_notice = author_notice,
        _is_dot = is_dot;
  factory ComicDetail.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<ComicDetailTagItem> types = jsonRes['types'] is List ? [] : null;
    if (types != null) {
      for (var item in jsonRes['types']) {
        if (item != null) {
          types.add(ComicDetailTagItem.fromJson(item));
        }
      }
    }

    List<ComicDetailTagItem> status = jsonRes['status'] is List ? [] : null;
    if (status != null) {
      for (var item in jsonRes['status']) {
        if (item != null) {
          status.add(ComicDetailTagItem.fromJson(item));
        }
      }
    }

    List<ComicDetailTagItem> authors = jsonRes['authors'] is List ? [] : null;
    if (authors != null) {
      for (var item in jsonRes['authors']) {
        if (item != null) {
          authors.add(ComicDetailTagItem.fromJson(item));
        }
      }
    }

    List<ComicDetailChapter> chapters = jsonRes['chapters'] is List ? [] : null;
    if (chapters != null) {
      for (var item in jsonRes['chapters']) {
        if (item != null) {
          chapters.add(ComicDetailChapter.fromJson(item));
        }
      }
    }

    return ComicDetail(
        id: jsonRes['id'],
        islong: jsonRes['islong'],
        direction: jsonRes['direction'],
        title: jsonRes['title'],
        is_dmzj: jsonRes['is_dmzj'],
        cover: jsonRes['cover'],
        description: jsonRes['description'],
        last_updatetime: jsonRes['last_updatetime'],
        last_update_chapter_name: jsonRes['last_update_chapter_name'],
        copyright: jsonRes['copyright'],
        first_letter: jsonRes['first_letter'],
        comic_py: jsonRes['comic_py'],
        hidden: jsonRes['hidden'],
        hot_num: jsonRes['hot_num'],
        hit_num: jsonRes['hit_num'],
        uid: jsonRes['uid'],
        is_lock: jsonRes['is_lock'],
        last_update_chapter_id: jsonRes['last_update_chapter_id'],
        types: types,
        status: status,
        authors: authors,
        subscribe_num: jsonRes['subscribe_num'],
        chapters: chapters,
        isHideChapter: jsonRes['isHideChapter'],
        is_dot: jsonRes['is_dot'],
        author_notice: jsonRes['author_notice'],
        comic_notice: jsonRes['comic_notice']);
  }
  Map<String, dynamic> toJson() => {
        'id': _id,
        'islong': _islong,
        'direction': _direction,
        'title': _title,
        'is_dmzj': _is_dmzj,
        'cover': _cover,
        'description': _description,
        'last_updatetime': _last_updatetime,
        'last_update_chapter_name': _last_update_chapter_name,
        'copyright': _copyright,
        'first_letter': _first_letter,
        'comic_py': _comic_py,
        'hidden': _hidden,
        'hot_num': _hot_num,
        'hit_num': _hit_num,
        'uid': _uid,
        'is_lock': _is_lock,
        'last_update_chapter_id': _last_update_chapter_id,
        'types': _types,
        'status': _status,
        'authors': _authors,
        'subscribe_num': _subscribe_num,
        'chapters': _chapters,
        'isHideChapter': _isHideChapter,
        'is_dot': _is_dot
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicDetailTagItem {
  int _tag_id;
  int get tag_id => _tag_id;
  String _tag_name;
  String get tag_name => _tag_name;

  ComicDetailTagItem({
    int tag_id,
    String tag_name,
  })  : _tag_id = tag_id,
        _tag_name = tag_name;
  factory ComicDetailTagItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicDetailTagItem(
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

class ComicDetailChapter {
  String _title;
  String get title => _title;
  List<ComicDetailChapterItem> _data;
  List<ComicDetailChapterItem> get data => _data;

  bool _desc = true;
  bool get desc => _desc;
  set desc(bool value) {
    _desc = value;
  }

  int _showNum = 14;
  int get showNum => _showNum;
  set showNum(int value) {
    _showNum = value;
  }

  ComicDetailChapter({
    String title,
    List<ComicDetailChapterItem> data,
  })  : _title = title,
        _data = data;
  factory ComicDetailChapter.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<ComicDetailChapterItem> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          data.add(ComicDetailChapterItem.fromJson(item));
        }
      }
    }

    return ComicDetailChapter(
      title: jsonRes['title'],
      data: data,
    );
  }
  Map<String, dynamic> toJson() => {
        'title': _title,
        'data': _data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicDetailChapterItem {
  int _chapter_id;
  int get chapter_id => _chapter_id;
  String _chapter_title;
  String get chapter_title => _chapter_title;
  int _updatetime;
  int get updatetime => _updatetime;
  int _filesize;
  int get filesize => _filesize;
  int _chapter_order;
  int get chapter_order => _chapter_order;

  String volume_name;

  bool _selected = false;
  bool get selected => _selected;
  set selected(e) {
    _selected = e;
  }

  bool _downloaded = false;
  bool get downloaded => _downloaded;
  set downloaded(e) {
    _downloaded = e;
  }

  ComicDetailChapterItem({
    int chapter_id,
    String chapter_title,
    int updatetime,
    int filesize,
    int chapter_order,
  })  : _chapter_id = chapter_id,
        _chapter_title = chapter_title,
        _updatetime = updatetime,
        _filesize = filesize,
        _chapter_order = chapter_order;
  factory ComicDetailChapterItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicDetailChapterItem(
          chapter_id: jsonRes['chapter_id'],
          chapter_title: jsonRes['chapter_title'],
          updatetime: jsonRes['updatetime'],
          filesize: jsonRes['filesize'],
          chapter_order: jsonRes['chapter_order'],
        );
  Map<String, dynamic> toJson() => {
        'chapter_id': _chapter_id,
        'chapter_title': _chapter_title,
        'updatetime': _updatetime,
        'filesize': _filesize,
        'chapter_order': _chapter_order,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
