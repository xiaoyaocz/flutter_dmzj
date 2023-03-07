import 'dart:convert';

import 'package:get/get.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicViewPointModel {
  ComicViewPointModel({
    required this.id,
    required this.uid,
    required this.content,
    required this.num,
    required this.page,
  });

  factory ComicViewPointModel.fromJson(Map<String, dynamic> json) =>
      ComicViewPointModel(
        id: asT<int>(json['id'])!,
        uid: asT<int>(json['uid'])!,
        content: asT<String>(json['content'])!,
        num: (asT<int?>(json['num']) ?? 0).obs,
        page: asT<int>(json['page'])!,
      );

  int id;
  int uid;
  String content;
  RxInt num;
  int page;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'uid': uid,
        'content': content,
        'num': num,
        'page': page,
      };
}
