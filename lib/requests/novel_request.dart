import 'package:flutter_dmzj/models/novel/search_model.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';

class NovelRequest {
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
}
