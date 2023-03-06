import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserBindStatusModel {
  UserBindStatusModel({
    required this.isBindTel,
    required this.isSetPwd,
  });

  factory UserBindStatusModel.fromJson(Map<String, dynamic> json) =>
      UserBindStatusModel(
        isBindTel: asT<int>(json['is_bind_tel'])!,
        isSetPwd: asT<int>(json['is_set_pwd'])!,
      );

  int isBindTel;
  int isSetPwd;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'is_bind_tel': isBindTel,
        'is_set_pwd': isSetPwd,
      };
}
