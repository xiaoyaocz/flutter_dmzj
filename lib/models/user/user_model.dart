import 'dart:convert' show json;

class UserLgoinModel {
  final int result;
  final String msg;
  final UserInfo data;

    UserLgoinModel({
this.result,
this.msg,
this.data,
    });


  factory UserLgoinModel.fromJson(jsonRes)=>jsonRes == null? null:UserLgoinModel(    result : jsonRes['result'],
    msg : jsonRes['msg'],
    data : UserInfo.fromJson(jsonRes['data']),
);
  Map<String, dynamic> toJson() => {
        'result': result,
        'msg': msg,
        'data': data,
};

  @override
String  toString() {
    return json.encode(this);
  }
}
class UserInfo {
  final String uid;
  final String nickname;
  final String dmzj_token;
  final String photo;
  final String bind_phone;
  final String email;
  final String passwd;

    UserInfo({
this.uid,
this.nickname,
this.dmzj_token,
this.photo,
this.bind_phone,
this.email,
this.passwd,
    });


  factory UserInfo.fromJson(jsonRes)=>jsonRes == null? null:UserInfo(    uid : jsonRes['uid'],
    nickname : jsonRes['nickname'],
    dmzj_token : jsonRes['dmzj_token'],
    photo : jsonRes['photo'],
    bind_phone : jsonRes['bind_phone'],
    email : jsonRes['email'],
    passwd : jsonRes['passwd'],
);
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nickname': nickname,
        'dmzj_token': dmzj_token,
        'photo': photo,
        'bind_phone': bind_phone,
        'email': email,
        'passwd': passwd,
};

  @override
  String  toString() {
    return json.encode(this);
  }
}


