import 'dart:convert';

import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/author_model.dart';
import 'package:flutter_dmzj/models/comic/category_comic_model.dart';
import 'package:flutter_dmzj/models/comic/category_filter_model.dart';
import 'package:flutter_dmzj/models/comic/category_item_model.dart';
import 'package:flutter_dmzj/models/comic/chapter_detail_web_model.dart';
import 'package:flutter_dmzj/models/comic/chapter_info.dart';
import 'package:flutter_dmzj/models/comic/comic_related_model.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/comic/detail_v1_model.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/models/comic/search_item.dart';
import 'package:flutter_dmzj/models/comic/search_model.dart';
import 'package:flutter_dmzj/models/comic/special_model.dart';
import 'package:flutter_dmzj/models/comic/view_point_model.dart';
import 'package:flutter_dmzj/models/comic/web_search_model.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/models/proto/comic.pb.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';

import '../models/comic/special_detail_model.dart';

class ComicRequest {
  /// 漫画-推荐
  Future<List<ComicRecommendModel>> recommend() async {
    var list = <ComicRecommendModel>[];
    var result = await HttpClient.instance.getJson(
      '/recommend_new.json',
    );
    for (var item in result) {
      list.add(ComicRecommendModel.fromJson(item));
    }
    return list;
  }

  /// 猜你喜欢
  Future<ComicRecommendModel> refreshRecommend(int categoryId) async {
    var result = await HttpClient.instance.getJson(
      '/recommend/batchUpdate',
      needLogin: true,
      queryParameters: {
        "category_id": categoryId,
      },
    );
    var model = ComicRecommendModel.fromJson(result["data"]);
    for (var item in model.data) {
      if (categoryId == 50) {
        item.objId = item.id;
        item.type = 1;
      }
    }
    return model;
  }

  /// 首页-我的订阅
  Future<ComicRecommendModel> recommendSubscribe() async {
    var result = await HttpClient.instance.getJson(
      '/recommend/batchUpdate',
      needLogin: true,
      queryParameters: {
        "category_id": 49,
      },
    );
    var model = ComicRecommendModel.fromJson(result["data"]);
    for (var item in model.data) {
      item.objId = item.id;
      item.type = 1;
    }
    return model;
  }

  /// 最近更新
  Future<List<ComicUpdateListInfoProto>> latest(
      {required int type, int page = 1}) async {
    var result = await HttpClient.instance.getEncryptV4(
      '/comic/update/list/$type/$page',
      needLogin: true,
    );
    var data = ComicUpdateListResponseProto.fromBuffer(result);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 分类
  Future<List<ComicCategoryItemModel>> categores() async {
    var list = <ComicCategoryItemModel>[];
    var result = await HttpClient.instance.getJson(
      '/0/category.json',
      checkCode: true,
    );
    for (var item in result) {
      list.add(ComicCategoryItemModel.fromJson(item));
    }
    return list;
  }

  /// 分类-筛选
  Future<List<ComicCategoryFilterModel>> categoryFilter() async {
    var list = <ComicCategoryFilterModel>[];
    var result = await HttpClient.instance.getJson(
      '/classify/filter.json',
    );
    for (var item in result) {
      list.add(ComicCategoryFilterModel.fromJson(item));
    }
    return list;
  }

  /// 分类下漫画
  /// - [ids] 标签
  /// - [sort] 排序,0=人气,1=更新
  /// - [page] 页数，从0开始
  Future<List<ComicCategoryComicModel>> categoryComic({
    required List<int> ids,
    int sort = 0,
    int page = 1,
  }) async {
    var path = "classify/";
    for (var item in ids) {
      if (item != 0) {
        path += "$item-";
      }
    }
    if (path == "classify/") {
      path = "classify/0";
    } else {
      path = path.substring(0, path.length - 1);
    }

    var list = <ComicCategoryComicModel>[];
    var result = await HttpClient.instance.getJson(
      '/$path/$sort/$page.json',
    );
    for (var item in result) {
      list.add(ComicCategoryComicModel.fromJson(item));
    }
    return list;
  }

  /// 排行榜
  Future<List<ComicRankListInfoProto>> rank({
    required int tagId,
    required byTime,
    required rankType,
    int page = 1,
  }) async {
    var result = await HttpClient.instance.getEncryptV4(
      '/comic/rank/list',
      queryParameters: {
        'tag_id': tagId,
        'by_time': byTime,
        'rank_type': rankType,
        'page': page
      },
      needLogin: true,
    );
    var data = ComicRankListResponseProto.fromBuffer(result);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 排行榜-分类
  Future<Map<int, String>> rankFilter() async {
    var result = await HttpClient.instance.getJson(
      '/rank/type_filter.json',
    );
    Map<int, String> map = {};
    for (var item in result) {
      map.addAll({
        item["tag_id"]: item["tag_name"],
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
  Future<ComicDetailProto> comicDetailV4({
    required int comicId,
  }) async {
    var result = await HttpClient.instance.getEncryptV4(
      '/comic/detail/$comicId',
      needLogin: true,
    );
    var data = ComicDetailResponseProto.fromBuffer(result);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }

    return data.data;
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
      {required String keyword, int page = 0}) async {
    var list = <ComicSearchModel>[];
    var result = await HttpClient.instance.getJson(
      '/search/show/0/$keyword/$page.json',
    );
    for (var item in result) {
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
  Future<ComicChapterDetailProto> chapterDetailV4(
      {required int comicId, required int chapterId}) async {
    var result = await HttpClient.instance.getEncryptV4(
      '/comic/chapter/$comicId/$chapterId',
      needLogin: true,
    );
    var data = ComicChapterResponseProto.fromBuffer(result);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }

    return data.data;
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
