import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/category_item_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';

class ComicCategoryController
    extends BasePageController<ComicCategoryItemModel> {
  final ComicRequest request = ComicRequest();

  @override
  Future<List<ComicCategoryItemModel>> getData(int page, int pageSize) async {
    if (page > 1) {
      return [];
    }
    var ls = await request.categores();

    return ls;
  }

  void toDetail(ComicCategoryItemModel item) {
    AppNavigator.toComicCategoryDetail(item.tagId);
  }
}
