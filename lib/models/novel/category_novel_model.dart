import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelCategoryNovelModel {
  NovelCategoryNovelModel({
    required this.cover,
    required this.name,
    required this.authors,
    required this.id,
  });

  factory NovelCategoryNovelModel.fromJson(Map<String, dynamic> json) =>
      NovelCategoryNovelModel(
        cover: asT<String>(json['cover'])!,
        name: asT<String>(json['name'])!,
        authors: asT<String>(json['authors'])!,
        id: asT<int>(json['id'])!,
      );

  String cover;
  String name;
  String authors;
  int id;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cover': cover,
        'name': name,
        'authors': authors,
        'id': id,
      };
}
