import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/novel/latest_model.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';

class NovelLatestController extends BasePageController<NovelLatestModel> {
  final NovelRequest request = NovelRequest();

  @override
  Future<List<NovelLatestModel>> getData(int page, int pageSize) async {
    var ls = await request.latest(page: page);

    return ls;
  }
}
