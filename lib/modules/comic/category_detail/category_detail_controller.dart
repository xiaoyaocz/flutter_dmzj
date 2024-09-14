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

  String getTitle() {
    var items = filters.where((x) => x.selectId.value != 0 && x.title != "排序");

    if (items.isEmpty) {
      return "全部漫画";
    } else {
      return items
          .map((e) =>
              e.items.firstWhere((x) => x.tagId == e.selectId.value).tagName)
          .join("-");
    }
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
            ComicCategoryFilterItemModel(tagId: 1, tagName: "更新排序"),
            ComicCategoryFilterItemModel(tagId: 2, tagName: "热度排序"),
          ],
        )..selectId.value = 1,
      );
      filters.insert(
        1,
        ComicCategoryFilterModel(
          title: "状态",
          items: [
            ComicCategoryFilterItemModel(tagId: 0, tagName: "全部"),
            ComicCategoryFilterItemModel(tagId: 1, tagName: "连载中"),
            ComicCategoryFilterItemModel(tagId: 2, tagName: "已完结"),
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
      return await request.categoryComic(id: id, page: page);
    } else {
      var sort = filters.first.selectId.value;
      var status = filters[1].selectId.value;

      return await request.categoryComic(
        id: filters.last.selectId.value,
        sort: sort,
        page: page,
        status: status,
      );
    }
  }
}
