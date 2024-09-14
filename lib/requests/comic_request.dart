import 'dart:convert';

import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/author_model.dart';
import 'package:flutter_dmzj/models/comic/category_comic_model.dart';
import 'package:flutter_dmzj/models/comic/category_filter_model.dart';
import 'package:flutter_dmzj/models/comic/category_item_model.dart';
import 'package:flutter_dmzj/models/comic/chapter_detail_model.dart';
import 'package:flutter_dmzj/models/comic/chapter_detail_web_model.dart';
import 'package:flutter_dmzj/models/comic/chapter_info.dart';
import 'package:flutter_dmzj/models/comic/comic_related_model.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/comic/detail_model.dart';
import 'package:flutter_dmzj/models/comic/detail_v1_model.dart';
import 'package:flutter_dmzj/models/comic/rank_item_model.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/models/comic/search_item.dart';
import 'package:flutter_dmzj/models/comic/search_model.dart';
import 'package:flutter_dmzj/models/comic/special_model.dart';
import 'package:flutter_dmzj/models/comic/update_item_model.dart';
import 'package:flutter_dmzj/models/comic/view_point_model.dart';
import 'package:flutter_dmzj/models/comic/web_search_model.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';

import '../models/comic/special_detail_model.dart';

class ComicRequest {
  /// 漫画-推荐
  Future<List<ComicRecommendModel>> recommend() async {
    var list = <ComicRecommendModel>[];
    var result = await HttpClient.instance.getJson('/comic/recommend/index');

    for (var item in result) {
      list.add(ComicRecommendModel.fromJson(item));
    }
    return list;
  }

  /// 猜你喜欢
  Future<List<ComicRecommendItemModel>> refreshRecommend(int categoryId,
      {int page = 1, int size = 3}) async {
    var result = await HttpClient.instance.getJson(
      '/comic/recommend/more',
      queryParameters: {"cateId": categoryId, "size": size, "page": page},
    );
    List<ComicRecommendItemModel> list = [];

    for (var item in result["data"]["recommendList"]) {
      list.add(ComicRecommendItemModel.fromJson(item));
    }
    return list;
  }

  /// 首页-我的订阅
  Future<ComicRecommendModel> recommendSubscribe() async {
    var result = await HttpClient.instance.getJson(
      '/comic/sub/list',
      needLogin: true,
      checkCode: true,
      queryParameters: {"status": 0, "firstLetter": "", "page": 1, "size": 3},
    );

    var list = <ComicRecommendItemModel>[];
    for (var item in result["subList"]) {
      list.add(ComicRecommendItemModel.fromJson(item));
    }
    return ComicRecommendModel(
      categoryId: 49,
      title: "我的订阅",
      sort: 0,
      data: list,
    );
  }

  /// 最近更新
  Future<List<ComicUpdateItemModel>> latest(
      {required int type, int page = 1}) async {
    var result = await HttpClient.instance.getJson(
      '/comic/update/list/$type/$page',
    );
    var list = <ComicUpdateItemModel>[];
    for (var item in result["data"]) {
      list.add(ComicUpdateItemModel.fromJson(item));
    }
    return list;
  }

  /// 分类
  Future<List<ComicCategoryItemModel>> categores() async {
    var list = <ComicCategoryItemModel>[];
    var result = await HttpClient.instance.getJson(
      '/comic/filter/category',
      queryParameters: {"source": 1},
      checkCode: true,
    );
    for (var item in result["cateList"]) {
      list.add(ComicCategoryItemModel.fromJson(item));
    }
    return list;
  }

  /// 分类-筛选
  Future<List<ComicCategoryFilterModel>> categoryFilter() async {
    var result = await HttpClient.instance.getJson(
      '/comic/filter/category',
      queryParameters: {"source": 1},
      checkCode: true,
    );
    // for (var item in result["cateList"]) {
    //   list.add(ComicCategoryFilterModel.fromJson(item));
    // }
    var list = <ComicCategoryFilterItemModel>[];
    for (var item in result["cateList"]) {
      list.add(ComicCategoryFilterItemModel.fromJson(item));
    }
    return [
      ComicCategoryFilterModel(title: "全部分类", items: list),
    ];
  }

  /// 分类下漫画
  /// - [ids] 标签
  /// - [sort] 排序,0=人气,1=更新
  /// - [page] 页数，从0开始
  Future<List<ComicCategoryComicModel>> categoryComic({
    required List<int> ids,
    int sort = 1,
    int page = 1,
    int status = 0,
  }) async {
    var list = <ComicCategoryComicModel>[];
    var result = await HttpClient.instance.getJson(
      '/comic/filter/list',
      queryParameters: {
        "tagId": ids.join(","),
        "status": 0,
        "sortType": sort,
        "page": page,
        "size": 20,
      },
      checkCode: true,
    );
    for (var item in result["comicList"]) {
      list.add(ComicCategoryComicModel.fromJson(item));
    }
    return list;
  }

