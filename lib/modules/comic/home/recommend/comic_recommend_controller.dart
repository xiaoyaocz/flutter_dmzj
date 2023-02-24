import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/requests/comic.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/routes/route_path.dart';

class ComicRecommendController extends BasePageController<ComicRecommendModel> {
  @override
  void onInit() {
    //refreshData();
    super.onInit();
  }

  @override
  Future<List<ComicRecommendModel>> getData(int page, int pageSize) async {
    return await ComicRequest.recommend();
  }

  void openDetail(ComicRecommendItemModel item) {
    AppNavigator.toContentPage(RoutePath.kTestSubRoute);
  }
}
