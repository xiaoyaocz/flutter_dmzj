import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/update_item_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:get/get.dart';

class ComicLatestController extends BasePageController<ComicUpdateItemModel> {
  final ComicRequest request = ComicRequest();
  Map types = {
    "全部漫画": 100,
    "原创漫画": 1,
    "译制漫画": 0,
  };
  var type = 100.obs;

  @override
  Future<List<ComicUpdateItemModel>> getData(int page, int pageSize) async {
    var ls = await request.latest(type: type.value, page: page);

    return ls;
  }
}
