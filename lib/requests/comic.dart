import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/requests/http_client.dart';

class ComicRequest {
  /// 漫画-推荐
  static Future<List<ComicRecommendModel>> recommend() async {
    var list = <ComicRecommendModel>[];
    var result = await HttpClient.instance.getJson(
      '/recommend_new.json',
    );
    for (var item in result) {
      list.add(ComicRecommendModel.fromJson(item));
    }
    return list;
  }
}
