import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/novel/category_filter_model.dart';
import 'package:flutter_dmzj/models/novel/category_novel_model.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class NovelCategoryDetailController
    extends BasePageController<NovelCategoryNovelModel> {
  final int id;
  NovelCategoryDetailController(this.id);
  final NovelRequest request = NovelRequest();
  RxList<NovelCategoryFilterModel> filters = RxList<NovelCategoryFilterModel>();

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
        NovelCategoryFilterModel(
          title: "排序",
          items: [
            NovelCategoryFilterItemModel(tagId: 0, tagName: "人气排序"),
            NovelCategoryFilterItemModel(tagId: 1, tagName: "更新排序"),
          ],
        ),
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  @override
  Future<List<NovelCategoryNovelModel>> getData(int page, int pageSize) async {
    if (filters.isEmpty) {
      return await request.categoryNovel(cateId: id, page: page);
    } else {
      var sort = filters.first.selectId.value;
      var cateId =
          filters.firstWhereOrNull((x) => x.title == "题材")?.selectId.value ?? 0;
      var status =
          filters.firstWhereOrNull((x) => x.title == "连载进度")?.selectId.value ??
              0;

      return await request.categoryNovel(
          cateId: cateId, status: status, sort: sort, page: page);
    }
  }
}
