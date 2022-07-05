// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class ComicRelated {
  List<ComicRelatedAuthorComics> _author_comics;
  List<ComicRelatedAuthorComics> get author_comics => _author_comics;
  List<ComicRelatedItem> _theme_comics;
  List<ComicRelatedItem> get theme_comics => _theme_comics;
  List<ComicRelatedItem> _novels;
  List<ComicRelatedItem> get novels => _novels;

  ComicRelated({
    List<ComicRelatedAuthorComics> author_comics,
    List<ComicRelatedItem> theme_comics,
    List<ComicRelatedItem> novels,
  })  : _author_comics = author_comics,
        _theme_comics = theme_comics,
        _novels = novels;
  factory ComicRelated.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<ComicRelatedAuthorComics> author_comics =
        jsonRes['author_comics'] is List ? [] : null;
    if (author_comics != null) {
      for (var item in jsonRes['author_comics']) {
        if (item != null) {
          author_comics.add(ComicRelatedAuthorComics.fromJson(item));
        }
      }
    }

    List<ComicRelatedItem> theme_comics =
        jsonRes['theme_comics'] is List ? [] : null;
    if (theme_comics != null) {
      for (var item in jsonRes['theme_comics']) {
        if (item != null) {
          theme_comics.add(ComicRelatedItem.fromJson(item));
        }
      }
    }

    List<ComicRelatedItem> novels = jsonRes['novels'] is List ? [] : null;
    if (novels != null) {
      for (var item in jsonRes['novels']) {
        if (item != null) {
          novels.add(ComicRelatedItem.fromJson(item));
        }
      }
    }

    return ComicRelated(
      author_comics: author_comics,
      theme_comics: theme_comics,
      novels: novels,
    );
  }
  Map<String, dynamic> toJson() => {
        'author_comics': _author_comics,
        'theme_comics': _theme_comics,
        'novels': _novels,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicRelatedAuthorComics {
  String _author_name;
  String get author_name => _author_name;
  int _author_id;
  int get author_id => _author_id;
  List<ComicRelatedItem> _data;
  List<ComicRelatedItem> get data => _data;

  ComicRelatedAuthorComics({
    String author_name,
    int author_id,
    List<ComicRelatedItem> data,
  })  : _author_name = author_name,
        _author_id = author_id,
        _data = data;
  factory ComicRelatedAuthorComics.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<ComicRelatedItem> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          data.add(ComicRelatedItem.fromJson(item));
        }
      }
    }

    return ComicRelatedAuthorComics(
      author_name: jsonRes['author_name'],
      author_id: jsonRes['author_id'],
      data: data,
    );
  }
  Map<String, dynamic> toJson() => {
        'author_name': _author_name,
        'author_id': _author_id,
        'data': _data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicRelatedItem {
  int _id;
  int get id => _id;
  String _name;
  String get name => _name;
  String _cover;
  String get cover => _cover;
  String _status;
  String get status => _status;

  ComicRelatedItem({
    int id,
    String name,
    String cover,
    String status,
  })  : _id = id,
        _name = name,
        _cover = cover,
        _status = status;
  factory ComicRelatedItem.fromJson(jsonRes) => jsonRes == null
      ? null
      : ComicRelatedItem(
          id: jsonRes['id'],
          name: jsonRes['name'],
          cover: jsonRes['cover'],
          status: jsonRes['status'],
        );
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'cover': _cover,
        'status': _status,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
