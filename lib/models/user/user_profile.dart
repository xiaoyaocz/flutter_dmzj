// ignore_for_file: non_constant_identifier_names

import 'dart:convert' show json;

class UserProfileModel {
  final String nickname;
  final String description;
  final String birthday;
  final int sex;
  final String cover;
  final int blood;
  final String constellation;
  final String bind_phone;
  final String email;
  final String channel;
  final int is_verify;
  final int is_modify_name;
  final List<Object> data;
  final int amount;
  final int is_set_pwd;
  final List<UserBindModel> bind;

  UserProfileModel({
    this.nickname,
    this.description,
    this.birthday,
    this.sex,
    this.cover,
    this.blood,
    this.constellation,
    this.bind_phone,
    this.email,
    this.channel,
    this.is_verify,
    this.is_modify_name,
    this.data,
    this.amount,
    this.is_set_pwd,
    this.bind,
  });

  factory UserProfileModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Object> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          data.add(item);
        }
      }
    }

    List<UserBindModel> bind = jsonRes['bind'] is List ? [] : null;
    if (bind != null) {
      for (var item in jsonRes['bind']) {
        if (item != null) {
          bind.add(UserBindModel.fromJson(item));
        }
      }
    }

    return UserProfileModel(
      nickname: jsonRes['nickname'],
      description: jsonRes['description'],
      birthday: jsonRes['birthday'],
      sex: jsonRes['sex'],
      cover: jsonRes['cover'],
      blood: jsonRes['blood'],
      constellation: jsonRes['constellation'],
      bind_phone: jsonRes['bind_phone'].toString(),
      email: jsonRes['email'],
      channel: jsonRes['channel'],
      is_verify: jsonRes['is_verify'],
      is_modify_name: jsonRes['is_modify_name'],
      data: data,
      amount: jsonRes['amount'],
      is_set_pwd: jsonRes['is_set_pwd'],
      bind: bind,
    );
  }
  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'description': description,
        'birthday': birthday,
        'sex': sex,
        'cover': cover,
        'blood': blood,
        'constellation': constellation,
        'bind_phone': bind_phone,
        'email': email,
        'channel': channel,
        'is_verify': is_verify,
        'is_modify_name': is_modify_name,
        'data': data,
        'amount': amount,
        'is_set_pwd': is_set_pwd,
        'bind': bind,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class UserBindModel {
  final String type;
  final String name;

  UserBindModel({
    this.type,
    this.name,
  });

  factory UserBindModel.fromJson(jsonRes) => jsonRes == null
      ? null
      : UserBindModel(
          type: jsonRes['type'],
          name: jsonRes['name'].toString(),
        );
  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
