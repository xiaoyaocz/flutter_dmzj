import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserSubscribeNovelModel {
  UserSubscribeNovelModel({
    required this.name,
    required this.subUpdate,
    required this.subImg,
    required this.subUptime,
    required this.subFirstLetter,
    required this.subReaded,
    required this.id,
    required this.status,
  });

  factory UserSubscribeNovelModel.fromJson(Map<String, dynamic> json) =>
      UserSubscribeNovelModel(
        name: asT<String>(json['name'])!,
        subUpdate: asT<String>(json['sub_update'])!,
        subImg: asT<String>(json['sub_img'])!,
        subUptime: asT<int>(json['sub_uptime'])!,
        subFirstLetter: asT<String>(json['sub_first_letter'])!,
        subReaded: asT<int>(json['sub_readed'])!,
        id: asT<int>(json['id'])!,
        status: asT<String>(json['status'])!,
      );

  String name;
  String subUpdate;
  String subImg;
  int subUptime;
  String subFirstLetter;
  int subReaded;
  int id;
  String status;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'sub_update': subUpdate,
        'sub_img': subImg,
        'sub_uptime': subUptime,
        'sub_first_letter': subFirstLetter,
        'sub_readed': subReaded,
        'id': id,
        'status': status,
      };
}
