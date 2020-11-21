import 'dart:convert';

import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/models/comic/comic_history_item.dart';
import 'package:flutter_dmzj/sql/comic_history.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserHelper {
  static Future<bool> comicSubscribe(int comicId, {bool cancel = false}) async {
    try {
      //TODO 跳转登录
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        Fluttertoast.showToast(msg: '没有登录');
        return false;
      }
      var uid = ConfigHelper.getUserInfo()?.uid ?? "";
      var result = "";
      if (cancel) {
        var response = await http.get(Api.cancelComicSubscribe(comicId, uid));
        result = response.body;
      } else {
        var response = await http.post(Api.addComicSubscribe,
            body: {"obj_ids": comicId.toString(), "uid": uid, "type": "mh"});
        result = response.body;
      }
      var jsonMap = jsonDecode(result);
      if (jsonMap["code"] == 0) {
        Fluttertoast.showToast(msg: cancel ? "已取消订阅" : "订阅成功");
        return true;
      } else {
        Fluttertoast.showToast(msg: cancel ? "取消订阅失败" : "订阅失败");
        return false;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: cancel ? "取消订阅出现错误" : "订阅出现错误");
      return false;
    }
  }

  static Future<bool> novelSubscribe(int novelId, {bool cancel = false}) async {
    try {
      //TODO 跳转登录
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        Fluttertoast.showToast(msg: '没有登录');
        return false;
      }
      var uid = ConfigHelper.getUserInfo()?.uid ?? "";
      var result = "";
      if (cancel) {
        var response = await http.get(Api.cancelNovelSubscribe(novelId, uid));
        result = response.body;
      } else {
        var response = await http.post(Api.addNovelSubscribe,
            body: {"obj_ids": novelId.toString(), "uid": uid, "type": "xs"});
        result = response.body;
      }
      var jsonMap = jsonDecode(result);
      if (jsonMap["code"] == 0) {
        Fluttertoast.showToast(msg: cancel ? "已取消订阅" : "订阅成功");
        return true;
      } else {
        Fluttertoast.showToast(msg: cancel ? "取消订阅失败" : "订阅失败");
        return false;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: cancel ? "取消订阅出现错误" : "订阅出现错误");
      return false;
    }
  }

  static Future<bool> comicAddViewPoint(
      int comicId, int chapterId, String content,
      {int page = 0}) async {
    try {
      //TODO 跳转登录
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        Fluttertoast.showToast(msg: '没有登录');
        return false;
      }
      var uid = ConfigHelper.getUserInfo()?.uid ?? "";
      var response = await http.post(Api.comicAddViewPoint(), body: {
        "uid": uid.toString(),
        "sub_type": comicId.toString(),
        "page": page.toString(),
        "type": "0",
        "content": content,
        "third_type": chapterId.toString(),
      });
      var jsonMap = jsonDecode(response.body);

      if (jsonMap["code"] == 0) {
        Fluttertoast.showToast(msg: "发表成功");
        return true;
      } else {
        Fluttertoast.showToast(msg: "发表失败");
        return false;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "发表出现错误");
      return false;
    }
  }

  static Future<bool> comicLikeViewPoint(int id) async {
    try {
      // if (!ConfigHelper.getUserIsLogined() ?? false) {
      //   Fluttertoast.showToast(msg: '没有登录');
      //   return false;
      // }

      var response = await http.post(Api.comicLikeViewPoint(),
          body: {"sub_type": "100", "vote_id": id.toString()});
      var jsonMap = jsonDecode(response.body);

      if (jsonMap["code"] == 0) {
        Fluttertoast.showToast(msg: "点赞成功");
        return true;
      } else {
        Fluttertoast.showToast(msg: "点赞失败");
        return false;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "点赞出现错误");
      return false;
    }
  }

  static Future<bool> comicAddComicHistory(int comicId, int chapterId,
      {int page = 1}) async {
    try {
      //TODO 跳转登录
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        return false;
      }
      var uid = ConfigHelper.getUserInfo()?.uid ?? "";
      var response = await http
          .get(Api.addUserComicHistory(comicId, chapterId, uid, page: page));
      var jsonMap = jsonDecode(response.body);
      if (jsonMap["code"] == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> comicAddNovelHistory(
      int novelId, int volumeId, int chapterId,
      {int page = 1}) async {
    try {
      //TODO 跳转登录
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        return false;
      }
      var uid = ConfigHelper.getUserInfo()?.uid ?? "";
      var response = await http.get(Api.addUserNovelHistory(
          novelId, volumeId, chapterId, uid,
          page: page));
      var jsonMap = jsonDecode(response.body);
      if (jsonMap["code"] == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> newsCheckSub(int newsId) async {
    try {
      //TODO 跳转登录
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        return false;
      }
      var uid = ConfigHelper.getUserInfo()?.uid ?? "";
      var par = {"uid": int.parse(uid), "sub_id": newsId};
      var parJson = jsonEncode(par);
      var sign = Api.sign(parJson, 'app_news_sub');
      var response = await http
          .post(Api.checkNewsSub(), body: {"parm": parJson, "sign": sign});
      var jsonMap = jsonDecode(response.body);

      if (jsonMap["msg"] == "您已订阅过") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> addOrCancelNewsSub(int newsId, bool cancel) async {
    try {
      //TODO 跳转登录
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        Fluttertoast.showToast(msg: '没有登录');
        return false;
      }
      var uid = ConfigHelper.getUserInfo()?.uid ?? "";
      var par = {"uid": int.parse(uid), "sub_id": newsId};
      var parJson = jsonEncode(par);
      var sign = Api.sign(parJson, 'app_news_sub');
      var response = await http.post(
          cancel ? Api.cancelNewsSub() : Api.addNewsSub(),
          body: {"parm": parJson, "sign": sign});
      var jsonMap = jsonDecode(response.body);

      if (jsonMap["result"] == 1000) {
        return true;
      } else {
        Fluttertoast.showToast(msg: '操作失败');
        return false;
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: '发送操作出现错误');
      return false;
    }
  }

  static Future<bool> loadComicHistory() async {
    try {
      if (!ConfigHelper.getUserIsLogined() ?? false) {
        return false;
      }
      var response =
          await http.get(Api.userComicHistory(ConfigHelper.getUserInfo().uid));
      List jsonMap = jsonDecode(response.body);
      List<ComicHistoryItem> detail =
          jsonMap.map((i) => ComicHistoryItem.fromJson(i)).toList();
      if (detail != null) {
        for (var item in detail) {
          var historyItem = await ComicHistoryHelper.getItem(item.comic_id);
          if (historyItem != null) {
            historyItem.chapter_id = item.chapter_id;
            historyItem.page = item.progress?.toDouble() ?? 1;
            await ComicHistoryHelper.update(historyItem);
          } else {
            await ComicHistoryHelper.insert(ComicHistory(item.comic_id,
                item.chapter_id, item.progress?.toDouble() ?? 1, 1));
          }
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
