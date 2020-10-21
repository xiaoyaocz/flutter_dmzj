import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/models/user/user_model.dart';
import 'package:flutter_dmzj/models/user/user_profile.dart';
import 'package:http/http.dart' as http;

class AppUserInfo with ChangeNotifier {
  AppUserInfo() {
    changeIsLogin(ConfigHelper.getUserIsLogined());
    changeBindTel(ConfigHelper.getUserIsBindTel());
    changeLoginInfo(ConfigHelper.getUserInfo());
    changeUserProfile(ConfigHelper.getUserProfile());
  }

  bool _isLogin;
  get isLogin => _isLogin;
  void changeIsLogin(bool value) {
    _isLogin = value;

    notifyListeners();
    ConfigHelper.setUserIsLogined(value);
  }

  //是否绑定手机号码，未绑定不能评论
  bool _isBindTel;
  get isBindTel => _isBindTel;
  void changeBindTel(bool value) {
    _isBindTel = value;

    notifyListeners();
    ConfigHelper.setUserIsBindTel(value);
  }

  //登录获得的用户信息,含Token
  UserInfo _userInfo;
  UserInfo get loginInfo => _userInfo;
  void changeLoginInfo(UserInfo value) {
    _userInfo = value;
    notifyListeners();
    ConfigHelper.setUserInfo(value);
  }

  //用户详细资料
  UserProfileModel _userProfile;
  UserProfileModel get userProfile => _userProfile;
  void changeUserProfile(UserProfileModel value) {
    _userProfile = value;
    notifyListeners();
    ConfigHelper.setUserProfile(value);
  }

  Future getUserProfile(String uid, String token) async {
    try {
      var result = await http.get(Api.userProfile(uid, token));
      var body = result.body;
      var data = UserProfileModel.fromJson(jsonDecode(body));
      if (data != null) {
        changeUserProfile(data);
      }
    } catch (e) {}
  }

  void logout() {
    changeIsLogin(false);
    changeLoginInfo(null);
    changeUserProfile(null);
    changeBindTel(false);
  }
}
