import 'package:flutter_dmzj/app/app_error.dart';
import 'package:flutter_dmzj/models/news/news_banner_model.dart';
import 'package:flutter_dmzj/models/news/news_tag_model.dart';
import 'package:flutter_dmzj/models/proto/news.pb.dart';
import 'package:flutter_dmzj/requests/common/http_client.dart';

class NewsRequest {
  /// 新闻分类
  Future<List<NewsTagModel>> category() async {
    var list = <NewsTagModel>[];
    var result = await HttpClient.instance.getJson(
      '/article/category.json',
    );
    for (var item in result) {
      list.add(NewsTagModel.fromJson(item));
    }
    return list;
  }

  /// 新闻Banner
  Future<List<NewsBannerModel>> banner() async {
    var list = <NewsBannerModel>[];
    var result = await HttpClient.instance.getJson(
      '/v3/article/recommend/header.json',
      checkCode: true,
    );
    for (var item in result) {
      list.add(NewsBannerModel.fromJson(item));
    }
    return list;
  }

  /// 读取新闻列表
  Future<List<NewsListInfoProto>> getNewsList(int id, int page) async {
    var result = await HttpClient.instance.getEncryptV4(
      '/news/list/$id/${id == 0 ? 2 : 3}/$page',
    );
    var response = NewsListResponseProto.fromBuffer(result);
    if (response.errno != 0) {
      throw AppError(response.errmsg);
    }
    return response.data;
  }
}
