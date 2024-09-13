import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class LoginResultModel {
  LoginResultModel({
    required this.uid,
    required this.nickname,
    required this.token,
    required this.photo,
    required this.bindPhone,
    required this.email,
    required this.setPasswd,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      LoginResultModel(
        uid: asT<int>(json['uid'])!,
        nickname: asT<String>(json['nickname'])!,
        token: asT<String>(json['token'])!,
        photo: asT<String>(json['photo'])!,
        bindPhone: asT<String>(json['bind_phone'])!,
        email: asT<String>(json['email'])!,
        setPasswd: asT<int>(json['setPasswd'])!,
      );

  int uid;
  String nickname;
  String token;
  String photo;
  String bindPhone;
  String email;
  int setPasswd;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'nickname': nickname,
        'token': token,
        'photo': photo,
        'bind_phone': bindPhone,
        'email': email,
        'setPasswd': setPasswd
      };
}
