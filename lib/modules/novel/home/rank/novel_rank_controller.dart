import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/novel/rank_model.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class NovelRankController extends BasePageController<NovelRankModel> {
  final NovelRequest request = NovelRequest();
  RxMap<int, String> tags = {
    0: "全部分类",
  }.obs;
  var tag = 0.obs;

  Map<int, String> rankTypes = {
    0: "人气排行",
    1: "订阅排行",
  };
  var rankType = 0.obs;

  @override
  void onInit() {
    loadFilter();
    super.onInit();
  }

  void loadFilter() async {
    try {
      tags.value = await request.rankFilter();
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  @override
  Future<List<NovelRankModel>> getData(int page, int pageSize) async {
    var ls = await request.rank(
      tagId: tag.value,
      sort: rankType.value,
      page: page - 1,
    );

    return ls;
  }
}
