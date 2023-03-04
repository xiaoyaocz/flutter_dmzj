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
    required this.title,
    required this.authors,
    required this.status,
    required this.cover,
    required this.types,
    required this.lastUpdatetime,
    required this.num,
  });

  factory ComicCategoryComicModel.fromJson(Map<String, dynamic> json) =>
      ComicCategoryComicModel(
        id: asT<int>(json['id'])!,
        title: asT<String>(json['title'])!,
        authors: asT<String>(json['authors'])!,
        status: asT<String>(json['status'])!,
        cover: asT<String>(json['cover'])!,
        types: asT<String>(json['types'])!,
        lastUpdatetime: asT<int>(json['last_updatetime'])!,
        num: asT<int>(json['num'])!,
      );

  int id;
  String title;
  String authors;
  String status;
  String cover;
  String types;
  int lastUpdatetime;
  int num;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'authors': authors,
        'status': status,
        'cover': cover,
        'types': types,
        'last_updatetime': lastUpdatetime,
        'num': num,
      };
}
