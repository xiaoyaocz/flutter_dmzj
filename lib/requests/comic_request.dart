import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/models/proto/comic.pb.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';

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

  // TODO 我的订阅

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
}
