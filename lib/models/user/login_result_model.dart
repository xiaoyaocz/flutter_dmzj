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
    required this.dmzjToken,
    required this.photo,
    required this.bindPhone,
    required this.email,
    required this.passwd,
    required this.cookieVal,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      LoginResultModel(
        uid: asT<String>(json['uid'])!,
        nickname: asT<String>(json['nickname'])!,
        dmzjToken: asT<String>(json['dmzj_token'])!,
        photo: asT<String>(json['photo'])!,
        bindPhone: asT<String>(json['bind_phone'])!,
        email: asT<String>(json['email'])!,
        passwd: asT<String>(json['passwd'])!,
        cookieVal: asT<String>(json['cookie_val'])!,
      );

  String uid;
  String nickname;
  String dmzjToken;
  String photo;
  String bindPhone;
  String email;
  String passwd;
  String cookieVal;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'nickname': nickname,
        'dmzj_token': dmzjToken,
        'photo': photo,
        'bind_phone': bindPhone,
        'email': email,
        'passwd': passwd,
        'cookie_val': cookieVal,
      };
}
