import 'package:flutter_dmzj/app/http_util.dart';
import 'package:flutter_dmzj/protobuf/comic/chapter_info_response.pb.dart';
import 'package:flutter_dmzj/protobuf/comic/detail_response.pb.dart';
import 'package:flutter_dmzj/protobuf/comic/rank_list_response.pb.dart';
import 'package:flutter_dmzj/protobuf/comic/update_list_response.pb.dart';

import 'api_util.dart';

class ComicApi {
  static ComicApi _comicApi;
  static ComicApi get instance {
    if (_comicApi == null) {
      _comicApi = ComicApi();
    }
    return _comicApi;
  }

  /// 首页-更新
  Future<List<ComicUpdateListItemResponse>> getUpdateList(String type,
      {int page = 1}) async {
    var path = "${ApiUtil.BASE_URL_V4}/comic/update/list/$type/$page";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicUpdateListResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 漫画详情
  Future<ComicDetailInfoResponse> getDetail(int comicId) async {
    var path = "${ApiUtil.BASE_URL_V4}/comic/detail/$comicId";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicDetailResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg, code: data.errno);
    }
    return data.data;
  }

  /// 首页-排行榜
  Future<List<ComicRankListItemResponse>> getRankList(
      {int tagId = 0, int byTime = 0, int rankType, int page = 0}) async {
    var path = "${ApiUtil.BASE_URL_V4}/comic/rank/list";
    var par = ApiUtil.defaultParameter(needLogined: true);
    par.addAll({
      'tag_id': tagId,
      'by_time': byTime,
      'rank_type': rankType,
      'page': page
    });
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: par,
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicRankListResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 章节详情
  Future<ComicChapterInfoDetailResponse> getChapterInfo(
      int comicId, int chapterId) async {
    var path = "${ApiUtil.BASE_URL_V4}/comic/chapter/$comicId/$chapterId";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(needLogined: true),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicChapterInfoResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg, code: data.errno);
    }
    return data.data;
  }
}
