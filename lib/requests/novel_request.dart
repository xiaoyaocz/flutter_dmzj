import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/novel/category_filter_model.dart';
import 'package:flutter_dmzj/models/novel/category_model.dart';
import 'package:flutter_dmzj/models/novel/category_novel_model.dart';
import 'package:flutter_dmzj/models/novel/latest_model.dart';
import 'package:flutter_dmzj/models/novel/rank_model.dart';
import 'package:flutter_dmzj/models/novel/recommend_model.dart';
import 'package:flutter_dmzj/models/novel/search_model.dart';
import 'package:flutter_dmzj/models/proto/novel.pb.dart';
import 'package:flutter_dmzj/requests/common/api.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/local_storage_service.dart';

class NovelRequest {
  /// 轻小说-推荐
  Future<List<NovelRecommendModel>> recommend() async {
    var list = <NovelRecommendModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/recommend.json',
    );
    for (var item in result) {
      list.add(NovelRecommendModel.fromJson(item));
    }
    return list;
  }

  /// 轻小说-更新
  /// - [page] 页数从0开始
  Future<List<NovelLatestModel>> latest({int page = 0}) async {
    var list = <NovelLatestModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/recentUpdate/$page.json',
    );
    for (var item in result) {
      list.add(NovelLatestModel.fromJson(item));
    }
    return list;
  }

  /// 轻小说-分类
  Future<List<NovelCategoryModel>> categores() async {
    var list = <NovelCategoryModel>[];
    var result = await HttpClient.instance.getJson(
      '/1/category.json',
    );
    for (var item in result) {
      list.add(NovelCategoryModel.fromJson(item));
    }
    return list;
  }

  /// 分类-筛选
  Future<List<NovelCategoryFilterModel>> categoryFilter() async {
    var list = <NovelCategoryFilterModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/filter.json',
    );
    for (var item in result) {
      list.add(NovelCategoryFilterModel.fromJson(item));
    }
    return list;
  }

  /// 分类下漫画
  /// - [cateId] 分类
  /// - [sort] 排序,0=人气,1=更新
  /// - [page] 页数
  Future<List<NovelCategoryNovelModel>> categoryNovel({
    int cateId = 0,
    int status = 0,
    int sort = 0,
    int page = 1,
  }) async {
    var list = <NovelCategoryNovelModel>[];
    var result = await HttpClient.instance.getJson(
      '/novel/$cateId/$status/$sort/$page.json',
    );
    for (var item in result) {
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
      '/novel/tag.json',
    );
    Map<int, String> map = {};
    for (var item in result) {
      map.addAll({
        item["tag_id"]: item["tag_name"],
      });
    }
    return map;
  }

  /// 轻小说搜索
  /// - [page] 页数从0开始
  /// - [keyword] 关键字
  Future<List<NovelSearchModel>> search(
      {required String keyword, int page = 0}) async {
    var list = <NovelSearchModel>[];
    var result = await HttpClient.instance.getJson(
      '/search/show/1/$keyword/$page.json',
    );
    for (var item in result) {
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
  Future<NovelDetailProto> novelDetailV4({
    required int novelId,
  }) async {
    var result = await HttpClient.instance.getEncryptV4(
      '/novel/detail/$novelId',
      needLogin: true,
    );
    var data = NovelDetailResponseProto.fromBuffer(result);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }

    return data.data;
  }

  /// 小说章节
  Future<List<NovelVolumeDetailProto>> novelChapterV4({
    required int novelId,
  }) async {
    var result = await HttpClient.instance.getEncryptV4(
      '/novel/chapter/$novelId',
      needLogin: true,
    );
    var data = NovelChapterResponseProto.fromBuffer(result);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }

    return data.data;
  }

  /// 小说正文内容
  Future<String> novelContent(
      {required int volumeId, required int chapterId}) async {
    var localContent = await LocalStorageService.instance
        .getNovelContent(volumeId: volumeId, chapterId: chapterId);
    if (localContent != null) {
      return localContent;
    }
    var result = await HttpClient.instance.getText(
      Api.getNovelContentUrl(volumeId: volumeId, chapterId: chapterId),
      baseUrl: "",
      withDefaultParameter: false,
    );
    await LocalStorageService.instance.saveNovelContent(
      volumeId: volumeId,
      chapterId: chapterId,
      content: result,
    );
    return result;
  }
}
