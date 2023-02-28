import 'package:flutter_dmzj/models/comic/recommend_model.dart';
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
  Future<ComicRecommendModel?> recommendLike() async {
    var result = await HttpClient.instance.getJson(
      '/recommend/batchUpdate',
      needLogin: true,
      queryParameters: {
        "category_id": "50",
      },
    );
    return ComicRecommendModel.fromJson(result["data"]);
  }
}
