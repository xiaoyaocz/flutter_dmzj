import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicCategoryItemModel {
  ComicCategoryItemModel({
    required this.tagId,
    required this.title,
    required this.cover,
  });

  factory ComicCategoryItemModel.fromJson(Map<String, dynamic> json) =>
      ComicCategoryItemModel(
        tagId: asT<int>(json['tagId'])!,
        title: asT<String>(json['title'])!,
        cover: asT<String>(json['cover'])!,
      );

  int tagId;
  String title;
  String cover;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tagId': tagId,
        'title': title,
        'cover': cover,
      };
}
