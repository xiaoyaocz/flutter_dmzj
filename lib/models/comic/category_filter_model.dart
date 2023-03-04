import 'dart:convert';

import 'package:get/get.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicCategoryFilterModel {
  ComicCategoryFilterModel({
    required this.title,
    required this.items,
  });

  factory ComicCategoryFilterModel.fromJson(Map<String, dynamic> json) {
    final List<ComicCategoryFilterItemModel>? items =
        json['items'] is List ? <ComicCategoryFilterItemModel>[] : null;
    if (items != null) {
      for (final dynamic item in json['items']!) {
        if (item != null) {
          items.add(ComicCategoryFilterItemModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicCategoryFilterModel(
      title: asT<String>(json['title'])!,
      items: items!,
    );
  }

  String title;
  List<ComicCategoryFilterItemModel> items;
  var selectId = 0.obs;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'items': items,
      };
}

class ComicCategoryFilterItemModel {
  ComicCategoryFilterItemModel({
    required this.tagId,
    required this.tagName,
  });

  factory ComicCategoryFilterItemModel.fromJson(Map<String, dynamic> json) =>
      ComicCategoryFilterItemModel(
        tagId: asT<int>(json['tag_id'])!,
        tagName: asT<String>(json['tag_name'])!,
      );

  int tagId;
  String tagName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tag_id': tagId,
        'tag_name': tagName,
      };
}
