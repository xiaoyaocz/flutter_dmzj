import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/category_comic_model.dart';
import 'package:flutter_dmzj/models/comic/category_filter_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class CategoryDetailController
    extends BasePageController<ComicCategoryComicModel> {
  final int id;
  CategoryDetailController(this.id);
  final ComicRequest request = ComicRequest();
  RxList<ComicCategoryFilterModel> filters = RxList<ComicCategoryFilterModel>();

  @override
  void onInit() {
    loadFilter();
    super.onInit();
  }

  void loadFilter() async {
    try {
      filters.value = await request.categoryFilter();
      for (var item in filters) {
        var tag = item.items.firstWhereOrNull((x) => x.tagId == id);
        if (tag != null) {
          item.selectId.value = tag.tagId;
        }
      }
      filters.insert(
        0,
        ComicCategoryFilterModel(
          title: "排序",
          items: [
            ComicCategoryFilterItemModel(tagId: 0, tagName: "人气排序"),
            ComicCategoryFilterItemModel(tagId: 1, tagName: "更新排序"),
          ],
        ),
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  @override
  Future<List<ComicCategoryComicModel>> getData(int page, int pageSize) async {
    if (filters.isEmpty) {
      return await request.categoryComic(ids: [id], page: page);
    } else {
      var sort = filters.first.selectId.value;
      var ids = filters
          .where((x) => x.title != "排序")
          .map((e) => e.selectId.value)
          .toList();
      return await request.categoryComic(ids: ids, sort: sort, page: page);
    }
  }
}
