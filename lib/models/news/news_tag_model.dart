import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NewsTagModel {
  NewsTagModel({
    required this.id,
    required this.name,
  });

  factory NewsTagModel.fromJson(Map<String, dynamic> json) => NewsTagModel(
        id: asT<int>(json['id'])!,
        name: asT<String>(json['name'])!,
      );

  int id;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
