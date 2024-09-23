import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/user/comic_history_model.dart';
import 'package:flutter_dmzj/models/user/bind_status_model.dart';
import 'package:flutter_dmzj/models/user/login_result_model.dart';
import 'package:flutter_dmzj/models/user/novel_history_model.dart';
import 'package:flutter_dmzj/models/user/subscribe_comic_model.dart';
import 'package:flutter_dmzj/models/user/subscribe_news_model.dart';
import 'package:flutter_dmzj/models/user/subscribe_novel_model.dart';
import 'package:flutter_dmzj/models/user/user_profile_model.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';

class UserRequest {
  /// 登录
  /// - [nickname] 用户名
  /// - [password] 密码
  Future<LoginResultModel> login(
      {required String nickname, required String password}) async {
    var pwd = md5.convert(utf8.encode(password)).toString().toLowerCase();

    Map<String, dynamic> data = {
      "username": nickname,
      "passwd": pwd,
    };

    var result = await HttpClient.instance.postJson(
      "/login/passwd",
      baseUrl: Api.BASE_URL_USER,
      data: data,
      formUrlEncoded: true,
      checkCode: true,
    );

    return LoginResultModel.fromJson(result["user"]);
  }

  /// 用户资料
  Future<UserProfileModel> userProfile() async {
    var result = await HttpClient.instance.getJson(
      "/UCenter/comicsv2/${UserService.instance.userId}.json",
      baseUrl: Api.BASE_URL,
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
      baseUrl: Api.BASE_URL,
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
  Future<List<UserSubscribeComicItemModel>> comicSubscribes(
      {required int subType, int page = 0, String letter = ""}) async {
    var list = <UserSubscribeComicItemModel>[];
    var result = await HttpClient.instance.getJson(
      '/comic/sub/list',
      queryParameters: {
        //uid=$uid&sub_type=$subType&letter=$letter&dmzj_token=$token&page=$page&type=$type
        "status": subType,
        "firstLetter": letter,
        "page": page,
        "size": 20
      },
      needLogin: true,
      checkCode: true,
    );
    for (var item in result["subList"]) {
      list.add(UserSubscribeComicItemModel.fromJson(item));
    }
    return list;
  }

  /// 我的小说订阅
  /// - [page] 页数从0开始
  /// - [subType] 全部=1，未读=2，已读=3，完结=4
  /// - [letter] all=全部
  Future<List<UserSubscribeNovelModel>> novelSubscribes(
      {required int subType, int page = 0, String letter = "all"}) async {
    var list = <UserSubscribeNovelModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/sub/list',
      queryParameters: {
        //uid=$uid&sub_type=$subType&letter=$letter&dmzj_token=$token&page=$page&type=$type
        "status": subType,
        "firstLetter": letter,
        "page": page,
        "size": 20
      },
      needLogin: true,
      checkCode: true,
    );
    for (var item in result["subList"]) {
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
    var requestUrl = "/comic/sub/add";
    var requestQuery = <String, dynamic>{};
    if (type == AppConstant.kTypeComic) {
      requestUrl = "/comic/sub/add";
      requestQuery = {
        "comic_id": ids.join(","),
      };
    } else if (type == AppConstant.kTypeNovel) {
      requestUrl = "/novel/sub/add";
      requestQuery = {
        "novel_id": ids.join(","),
      };
    }

    await HttpClient.instance.getJson(
      requestUrl,
      queryParameters: requestQuery,
      needLogin: true,
      checkCode: true,
    );
    return true;
  }

  /// 更新订阅的阅读状态
  /// - [type] 类型，对应AppConstant
  Future<bool> subscribeRead({required int id, required int type}) async {
    var typeStr = "mh";
    if (type == AppConstant.kTypeComic) {
      typeStr = "mh";
    } else if (type == AppConstant.kTypeNovel) {
      typeStr = "xs";
    }

    await HttpClient.instance.getJson(
      '/subscribe/read',
      queryParameters: {
        "obj_id": id,
        "type": typeStr,
      },
      withDefaultParameter: true,
      needLogin: true,
    );
    return true;
  }

  /// 取消订阅
  /// - [type] 类型，对应AppConstant
  Future<bool> removeSubscribe(
      {required List<int> ids, required int type}) async {
    var requestUrl = "/comic/sub/del";
    var requestQuery = <String, dynamic>{};
    if (type == AppConstant.kTypeComic) {
      requestUrl = "/comic/sub/del";
      requestQuery = {
        "comic_id": ids.join(","),
      };
    } else if (type == AppConstant.kTypeNovel) {
      requestUrl = "/novel/sub/del";
      requestQuery = {
        "novel_id": ids.join(","),
      };
    }

    await HttpClient.instance.getJson(
      requestUrl,
      queryParameters: requestQuery,
      needLogin: true,
      checkCode: true,
    );
    return true;
  }

  /// 查询订阅状态
  /// - [objId] 漫画ID或小说ID
  /// - [type] 类型，对应AppConstant
  Future<bool> checkSubscribeStatus(
      {required int objId, required int type}) async {
    var typeId = 1;
    if (type == AppConstant.kTypeComic) {
      typeId = 1;
    } else if (type == AppConstant.kTypeNovel) {
      typeId = 2;
    }

    var result = await HttpClient.instance.getJson(
      '/comic/sub/checkIsSub',
      checkCode: true,
      queryParameters: {
        "objId": objId,
        "source": typeId,
      },
      needLogin: true,
    );
    return result["isSub"];
  }

  /// 漫画阅读记录
  /// - [page] 页数从0开始，接口并没有分页
  Future<List<UserComicHistoryModel>> comicHistory({int page = 0}) async {
    var list = <UserComicHistoryModel>[];
    var result = await HttpClient.instance.getJson(
      '/api/getReInfo/comic/${UserService.instance.userId}/$page',
      queryParameters: {},
      baseUrl: Api.BASE_URL_INTERFACE,
    );
    var data = json.decode(result);
    for (var item in data) {
      list.add(UserComicHistoryModel.fromJson(item));
    }
    //远程与本地同步
    DBService.instance.syncRemoteComicHistory(list);
    return list;
  }

  /// 小说阅读记录
  /// - [page] 页数从0开始，接口并没有分页
  Future<List<UserNovelHistoryModel>> novelHistory({int page = 0}) async {
    var list = <UserNovelHistoryModel>[];
    var result = await HttpClient.instance.getJson(
      '/api/getReInfo/novel/${UserService.instance.userId}/$page',
      queryParameters: {},
      baseUrl: Api.BASE_URL_INTERFACE,
    );
    var data = json.decode(result);
    for (var item in data) {
      list.add(UserNovelHistoryModel.fromJson(item));
    }
    //远程与本地同步
    DBService.instance.syncRemoteNovelHistory(list);
    return list;
  }

  /// 上传漫画记录
  Future<bool> uploadComicHistory({
    required int comicId,
    required int chapterId,
    required int page,
    required DateTime time,
  }) async {
    var data = {
      comicId.toString(): chapterId.toString(),
      "comicId": comicId.toString(),
      "chapterId": chapterId.toString(),
      "page": page,
      "time": (time.millisecondsSinceEpoch ~/ 1000).toString()
    };
    await HttpClient.instance.getJson(
      "/api/record/getRe",
      baseUrl: Api.BASE_URL_INTERFACE,
      queryParameters: {
        "st": "comic",
        "uid": UserService.instance.userId,
        "callback": "record_jsonpCallback",
        "type": 3,
        "json": "[${json.encode(data)}]",
      },
      withDefaultParameter: true,
      checkCode: true,
    );

    return true;
  }

  /// 上传小说记录
  Future<bool> uploadNovelHistory({
    required int novelId,
    required int chapterId,
    required int volumeId,
    required int page,
    required int total,
    required DateTime time,
  }) async {
    var data = {
      novelId.toString(): chapterId.toString(),
      "lnovel_id": novelId.toString(),
      "volume_id": volumeId.toString(),
      "chapterId": chapterId.toString(),
      "total_num": total,
      "page": page,
      "time": (time.millisecondsSinceEpoch ~/ 1000).toString()
    };
    await HttpClient.instance.getJson(
      "/api/record/getRe",
      baseUrl: Api.BASE_URL_INTERFACE,
      queryParameters: {
        "st": "novel",
        "uid": UserService.instance.userId,
        "callback": "record_jsonpCallback",
        "type": 3,
        "json": "[${json.encode(data)}]",
      },
      withDefaultParameter: true,
      checkCode: true,
    );

    return true;
  }
}
