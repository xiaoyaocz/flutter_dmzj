import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicSearchModel {
  ComicSearchModel({
    required this.id,
    this.authors,
    this.copyright,
    this.cover,
    this.hotHits,
    this.lastName,
    this.status,
    required this.title,
    this.types,
    this.aliasName,
    this.comicPy,
  });

  factory ComicSearchModel.fromJson(Map<String, dynamic> json) =>
      ComicSearchModel(
        id: asT<int>(json['id'])!,
        authors: asT<String?>(json['authors']),
        copyright: asT<int?>(json['copyright']),
        cover: asT<String?>(json['cover']),
        hotHits: asT<int?>(json['hot_hits']),
        lastName: asT<String?>(json['last_name']),
        status: asT<String?>(json['status']),
        title: asT<String>(json['title'])!,
        types: asT<String?>(json['types']),
        aliasName: asT<String?>(json['alias_name']),
        comicPy: asT<String?>(json['comic_py']),
      );

  int id;
  String? authors;
  int? copyright;
  String? cover;
  int? hotHits;
  String? lastName;
  String? status;
  String title;
  String? types;
  String? aliasName;
  String? comicPy;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'authors': authors,
        'copyright': copyright,
        'cover': cover,
        'hot_hits': hotHits,
        'last_name': lastName,
        'status': status,
        'title': title,
        'types': types,
        'alias_name': aliasName,
        'comic_py': comicPy,
      };
}
