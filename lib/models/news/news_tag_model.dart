import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NewsTagModel {
  NewsTagModel({
    required this.tagId,
    required this.tagName,
  });

  factory NewsTagModel.fromJson(Map<String, dynamic> json) => NewsTagModel(
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
