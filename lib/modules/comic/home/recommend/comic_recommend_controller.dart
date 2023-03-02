import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/routes/route_path.dart';

class ComicRecommendController extends BasePageController<ComicRecommendModel> {
  final ComicRequest request = ComicRequest();
  @override
  void onInit() {
    //refreshData();
    super.onInit();
  }

  @override
  Future<List<ComicRecommendModel>> getData(int page, int pageSize) async {
    return await request.recommend();
  }

  void openDetail(ComicRecommendItemModel item) {
    AppNavigator.toComment(
        objId: item.objId ?? 0, type: AppConstant.kTypeComic);
    //AppNavigator.toContentPage(RoutePath.kTestSubRoute);
  }
}
