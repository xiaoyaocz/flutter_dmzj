import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicSearchModel {
  ComicSearchModel({
    required this.biz,
    required this.addtime,
    required this.aliasName,
    required this.authors,
    required this.copyright,
    required this.cover,
    required this.deviceShow,
    required this.grade,
    required this.hidden,
    required this.hotHits,
    required this.lastName,
    required this.quality,
    required this.status,
    required this.title,
    required this.types,
    required this.id,
  });

  factory ComicSearchModel.fromJson(Map<String, dynamic> json) =>
      ComicSearchModel(
        biz: asT<String>(json['_biz'])!,
        addtime: asT<int>(json['addtime'])!,
        aliasName: asT<String>(json['alias_name'])!,
        authors: asT<String>(json['authors'])!,
        copyright: asT<int>(json['copyright'])!,
        cover: asT<String>(json['cover'])!,
        deviceShow: asT<int>(json['device_show'])!,
        grade: asT<int>(json['grade'])!,
        hidden: asT<int>(json['hidden'])!,
        hotHits: asT<int>(json['hot_hits'])!,
        lastName: asT<String>(json['last_name'])!,
        quality: asT<int>(json['quality'])!,
        status: asT<int>(json['status'])!,
        title: asT<String>(json['title'])!,
        types: asT<String>(json['types'])!,
        id: asT<int>(json['id'])!,
      );

  String biz;
  int addtime;
  String aliasName;
  String authors;
  int copyright;
  String cover;
  int deviceShow;
  int grade;
  int hidden;
  int hotHits;
  String lastName;
  int quality;
  int status;
  String title;
  String types;
  int id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        '_biz': biz,
        'addtime': addtime,
        'alias_name': aliasName,
        'authors': authors,
        'copyright': copyright,
        'cover': cover,
        'device_show': deviceShow,
        'grade': grade,
        'hidden': hidden,
        'hot_hits': hotHits,
        'last_name': lastName,
        'quality': quality,
        'status': status,
        'title': title,
        'types': types,
        'id': id,
      };
}