  /// 排行榜
  Future<List<ComicRankListItemModel>> rank({
    required int tagId,
    required byTime,
    required rankType,
    int page = 1,
  }) async {
    var result = await HttpClient.instance.getJson(
      '/comic/rank/list',
      queryParameters: {
        'tag_id': tagId,
        'by_time': byTime,
        'rank_type': rankType,
        'page': page
      },
    );
    var list = <ComicRankListItemModel>[];
    for (var item in result["data"]) {
      list.add(ComicRankListItemModel.fromJson(item));
    }
    return list;
  }

  /// 排行榜-分类
  Future<Map<int, String>> rankFilter() async {
    var result = await HttpClient.instance.getJson(
      '/comic/filter/category',
      queryParameters: {"source": 1},
      checkCode: true,
    );
    Map<int, String> map = {
      0: "全部分类",
    };
    for (var item in result["cateList"]) {
      map.addAll({
        item["tagId"]: item["title"],
      });
    }
    return map;
  }

  /// 专题
  Future<List<ComicSpecialModel>> special({int page = 1}) async {
    var list = <ComicSpecialModel>[];
    var result = await HttpClient.instance.getJson(
      '/subject/0/$page.json',
      checkCode: true,
    );
    for (var item in result) {
      list.add(ComicSpecialModel.fromJson(item));
    }
    return list;
  }

  /// 专题
  Future<ComicSpecialDetailModel> specialDetail({required int id}) async {
    var result = await HttpClient.instance.getJson(
      '/subject/$id.json',
      checkCode: true,
    );

    return ComicSpecialDetailModel.fromJson(result);
  }

  /// 作者详情
  Future<ComicAuthorModel> authorDetail({required int id}) async {
    var result = await HttpClient.instance.getJson(
      '/UCenter/author/$id.json',
    );

    return ComicAuthorModel.fromJson(result);
  }

  /// 作品相关
  Future<ComicRelatedModel> related({required int id}) async {
    var result = await HttpClient.instance.getJson(
      '/v3/comic/related/$id.json',
    );

    return ComicRelatedModel.fromJson(result);
  }

  Future<ComicDetailInfo> comicDetail(
      {required int comicId, bool priorityV1 = false}) async {
    ComicDetailInfo info;
    var errorMsg = "";
    try {
      if (priorityV1) {
        info = ComicDetailInfo.fromV1(await comicDetailV1(comicId: comicId),
            isHide: true);
      } else {
        info = ComicDetailInfo.fromV4(await comicDetailV4(comicId: comicId));
      }
    } catch (e) {
      errorMsg += "${priorityV1 ? "V1" : "V4"}：$e";
      try {
        if (priorityV1) {
          info = ComicDetailInfo.fromV4(await comicDetailV4(comicId: comicId));
        } else {
          info = ComicDetailInfo.fromV1(await comicDetailV1(comicId: comicId),
              isHide: e.toString() == "漫画不存在");
        }
      } catch (e) {
        errorMsg += "\n${priorityV1 ? "V4" : "V1"}：$e";
        throw AppError("ComicID:$comicId\n无法读取漫画信息，可能需要登录或有等级限制\n$errorMsg");
      }
    }
    return info;
  }

  /// 漫画详情
  Future<ComicDetailModel> comicDetailV4({
    required int comicId,
  }) async {
    var result = await HttpClient.instance.getJson(
      '/comic/detail/$comicId',
    );
    if (result["errno"] != 0) {
      throw AppError(result["errmsg"]);
    }
    var data = ComicDetailModel.fromJson(result["data"]);

    return data;
  }

  /// 漫画详情
  Future<ComicDetailV1Model> comicDetailV1({
    required int comicId,
  }) async {
    var result = await HttpClient.instance.getJson(
      '/dynamic/comicinfo/$comicId.json',
      baseUrl: "https://api.dmzj.com",
      needLogin: true,
    );
    var data = json.decode(result);
    if (data["result"] != 1) {
      throw AppError(data["msg"]);
    }
    if (data["data"]?["info"]?["id"] == null) {
      throw AppError("无法读取漫画信息");
    }
    return ComicDetailV1Model.fromJson(data["data"]);
  }

