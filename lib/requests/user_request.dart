import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/user/bind_status_model.dart';
import 'package:flutter_dmzj/models/user/login_result_model.dart';
import 'package:flutter_dmzj/models/user/subscribe_comic_model.dart';
import 'package:flutter_dmzj/models/user/subscribe_news_model.dart';
import 'package:flutter_dmzj/models/user/subscribe_novel_model.dart';
import 'package:flutter_dmzj/models/user/user_profile_model.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/user_service.dart';

class UserRequest {
  Future<LoginResultModel> login(
      {required String nickname, required String password}) async {
    var pwd = md5.convert(utf8.encode(password)).toString().toUpperCase();

    Map<String, dynamic> data = Api.getDefaultParameter();
    data.addAll({
      "_m": "D6132DCE99D329CACDE913C7FA952CF3",
      "_a": "05CDFDA93076FC56950D6598B94FD986",
      "_i": "8508AEE02C57308631D8E5F774D3AABC",
      "nickname": nickname,
      "pwd": pwd,
    });

    var result = await HttpClient.instance.postJson(
      "/loginV2/m_confirm",
      baseUrl: Api.BASE_URL_USER,
      data: data,
      formUrlEncoded: true,
    );
    var jsonResult = json.decode(result);
    if (jsonResult["result"] == 1) {
      var data = LoginResultModel.fromJson(jsonResult["data"]);
      return data;
    } else {
      throw AppError(jsonResult["msg"].toString());
    }
  }

  /// 用户资料
  Future<UserProfileModel> userProfile() async {
    var result = await HttpClient.instance.getJson(
      "/UCenter/comicsv2/${UserService.instance.userId}.json",
      baseUrl: Api.BASE_URL_V3,
      queryParameters: {
        "dmzj_token": UserService.instance.dmzjToken,
      },
      withDefaultParameter: true,
    );

    return UserProfileModel.fromJson(result);
  }

  /// 获取绑定手机、设置密码状态
  Future<UserBindStatusModel> isBindTelPwd() async {
    var result = await HttpClient.instance.getJson(
      "/account/isbindtelpwd",
      baseUrl: Api.BASE_URL_V3,
      queryParameters: {
        "dmzj_token": UserService.instance.dmzjToken,
      },
      withDefaultParameter: true,
      checkCode: true,
    );

    return UserBindStatusModel.fromJson(result);
  }

  /// 我的漫画订阅
  /// - [page] 页数从0开始
  /// - [subType] 全部=1，未读=2，已读=3，完结=4
  /// - [letter] all=全部
  Future<List<UserSubscribeComicModel>> comicSubscribes(
      {required int subType, int page = 0, String letter = "all"}) async {
    var list = <UserSubscribeComicModel>[];
    var result = await HttpClient.instance.getJson(
      '/UCenter/subscribe',
      queryParameters: {
        //uid=$uid&sub_type=$subType&letter=$letter&dmzj_token=$token&page=$page&type=$type
        "type": 0,
        "sub_type": subType,
        "letter": letter,
        "dmzj_token": UserService.instance.dmzjToken,
        "page": page,
      },
      needLogin: true,
    );
    for (var item in result) {
      list.add(UserSubscribeComicModel.fromJson(item));
    }
    return list;
  }

  /// 我的漫画订阅
  /// - [page] 页数从0开始
  /// - [subType] 全部=1，未读=2，已读=3，完结=4
  /// - [letter] all=全部
  Future<List<UserSubscribeNovelModel>> novelSubscribes(
      {required int subType, int page = 0, String letter = "all"}) async {
    var list = <UserSubscribeNovelModel>[];
    var result = await HttpClient.instance.getJson(
      '/UCenter/subscribe',
      queryParameters: {
        //uid=$uid&sub_type=$subType&letter=$letter&dmzj_token=$token&page=$page&type=$type
        "type": 1,
        "sub_type": subType,
        "letter": letter,
        "dmzj_token": UserService.instance.dmzjToken,
        "page": page,
      },
      needLogin: true,
    );
    for (var item in result) {
      list.add(UserSubscribeNovelModel.fromJson(item));
    }
    return list;
  }

  /// 我的新闻收藏
  /// - [page] 页数从0开始
  Future<List<UserSubscribeNewsModel>> newsSubscribes({int page = 1}) async {
    var uid = UserService.instance.userId;
    var par = {"uid": int.parse(uid), "page": page};
    var parJson = jsonEncode(par);
    var sign = Api.sign(parJson, 'app_news_sub');

    var result = await HttpClient.instance.postJson(
      '/api/news/getSubscribe',
      baseUrl: Api.BASE_URL_INTERFACE,
      data: {
        "parm": parJson,
        "sign": sign,
      },
    );
    var data = json.decode(result);
    if (data["result"] != 1000) {
      throw AppError(data["msg"]);
    }
    var list = <UserSubscribeNewsModel>[];
    for (var item in data["data"]) {
      list.add(UserSubscribeNewsModel.fromJson(item));
    }
    return list;
  }

  /// 添加订阅
  /// - [type] 类型，对应AppConstant
  Future<bool> addSubscribe({required List<int> ids, required int type}) async {
    var typeStr = "mh";
    if (type == AppConstant.kTypeComic) {
      typeStr = "mh";
    } else if (type == AppConstant.kTypeNovel) {
      typeStr = "xs";
    }

    await HttpClient.instance.postJson(
      '/subscribe/add',
      data: {
        "obj_ids": ids.join(","),
        "type": typeStr,
        "uid": UserService.instance.userId,
      },
    );
    return true;
  }

  /// 取消订阅
  /// - [type] 类型，对应AppConstant
  Future<bool> removeSubscribe(
      {required List<int> ids, required int type}) async {
    var typeStr = "mh";
    if (type == AppConstant.kTypeComic) {
      typeStr = "mh";
    } else if (type == AppConstant.kTypeNovel) {
      typeStr = "xs";
    }

    await HttpClient.instance.getJson(
      '/subscribe/cancel',
      queryParameters: {
        "obj_ids": ids.join(","),
        "type": typeStr,
        "uid": UserService.instance.userId,
      },
    );
    return true;
  }

  /// 查询订阅状态
  /// - [objId] 漫画ID或小说ID
  /// - [type] 类型，对应AppConstant
  Future<bool> checkSubscribeStatus(
      {required int objId, required int type}) async {
    var typeId = 0;
    if (type == AppConstant.kTypeComic) {
      typeId = 0;
    } else if (type == AppConstant.kTypeNovel) {
      typeId = 1;
    }
    await HttpClient.instance.getJson(
      '/subscribe/$typeId/${UserService.instance.userId}/$objId',
      checkCode: true,
    );
    return true;
  }
}
