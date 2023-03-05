import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelCategoryModel {
  NovelCategoryModel({
    required this.tagId,
    required this.title,
    required this.cover,
  });

  factory NovelCategoryModel.fromJson(Map<String, dynamic> json) =>
      NovelCategoryModel(
        tagId: asT<int>(json['tag_id'])!,
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
        'tag_id': tagId,
        'title': title,
        'cover': cover,
      };
}
