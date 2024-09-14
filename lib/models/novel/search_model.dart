import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelSearchModel {
  NovelSearchModel({
    required this.id,
    required this.title,
    this.authors,
    this.cover,
    this.hotHits,
    this.lastName,
    this.status,
    this.types,
    this.subNums,
  });

  factory NovelSearchModel.fromJson(Map<String, dynamic> json) =>
      NovelSearchModel(
        id: asT<int>(json['id'])!,
        title: asT<String>(json['title'])!,
        authors: asT<String?>(json['authors']),
        cover: asT<String?>(json['cover']),
        hotHits: asT<int?>(json['hot_hits']),
        lastName: asT<String?>(json['last_name']),
        status: asT<String?>(json['status']),
        types: asT<String?>(json['types']),
        subNums: asT<int?>(json['sub_nums']),
      );

  int id;
  String title;
  String? authors;
  String? cover;
  int? hotHits;
  String? lastName;
  String? status;
  String? types;
  int? subNums;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'authors': authors,
        'cover': cover,
        'hot_hits': hotHits,
        'last_name': lastName,
        'status': status,
        'types': types,
        'sub_nums': subNums,
      };
}
