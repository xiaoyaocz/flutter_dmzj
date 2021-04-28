import 'package:flutter_dmzj/app/http_util.dart';
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

  String baseUrl = "https://v4api.dmzj1.com";

  /// 首页-更新
  Future<List<ComicUpdateListItemResponse>> getUpdateList(String type,
      {int page = 0}) async {
    var path = "$baseUrl/comic/update/list/$type/$page";
    var result = await HttpUtil.instance.httpGet(
      path,
      queryParameters: ApiUtil.defaultParameter(),
    );
    var resultBytes = ApiUtil.decrypt(result);

    var data = ComicUpdateListResponse.fromBuffer(resultBytes);
    if (data.errno != 0) {
      throw AppError(data.errmsg);
    }
    return data.data;
  }

  /// 首页-排行榜
  Future<List<ComicRankListItemResponse>> getRankList(
      {int tagId = 0, int byTime = 0, int rankType, int page = 0}) async {
    var path = "$baseUrl/comic/rank/list";
    var par = ApiUtil.defaultParameter(logined: true);
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
}
