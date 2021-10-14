import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicDetailV2Model {
  ComicDetailV2Model({
    bool oldApi,
    int comicId,
    String title,
    List<ComicDetailV2AuthorModel> authors,
    String cover,
    List<ComicDetailV2TagModel> tags,
    int clickNum,
    int collectionNum,
    String status,
    String lastUpdate,
    String description,
    List<ComicDetailV2VolumeModel> volume,
  })  : _oldApi = oldApi,
        _comicId = comicId,
        _title = title,
        _authors = authors,
        _cover = cover,
        _tags = tags,
        _clickNum = clickNum,
        _collectionNum = collectionNum,
        _status = status,
        _lastUpdate = lastUpdate,
        _description = description,
        _volume = volume;
  factory ComicDetailV2Model.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<ComicDetailV2AuthorModel> authors =
        jsonRes['authors'] is List ? <ComicDetailV2AuthorModel>[] : null;
    if (authors != null) {
      for (final dynamic item in jsonRes['authors']) {
        if (item != null) {
          authors.add(ComicDetailV2AuthorModel.fromJson(
              asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final List<ComicDetailV2TagModel> tags =
        jsonRes['tags'] is List ? <ComicDetailV2TagModel>[] : null;
    if (tags != null) {
      for (final dynamic item in jsonRes['tags']) {
        if (item != null) {
          tags.add(
              ComicDetailV2TagModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    final List<ComicDetailV2VolumeModel> volume =
        jsonRes['volume'] is List ? <ComicDetailV2VolumeModel>[] : null;
    if (volume != null) {
      for (final dynamic item in jsonRes['volume']) {
        if (item != null) {
          volume.add(ComicDetailV2VolumeModel.fromJson(
              asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return ComicDetailV2Model(
      oldApi: asT<bool>(jsonRes['old_api']),
      comicId: asT<int>(jsonRes['comic_id']),
      title: asT<String>(jsonRes['title']),
      authors: authors,
      cover: asT<String>(jsonRes['cover']),
      tags: tags,
      clickNum: asT<int>(jsonRes['click_num']),
      collectionNum: asT<int>(jsonRes['collection_num']),
      status: asT<String>(jsonRes['status']),
      lastUpdate: asT<String>(jsonRes['last_update']),
      description: asT<String>(jsonRes['description']),
      volume: volume,
    );
  }

  bool _oldApi;
  bool get oldApi => _oldApi;
  set oldApi(value) {
    _oldApi = value;
  }

  int _comicId;
  int get comicId => _comicId;
  set comicId(value) {
    _comicId = value;
  }

  String _title;
  String get title => _title;
  set title(value) {
    _title = value;
  }

  List<ComicDetailV2AuthorModel> _authors;
  List<ComicDetailV2AuthorModel> get authors => _authors;
  set authors(value) {
    _authors = value;
  }

  String _cover;
  String get cover => _cover;
  set cover(value) {
    _cover = value;
  }

  List<ComicDetailV2TagModel> _tags;
  List<ComicDetailV2TagModel> get tags => _tags;
  set tags(value) {
    _tags = value;
  }

  int _clickNum;
  int get clickNum => _clickNum;
  set clickNum(value) {
    _clickNum = value;
  }

  int _collectionNum;
  int get collectionNum => _collectionNum;
  set collectionNum(value) {
    _collectionNum = value;
  }

  String _status;
  String get status => _status;
  set status(value) {
    _status = value;
  }

  String _lastUpdate;
  String get lastUpdate => _lastUpdate;
  set lastUpdate(value) {
    _lastUpdate = value;
  }

  String _description;
  String get description => _description;
  set description(value) {
    _description = value;
  }

  List<ComicDetailV2VolumeModel> _volume;
  List<ComicDetailV2VolumeModel> get volume => _volume;
  set volume(value) {
    _volume = value;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'old_api': _oldApi,
        'comic_id': _comicId,
        'title': _title,
        'authors': _authors,
        'cover': _cover,
        'tags': _tags,
        'click_num': _clickNum,
        'collection_num': _collectionNum,
        'status': _status,
        'last_update': _lastUpdate,
        'description': _description,
        'volume': _volume,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicDetailV2AuthorModel {
  ComicDetailV2AuthorModel({
    String authorName,
    int authorId,
  })  : _authorName = authorName,
        _authorId = authorId;
  factory ComicDetailV2AuthorModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : ComicDetailV2AuthorModel(
              authorName: asT<String>(jsonRes['author_name']),
              authorId: asT<int>(jsonRes['author_id']),
            );

  String _authorName;
  String get authorName => _authorName;
  set authorName(value) {
    _authorName = value;
  }

  int _authorId;
  int get authorId => _authorId;
  set authorId(value) {
    _authorId = value;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'author_name': _authorName,
        'author_id': _authorId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicDetailV2TagModel {
  ComicDetailV2TagModel({
    String tagName,
    int tagId,
  })  : _tagName = tagName,
        _tagId = tagId;
  factory ComicDetailV2TagModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : ComicDetailV2TagModel(
              tagName: asT<String>(jsonRes['tag_name']),
              tagId: asT<int>(jsonRes['tag_id']),
            );

  String _tagName;
  String get tagName => _tagName;
  set tagName(value) {
    _tagName = value;
  }

  int _tagId;
  int get tagId => _tagId;
  set tagId(value) {
    _tagId = value;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tag_name': _tagName,
        'tag_id': _tagId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicDetailV2VolumeModel {
  ComicDetailV2VolumeModel({
    int volumeId,
    String volumeTitle,
    bool reverse,
    List<ComicDetailV2VolumeChapterModel> chapters,
  })  : _volumeId = volumeId,
        _volumeTitle = volumeTitle,
        _reverse = reverse,
        _chapters = chapters;
  factory ComicDetailV2VolumeModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<ComicDetailV2VolumeChapterModel> chapters =
        jsonRes['chapters'] is List
            ? <ComicDetailV2VolumeChapterModel>[]
            : null;
    if (chapters != null) {
      for (final dynamic item in jsonRes['chapters']) {
        if (item != null) {
          chapters.add(ComicDetailV2VolumeChapterModel.fromJson(
              asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return ComicDetailV2VolumeModel(
      volumeId: asT<int>(jsonRes['volume_id']),
      volumeTitle: asT<String>(jsonRes['volume_title']),
      reverse: asT<bool>(jsonRes['reverse']),
      chapters: chapters,
    );
  }

  int _volumeId;
  int get volumeId => _volumeId;
  set volumeId(value) {
    _volumeId = value;
  }

  String _volumeTitle;
  String get volumeTitle => _volumeTitle;
  set volumeTitle(value) {
    _volumeTitle = value;
  }

  bool _reverse;
  bool get reverse => _reverse;
  set reverse(value) {
    _reverse = value;
  }

  List<ComicDetailV2VolumeChapterModel> _chapters;
  List<ComicDetailV2VolumeChapterModel> get chapters => _chapters;
  set chapters(value) {
    _chapters = value;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'volume_id': _volumeId,
        'volume_title': _volumeTitle,
        'reverse': _reverse,
        'chapters': _chapters,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComicDetailV2VolumeChapterModel {
  ComicDetailV2VolumeChapterModel({
    int chpaterId,
    String chapterTitle,
    int chapterOrder,
    String updatetime,
    int comicId,
    int volumeId,
    String volumeTitle,
  })  : _chpaterId = chpaterId,
        _chapterTitle = chapterTitle,
        _chapterOrder = chapterOrder,
        _updatetime = updatetime,
        _comicId = comicId,
        _volumeId = volumeId,
        _volumeTitle = volumeTitle;
  factory ComicDetailV2VolumeChapterModel.fromJson(
          Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : ComicDetailV2VolumeChapterModel(
              chpaterId: asT<int>(jsonRes['chpater_id']),
              chapterTitle: asT<String>(jsonRes['chapter_title']),
              chapterOrder: asT<int>(jsonRes['chapter_order']),
              updatetime: asT<String>(jsonRes['updatetime']),
              comicId: asT<int>(jsonRes['comic_id']),
              volumeId: asT<int>(jsonRes['volume_id']),
              volumeTitle: asT<String>(jsonRes['volume_title']),
            );

  int _chpaterId;
  int get chpaterId => _chpaterId;
  set chpaterId(value) {
    _chpaterId = value;
  }

  String _chapterTitle;
  String get chapterTitle => _chapterTitle;
  set chapterTitle(value) {
    _chapterTitle = value;
  }

  int _chapterOrder;
  int get chapterOrder => _chapterOrder;
  set chapterOrder(value) {
    _chapterOrder = value;
  }

  String _updatetime;
  String get updatetime => _updatetime;
  set updatetime(value) {
    _updatetime = value;
  }

  int _comicId;
  int get comicId => _comicId;
  set comicId(value) {
    _comicId = value;
  }

  int _volumeId;
  int get volumeId => _volumeId;
  set volumeId(value) {
    _volumeId = value;
  }

  String _volumeTitle;
  String get volumeTitle => _volumeTitle;
  set volumeTitle(value) {
    _volumeTitle = value;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chpater_id': _chpaterId,
        'chapter_title': _chapterTitle,
        'chapter_order': _chapterOrder,
        'updatetime': _updatetime,
        'comic_id': _comicId,
        'volume_id': _volumeId,
        'volume_title': _volumeTitle,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
