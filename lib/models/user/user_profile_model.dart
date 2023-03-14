import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserProfileModel {
  UserProfileModel({
    required this.nickname,
    this.description,
    this.birthday,
    this.sex,
    this.cover,
    this.blood,
    this.constellation,
    this.bindPhone,
    this.email,
    this.channel,
    this.channelid,
    this.isVerify,
    this.status,
    this.reason,
    this.submitLogout,
    this.userDelInfo,
    this.ip,
    this.ipRegion,
    this.isModifyName,
    this.data,
    this.amount,
    this.isSetPwd,
    this.bind,
    this.userfeeinfo,
    this.userLevel,
    this.cookieVal,
    this.isBbsAdmin,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final List<Object>? data = json['data'] is List ? <Object>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(asT<Object>(item)!);
        }
      }
    }

    final List<UserPorfileBindModel>? bind =
        json['bind'] is List ? <UserPorfileBindModel>[] : null;
    if (bind != null) {
      for (final dynamic item in json['bind']!) {
        if (item != null) {
          bind.add(
              UserPorfileBindModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return UserProfileModel(
      nickname: asT<String>(json['nickname'])!,
      description: asT<String?>(json['description']),
      birthday: asT<String?>(json['birthday']),
      sex: asT<int?>(json['sex']),
      cover: asT<String?>(json['cover']),
      blood: asT<int?>(json['blood']),
      constellation: asT<String?>(json['constellation']),
      bindPhone: asT<String?>(json['bind_phone']),
      email: asT<String?>(json['email']),
      channel: asT<String?>(json['channel']),
      channelid: asT<String?>(json['channelid']),
      isVerify: asT<int?>(json['is_verify']),
      status: asT<int?>(json['status']),
      reason: asT<String?>(json['reason']),
      submitLogout: asT<bool?>(json['submit_logout']),
      userDelInfo: json['user_del_info'] == null
          ? null
          : UserDelInfoModel.fromJson(
              asT<Map<String, dynamic>>(json['user_del_info'])!),
      ip: asT<String?>(json['ip']),
      ipRegion: json['ip_region'] == null
          ? null
          : UserIpRegionModel.fromJson(
              asT<Map<String, dynamic>>(json['ip_region'])!),
      isModifyName: asT<int?>(json['is_modify_name']),
      data: data,
      amount: asT<int?>(json['amount']),
      isSetPwd: asT<int?>(json['is_set_pwd']),
      bind: bind,
      userfeeinfo: json['userFeeInfo'] == null
          ? null
          : UserfeeInfo.fromJson(
              asT<Map<String, dynamic>>(json['userFeeInfo'])!),
      userLevel: asT<String?>(json['user_level']),
      cookieVal: asT<String?>(json['cookie_val']),
      isBbsAdmin: asT<int?>(json['is_bbs_admin']),
    );
  }

  String nickname;
  String? description;
  String? birthday;
  int? sex;
  String? cover;
  int? blood;
  String? constellation;
  String? bindPhone;
  String? email;
  String? channel;
  String? channelid;
  int? isVerify;
  int? status;
  String? reason;
  bool? submitLogout;
  UserDelInfoModel? userDelInfo;
  String? ip;
  UserIpRegionModel? ipRegion;
  int? isModifyName;
  List<Object>? data;
  int? amount;
  int? isSetPwd;
  List<UserPorfileBindModel>? bind;
  UserfeeInfo? userfeeinfo;
  String? userLevel;
  String? cookieVal;
  int? isBbsAdmin;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickname': nickname,
        'description': description,
        'birthday': birthday,
        'sex': sex,
        'cover': cover,
        'blood': blood,
        'constellation': constellation,
        'bind_phone': bindPhone,
        'email': email,
        'channel': channel,
        'channelid': channelid,
        'is_verify': isVerify,
        'status': status,
        'reason': reason,
        'submit_logout': submitLogout,
        'user_del_info': userDelInfo,
        'ip': ip,
        'ip_region': ipRegion,
        'is_modify_name': isModifyName,
        'data': data,
        'amount': amount,
        'is_set_pwd': isSetPwd,
        'bind': bind,
        'userFeeInfo': userfeeinfo,
        'user_level': userLevel,
        'cookie_val': cookieVal,
        'is_bbs_admin': isBbsAdmin,
      };
}

class UserDelInfoModel {
  UserDelInfoModel({
    this.uid,
    this.logoutId,
    this.status,
    this.subTime,
    this.cancelTime,
    this.cancelUserType,
    this.currentTime,
  });

  factory UserDelInfoModel.fromJson(Map<String, dynamic> json) =>
      UserDelInfoModel(
        uid: asT<int?>(json['uid']),
        logoutId: asT<int?>(json['logout_id']),
        status: asT<int?>(json['status']),
        subTime: asT<int?>(json['sub_time']),
        cancelTime: asT<int?>(json['cancel_time']),
        cancelUserType: asT<int?>(json['cancel_user_type']),
        currentTime: asT<int?>(json['current_time']),
      );

  int? uid;
  int? logoutId;
  int? status;
  int? subTime;
  int? cancelTime;
  int? cancelUserType;
  int? currentTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'logout_id': logoutId,
        'status': status,
        'sub_time': subTime,
        'cancel_time': cancelTime,
        'cancel_user_type': cancelUserType,
        'current_time': currentTime,
      };
}

class UserIpRegionModel {
  UserIpRegionModel({
    this.country,
    this.province,
    this.city,
    this.provider,
  });

  factory UserIpRegionModel.fromJson(Map<String, dynamic> json) =>
      UserIpRegionModel(
        country: asT<String?>(json['country']),
        province: asT<String?>(json['province']),
        city: asT<String?>(json['city']),
        provider: asT<String?>(json['provider']),
      );

  String? country;
  String? province;
  String? city;
  String? provider;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'country': country,
        'province': province,
        'city': city,
        'provider': provider,
      };
}

class UserPorfileBindModel {
  UserPorfileBindModel({
    this.type,
    this.name,
  });

  factory UserPorfileBindModel.fromJson(Map<String, dynamic> json) =>
      UserPorfileBindModel(
        type: asT<String?>(json['type']),
        name: asT<String?>(json['name']),
      );

  String? type;
  String? name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'name': name,
      };
}

class UserfeeInfo {
  UserfeeInfo({
    this.mCate,
    this.mPeriod,
  });

  factory UserfeeInfo.fromJson(Map<String, dynamic> json) => UserfeeInfo(
        mCate: asT<int?>(json['m_cate']),
        mPeriod: asT<int?>(json['m_period']),
      );

  int? mCate;
  int? mPeriod;

  bool get isVip => (mCate ?? 0) > 0;
  DateTime get expiresTime =>
      DateTime.fromMillisecondsSinceEpoch((mPeriod ?? 0) * 1000);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'm_cate': mCate,
        'm_period': mPeriod,
      };
}
