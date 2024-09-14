import 'package:dio/dio.dart';
import 'package:flutter_dmzj/models/novel/category_filter_model.dart';
import 'package:flutter_dmzj/models/novel/category_model.dart';
import 'package:flutter_dmzj/models/novel/category_novel_model.dart';
import 'package:flutter_dmzj/models/novel/detail_model.dart';
import 'package:flutter_dmzj/models/novel/latest_model.dart';
import 'package:flutter_dmzj/models/novel/rank_model.dart';
import 'package:flutter_dmzj/models/novel/recommend_model.dart';
import 'package:flutter_dmzj/models/novel/search_model.dart';
import 'package:flutter_dmzj/models/novel/volume_detail_model.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';

class NovelRequest {
  /// 轻小说-推荐
  Future<List<NovelRecommendModel>> recommend() async {
    var list = <NovelRecommendModel>[];
    var result =
        await HttpClient.instance.getJson('/novel/recommend', checkCode: true);
    for (var item in result["recommendList"]) {
      list.add(NovelRecommendModel.fromJson(item));
    }
    return list;
  }

  /// 轻小说-更新
  /// - [page] 页数从0开始
  Future<List<NovelLatestModel>> latest({int page = 1}) async {
    var list = <NovelLatestModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/filter/list',
      queryParameters: {
        //status=0&sortType=1&page=1&size=20&tagId=0
        "status": 0,
        "sortType": 1,
        "page": page,
        "size": 20,
      },
      checkCode: true,
    );
    for (var item in result["novelList"]) {
      list.add(NovelLatestModel.fromJson(item));
    }
    return list;
  }

  /// 轻小说-分类
  Future<List<NovelCategoryModel>> categores() async {
    var list = <NovelCategoryModel>[];
    var result = await HttpClient.instance.getJson(
      '/comic/filter/category',
      queryParameters: {
        "source": 2,
      },
      checkCode: true,
    );
    for (var item in result["cateList"]) {
      list.add(NovelCategoryModel.fromJson(item));
    }
    return list;
  }

  /// 分类-筛选
  Future<List<NovelCategoryFilterModel>> categoryFilter() async {
    var result = await HttpClient.instance.getJson(
      '/comic/filter/category',
      queryParameters: {"source": 2},
      checkCode: true,
    );
    var list = <NovelCategoryFilterItemModel>[];
    for (var item in result["cateList"]) {
      list.add(NovelCategoryFilterItemModel.fromJson(item));
    }
    return [
      NovelCategoryFilterModel(title: "题材", items: list),
    ];
  }

  /// 分类下漫画
  /// - [cateId] 分类
  /// - [sort] 排序,0=人气,1=更新
  /// - [page] 页数，从0开始
  Future<List<NovelCategoryNovelModel>> categoryNovel({
    int cateId = 0,
    int status = 0,
    int sort = 0,
    int page = 1,
  }) async {
    var list = <NovelCategoryNovelModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/filter/list',
      queryParameters: {
        "tagId": cateId,
        "status": 0,
        "sortType": sort,
        "page": page,
        "size": 20,
      },
      checkCode: true,
    );
    for (var item in result["novelList"]) {
      list.add(NovelCategoryNovelModel.fromJson(item));
    }
    return list;
  }

  /// 排行榜
  Future<List<NovelRankModel>> rank({
    required int tagId,
    required sort,
    int page = 0,
  }) async {
    var list = <NovelRankModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/rank/$sort/$tagId/$page.json',
    );
    for (var item in result) {
      list.add(NovelRankModel.fromJson(item));
    }
    return list;
  }

  /// 排行榜-分类
  Future<Map<int, String>> rankFilter() async {
    var result = await HttpClient.instance.getJson(
      '/comic/filter/category',
      queryParameters: {
        "source": 2,
      },
      checkCode: true,
    );
    Map<int, String> map = {};
    for (var item in result["cateList"]) {
      map.addAll({
        item["tagId"]: item["title"],
      });
    }
    return map;
  }

  /// 轻小说搜索
  /// - [page] 页数从0开始
  /// - [keyword] 关键字
  Future<List<NovelSearchModel>> search(
      {required String keyword, int page = 1}) async {
    var list = <NovelSearchModel>[];
    var result = await HttpClient.instance.getJson(
      '/search/index',
      queryParameters: {
        "keyword": keyword,
        "page": page,
        "size": 20,
        "source": 1,
      },
      checkCode: true,
    );
    for (var item in result["list"]) {
      list.add(NovelSearchModel.fromJson(item));
    }
    return list;
  }

  /// 小说搜索热词
  Future<Map<int, String>> searchHotWord() async {
    var result = await HttpClient.instance.getJson(
      '/search/hot/1.json',
    );
    Map<int, String> map = {};
    for (var item in result) {
      map.addAll({
        item["id"]: item["name"],
      });
    }
    return map;
  }

  /// 小说详情
  Future<NovelDetailModel> novelDetail({
    required int novelId,
  }) async {
    var result = await HttpClient.instance.getJson(
      '/novel/detail/$novelId',
      needLogin: true,
      checkCode: true,
    );
    var data = NovelDetailModel.fromJson(result);

    return data;
  }

  /// 小说章节
  Future<List<NovelVolumeDetailModel>> novelChapter({
    required int novelId,
  }) async {
    var result = await HttpClient.instance.getJson(
      '/novel/chapter/$novelId',
      needLogin: true,
      checkCode: true,
    );
    var list = <NovelVolumeDetailModel>[];
    for (var item in result["data"]) {
      list.add(NovelVolumeDetailModel.fromJson(item));
    }
    return list;
  }

  /// 小说正文内容
  /// - [volumeId] 卷ID
  /// - [chapterId] 章节ID
  /// - [cancel] 取消Token
  /// - [cache] 是否缓存
  Future<String> novelContent({
    required int volumeId,
    required int chapterId,
    CancelToken? cancel,
    bool cache = true,
  }) async {
    var localContent = await LocalStorageService.instance
        .getNovelContent(volumeId: volumeId, chapterId: chapterId);
    if (localContent != null) {
      return localContent;
    }
    var result = await HttpClient.instance.getText(
      Api.getNovelContentUrl(volumeId: volumeId, chapterId: chapterId),
      baseUrl: "",
      withDefaultParameter: false,
      cancel: cancel,
    );
    if (cache) {
      await LocalStorageService.instance.saveNovelContent(
        volumeId: volumeId,
        chapterId: chapterId,
        content: result,
      );
    }

    return result;
  }
}
