import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelRankModel {
  NovelRankModel({
    required this.id,
    required this.lastUpdateTime,
    required this.name,
    required this.types,
    required this.cover,
    required this.authors,
    required this.lastUpdateChapterName,
    required this.top,
    required this.subscribeAmount,
  });

  factory NovelRankModel.fromJson(Map<String, dynamic> json) {
    final List<String>? types = json['types'] is List ? <String>[] : null;
    if (types != null) {
      for (final dynamic item in json['types']!) {
        if (item != null) {
          types.add(asT<String>(item)!);
        }
      }
    }
    return NovelRankModel(
      id: asT<int>(json['id'])!,
      lastUpdateTime: asT<int>(json['last_update_time'])!,
      name: asT<String>(json['name'])!,
      types: types!,
      cover: asT<String>(json['cover'])!,
      authors: asT<String>(json['authors'])!,
      lastUpdateChapterName: asT<String>(json['last_update_chapter_name'])!,
      top: asT<int>(json['top'])!,
      subscribeAmount: asT<int>(json['subscribe_amount'])!,
    );
  }

  int id;
  int lastUpdateTime;
  String name;
  List<String> types;
  String cover;
  String authors;
  String lastUpdateChapterName;
  int top;
  int subscribeAmount;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'last_update_time': lastUpdateTime,
        'name': name,
        'types': types,
        'cover': cover,
        'authors': authors,
        'last_update_chapter_name': lastUpdateChapterName,
        'top': top,
        'subscribe_amount': subscribeAmount,
      };
}
