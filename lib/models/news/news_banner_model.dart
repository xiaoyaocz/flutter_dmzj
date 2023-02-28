import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NewsBannerModel {
  NewsBannerModel({
    required this.id,
    required this.title,
    required this.picUrl,
    this.objectId,
    this.objectUrl,
  });

  factory NewsBannerModel.fromJson(Map<String, dynamic> json) =>
      NewsBannerModel(
        id: asT<int>(json['id'])!,
        title: asT<String>(json['title'])!,
        picUrl: asT<String>(json['pic_url'])!,
        objectId: asT<int?>(json['object_id']),
        objectUrl: asT<String?>(json['object_url']),
      );

  int id;
  String title;
  String picUrl;
  int? objectId;
  String? objectUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'pic_url': picUrl,
        'object_id': objectId,
        'object_url': objectUrl,
      };
}
