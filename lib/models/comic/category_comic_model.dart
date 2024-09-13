import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicCategoryComicModel {
  ComicCategoryComicModel({
    required this.id,
    required this.name,
    this.authors,
    this.types,
    this.status,
    this.lastUpdateChapterName,
    this.lastUpdateChapterId,
    this.lastUpdatetime,
    this.cover,
    this.comicPy,
    this.isFee,
    this.hotNum,
    this.authorTag,
    this.authorTagList,
    this.copyright,
  });

  factory ComicCategoryComicModel.fromJson(Map<String, dynamic> json) {
    final List<AuthorTagList>? authorTagList =
        json['authorTagList'] is List ? <AuthorTagList>[] : null;
    if (authorTagList != null) {
      for (final dynamic item in json['authorTagList']!) {
        if (item != null) {
          authorTagList
              .add(AuthorTagList.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicCategoryComicModel(
      id: asT<int>(json['id'])!,
      name: asT<String>(json['name'])!,
      authors: asT<String?>(json['authors']),
      types: asT<String?>(json['types']),
      status: asT<String?>(json['status']),
      lastUpdateChapterName: asT<String?>(json['last_update_chapter_name']),
      lastUpdateChapterId: asT<int?>(json['last_update_chapter_id']),
      lastUpdatetime: asT<int?>(json['last_updatetime']),
      cover: asT<String?>(json['cover']),
      comicPy: asT<String?>(json['comic_py']),
      isFee: asT<bool?>(json['isFee']),
      hotNum: asT<int?>(json['hotNum']),
      authorTag: json['authorTag'] == null
          ? null
          : AuthorTag.fromJson(asT<Map<String, dynamic>>(json['authorTag'])!),
      authorTagList: authorTagList,
      copyright: asT<int?>(json['copyright']),
    );
  }

  int id;
  String name;
  String? authors;
  String? types;
  String? status;
  String? lastUpdateChapterName;
  int? lastUpdateChapterId;
  int? lastUpdatetime;
  String? cover;
  String? comicPy;
  bool? isFee;
  int? hotNum;
  AuthorTag? authorTag;
  List<AuthorTagList>? authorTagList;
  int? copyright;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'authors': authors,
        'types': types,
        'status': status,
        'last_update_chapter_name': lastUpdateChapterName,
        'last_update_chapter_id': lastUpdateChapterId,
        'last_updatetime': lastUpdatetime,
        'cover': cover,
        'comic_py': comicPy,
        'isFee': isFee,
        'hotNum': hotNum,
        'authorTag': authorTag,
        'authorTagList': authorTagList,
        'copyright': copyright,
      };
}

class AuthorTag {
  AuthorTag({
    this.id,
    this.tagName,
    this.tagPy,
  });

  factory AuthorTag.fromJson(Map<String, dynamic> json) => AuthorTag(
        id: asT<int?>(json['id']),
        tagName: asT<String?>(json['tagName']),
        tagPy: asT<String?>(json['tagPy']),
      );

  int? id;
  String? tagName;
  String? tagPy;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'tagName': tagName,
        'tagPy': tagPy,
      };
}

class AuthorTagList {
  AuthorTagList({
    this.id,
    this.tagName,
    this.tagPy,
  });

  factory AuthorTagList.fromJson(Map<String, dynamic> json) => AuthorTagList(
        id: asT<int?>(json['id']),
        tagName: asT<String?>(json['tagName']),
        tagPy: asT<String?>(json['tagPy']),
      );

  int? id;
  String? tagName;
  String? tagPy;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'tagName': tagName,
        'tagPy': tagPy,
      };
}
