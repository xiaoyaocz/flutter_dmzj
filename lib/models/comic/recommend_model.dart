import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicRecommendModel {
  ComicRecommendModel({
    required this.categoryId,
    required this.title,
    required this.sort,
    required this.data,
  });

  factory ComicRecommendModel.fromJson(Map<String, dynamic> json) {
    final List<ComicRecommendItemModel>? data =
        json['data'] is List ? <ComicRecommendItemModel>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(ComicRecommendItemModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicRecommendModel(
      categoryId: asT<int>(json['category_id'])!,
      title: asT<String>(json['title'])!,
      sort: asT<int>(json['sort'])!,
      data: data??[],
    );
  }

  int categoryId;
  String title;
  int sort;
  List<ComicRecommendItemModel> data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'category_id': categoryId,
        'title': title,
        'sort': sort,
        'data': data,
      };
}

class ComicRecommendItemModel {
  ComicRecommendItemModel({
    required this.cover,
    required this.title,
    this.subTitle,
    this.type,
    this.url,
    required this.objId,
    this.status,
    this.id,
  });

  factory ComicRecommendItemModel.fromJson(Map<String, dynamic> json) =>
      ComicRecommendItemModel(
        id: asT<int?>(json['id']),
        cover: asT<String>(json['cover'])!,
        title: asT<String>(json['title'])!,
        subTitle: asT<String?>(json['sub_title']),
        type: asT<int?>(json['type']),
        url: asT<String?>(json['url']),
        objId: asT<int?>(json['obj_id']),
        status: asT<String?>(json['status']),
      );
  int? id;
  String cover;
  String title;
  String? subTitle;
  int? type;
  String? url;
  int? objId;
  String? status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'cover': cover,
        'title': title,
        'sub_title': subTitle,
        'type': type,
        'url': url,
        'obj_id': objId,
        'status': status,
      };
}