  /// 漫画搜索
  /// - [page] 页数从0开始
  /// - [keyword] 关键字
  Future<List<SearchComicItem>> search(
      {required String keyword, int page = 1}) async {
    var list = <ComicSearchModel>[];
    var result = await HttpClient.instance.getJson(
      '/search/index',
      queryParameters: {
        "keyword": keyword,
        "page": page,
        "size": 20,
      },
      checkCode: true,
    );
    for (var item in result["list"]) {
      list.add(ComicSearchModel.fromJson(item));
    }
    return list.map((e) => SearchComicItem.fromApi(e)).toList();
  }

  /// 漫画搜索热词
  Future<Map<int, String>> searchHotWord() async {
    var result = await HttpClient.instance.getJson(
      '/search/hot/0.json',
    );
    Map<int, String> map = {};
    for (var item in result) {
      map.addAll({
        item["id"]: item["name"],
      });
    }
    return map;
  }

  /// 章节详情
  Future<ComicChapterDetail> chapterDetail(
      {required int comicId,
      required int chapterId,
      required bool useHD}) async {
    ComicChapterDetail info;

    try {
      //查询本地是否存在
      var localInfo =
          ComicDownloadService.instance.box.get("${comicId}_$chapterId");
      if (localInfo != null && localInfo.status == DownloadStatus.complete) {
        return ComicChapterDetail.fromDownload(localInfo);
      }

      var v4 = await chapterDetailV4(comicId: comicId, chapterId: chapterId);
      info = ComicChapterDetail.fromV4(v4, useHD);
    } catch (e) {
      Log.logPrint(e);
      try {
        var v1 = await chapterDetailWeb(comicId: comicId, chapterId: chapterId);
        info = ComicChapterDetail.fromWebApi(v1);
      } catch (e) {
        Log.logPrint(e);

        throw AppError("ComicID:$comicId ChapterID:$chapterId\n无法读取章节信息");
      }
    }
    return info;
  }

  /// 章节详情-V4
  Future<ComicChapterDetailModel> chapterDetailV4(
      {required int comicId, required int chapterId}) async {
    var result =
        await HttpClient.instance.getJson('/comic/chapter/$comicId/$chapterId');
    if (result["errno"] != 0) {
      throw AppError(result["errmsg"].toString());
    }
    var data = ComicChapterDetailModel.fromJson(result["data"]["data"]);

    return data;
  }

  /// 章节详情-WebAPI
  Future<ComicChapterDetailWebModel> chapterDetailWeb(
      {required int comicId, required int chapterId}) async {
    var result = await HttpClient.instance.getJson(
      '/chapinfo/$comicId/$chapterId.html',
      baseUrl: "https://m.idmzj.com",
      needLogin: true,
    );
    if (result.toString().startsWith("{")) {
      var data = json.decode(result);
      return ComicChapterDetailWebModel.fromJson(data);
    } else {
      throw AppError(result);
    }
  }

  /// 观点、吐槽
  Future<List<ComicViewPointModel>> viewPoints(
      {required int comicId, required int chapterId}) async {
    var list = <ComicViewPointModel>[];
    var result = await HttpClient.instance.getJson(
      '/viewPoint/0/$comicId/$chapterId.json',
    );
    for (var item in result) {
      list.add(ComicViewPointModel.fromJson(item));
    }
    return list;
  }

  /// 点赞观点、吐槽
  Future<bool> likeViewPoint({required int comicId, required int id}) async {
    await HttpClient.instance.postJson(
      '/viewPoint/praise',
      checkCode: true,
      data: {
        "sub_type": comicId,
        "uid": UserService.instance.userId,
        "vote_id": id,
      },
    );
    return true;
  }

  /// 点赞观点、吐槽
  Future<bool> sendViewPoint(
      {required int comicId,
      required int chapterId,
      required String content,
      required int page}) async {
    await HttpClient.instance.postJson(
      '/viewPoint/addv2',
      checkCode: true,
      data: {
        "sub_type": comicId,
        "uid": UserService.instance.userId,
        "dmzj_token": UserService.instance.dmzjToken,
        "page": page,
        "type": 0,
        "third_type": chapterId,
        "content": content,
      },
    );
    return true;
  }

  /// 漫画搜索-Web接口
  /// - [keyword] 关键字
  Future<List<SearchComicItem>> searchWeb({required String keyword}) async {
    var list = <ComicWebSearchModel>[];
    var result = await HttpClient.instance.getText(
      'http://sacg.idmzj.com/comicsum/search.php',
      baseUrl: "",
      queryParameters: {
        "s": keyword,
      },
    );
    var data = jsonDecode(result.substring(20, result.lastIndexOf(';')));
    for (var item in data) {
      list.add(ComicWebSearchModel.fromJson(item));
    }
    return list.map((e) => SearchComicItem.fromWeb(e)).toList();
  }
}
