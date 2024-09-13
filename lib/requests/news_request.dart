import 'dart:convert';

import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/news/news_banner_model.dart';
import 'package:flutter_dmzj/models/news/news_list_item_model.dart';
import 'package:flutter_dmzj/models/news/news_stat_model.dart';
import 'package:flutter_dmzj/models/news/news_tag_model.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/user_service.dart';

class NewsRequest {
  /// 新闻分类
  Future<List<NewsTagModel>> category() async {
    var list = <NewsTagModel>[];
    var result = await HttpClient.instance.getJson(
      '/news/category',
    );
    for (var item in result["data"]["cateList"]) {
      list.add(NewsTagModel.fromJson(item));
    }
    return list;
  }

  /// 新闻Banner
  Future<List<NewsBannerModel>> banner() async {
    var list = <NewsBannerModel>[];
    var result = await HttpClient.instance.getJson('/news/recommend');
    for (var item in result["data"]["recommendList"]) {
      list.add(NewsBannerModel.fromJson(item));
    }
    return list;
  }

  /// 读取新闻列表
  /// - [id] 新闻分类ID
  /// - [page] 页数，从1开始
  Future<List<NewsListItemModel>> getNewsList(int id, int page) async {
    var result = await HttpClient.instance.getJson(
      '/news/list/$id/${id == 0 ? 2 : 3}/$page',
    );

    if (result["errno"] != 0) {
      throw AppError(result["errmsg"]);
    }
    var list = <NewsListItemModel>[];
    for (var item in result["data"]["newsList"]) {
      list.add(NewsListItemModel.fromJson(item));
    }
    return list;
  }

  /// 新闻数据
  /// - [newsId] 新闻ID
  Future<NewsStatModel> stat(int newsId) async {
    var result = await HttpClient.instance.getJson(
      '/v3/article/total/$newsId.json',
      checkCode: true,
    );

    return NewsStatModel.fromJson(result);
  }

  /// 新闻点赞
  /// - [newsId] 新闻ID
  Future<bool> like(int newsId) async {
    await HttpClient.instance.getJson(
      '/article/mood/$newsId',
      checkCode: true,
    );

    return true;
  }

  /// 新闻检查收藏
  /// - [newsId] 新闻ID
  Future<bool> checkCollect(int newsId) async {
    var uid = UserService.instance.userId;
    var par = {"uid": int.parse(uid), "sub_id": newsId};
    var parJson = jsonEncode(par);
    var sign = Api.sign(parJson, 'app_news_sub');

    var result = await HttpClient.instance.postJson(
      '/api/news/subscribe/check',
      baseUrl: Api.BASE_URL_INTERFACE,
      data: {
        "parm": parJson,
        "sign": sign,
      },
    );

    return json.decode(result)["result"] == 809;
  }

  /// 新闻收藏
  /// - [newsId] 新闻ID
  Future<bool> collect(int newsId) async {
    var uid = UserService.instance.userId;
    var par = {"uid": int.parse(uid), "sub_id": newsId};
    var parJson = jsonEncode(par);
    var sign = Api.sign(parJson, 'app_news_sub');

    var result = await HttpClient.instance.postJson(
      '/api/news/subscribe/add',
      baseUrl: Api.BASE_URL_INTERFACE,
      data: {
        "parm": parJson,
        "sign": sign,
      },
    );

    return json.decode(result)["result"] == 1000;
  }

  /// 移除收藏
  /// - [newsId] 新闻ID
  Future<bool> delCollect(int newsId) async {
    var uid = UserService.instance.userId;
    var par = {"uid": int.parse(uid), "sub_id": newsId};
    var parJson = jsonEncode(par);
    var sign = Api.sign(parJson, 'app_news_sub');

    var result = await HttpClient.instance.postJson(
      '/api/news/subscribe/del',
      baseUrl: Api.BASE_URL_INTERFACE,
      data: {
        "parm": parJson,
        "sign": sign,
      },
    );

    return json.decode(result)["result"] == 1000;
  }
}
