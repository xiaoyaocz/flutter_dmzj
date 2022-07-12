import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/requests/comic.dart';

class ComicRecommendController
    extends BaseDataController<List<ComicRecommendModel>> {
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  Future<List<ComicRecommendModel>> getData() async {
    return await ComicRequest.recommend();
  }
}
