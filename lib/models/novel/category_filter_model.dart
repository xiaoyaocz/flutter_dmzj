import 'dart:convert';

import 'package:get/get.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelCategoryFilterModel {
  NovelCategoryFilterModel({
    required this.title,
    required this.items,
  });

  factory NovelCategoryFilterModel.fromJson(Map<String, dynamic> json) {
    final List<NovelCategoryFilterItemModel>? items =
        json['items'] is List ? <NovelCategoryFilterItemModel>[] : null;
    if (items != null) {
      for (final dynamic item in json['items']!) {
        if (item != null) {
          items.add(NovelCategoryFilterItemModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return NovelCategoryFilterModel(
      title: asT<String>(json['title'])!,
      items: items!,
    );
  }

  String title;
  List<NovelCategoryFilterItemModel> items;
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

class NovelCategoryFilterItemModel {
  NovelCategoryFilterItemModel({
    required this.tagId,
    required this.tagName,
  });

  factory NovelCategoryFilterItemModel.fromJson(Map<String, dynamic> json) =>
      NovelCategoryFilterItemModel(
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
