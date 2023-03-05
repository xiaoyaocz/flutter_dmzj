import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelSearchModel {
  NovelSearchModel({
    required this.biz,
    required this.addtime,
    required this.authors,
    required this.copyright,
    required this.cover,
    required this.hidden,
    required this.hotHits,
    required this.lastName,
    required this.status,
    required this.title,
    required this.types,
    required this.id,
  });

  factory NovelSearchModel.fromJson(Map<String, dynamic> json) =>
      NovelSearchModel(
        biz: asT<String>(json['_biz'])!,
        addtime: asT<int>(json['addtime'])!,
        authors: asT<String>(json['authors'])!,
        copyright: asT<int>(json['copyright'])!,
        cover: asT<String>(json['cover'])!,
        hidden: asT<int>(json['hidden'])!,
        hotHits: asT<int>(json['hot_hits'])!,
        lastName: asT<String>(json['last_name'])!,
        status: asT<int>(json['status'])!,
        title: asT<String>(json['title'])!,
        types: asT<String>(json['types'])!,
        id: asT<int>(json['id'])!,
      );

  String biz;
  int addtime;
  String authors;
  int copyright;
  String cover;
  int hidden;
  int hotHits;
  String lastName;
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
        'authors': authors,
        'copyright': copyright,
        'cover': cover,
        'hidden': hidden,
        'hot_hits': hotHits,
        'last_name': lastName,
        'status': status,
        'title': title,
        'types': types,
        'id': id,
      };
}
