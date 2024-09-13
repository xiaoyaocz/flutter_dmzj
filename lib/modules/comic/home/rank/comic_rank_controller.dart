import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/rank_item_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ComicRankController extends BasePageController<ComicRankListItemModel> {
  final ComicRequest request = ComicRequest();
  RxMap<int, String> tags = {
    0: "全部分类",
  }.obs;
  var tag = 0.obs;

  Map<int, String> byTimes = {
    0: "日排行",
    1: "周排行",
    2: "月排行",
    3: "总排行",
  };
  var byTime = 3.obs;

  Map<int, String> rankTypes = {
    0: "人气排行",
    1: "吐槽排行",
    2: "订阅排行",
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
  Future<List<ComicRankListItemModel>> getData(int page, int pageSize) async {
    var ls = await request.rank(
      tagId: tag.value,
      byTime: byTime.value,
      rankType: rankType.value,
      page: page,
    );

    return ls;
  }
}
