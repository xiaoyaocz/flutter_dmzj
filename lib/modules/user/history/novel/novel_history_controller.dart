import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/user/novel_history_model.dart';
import 'package:flutter_dmzj/requests/user_request.dart';

class NovelHistoryController extends BasePageController<UserNovelHistoryModel> {
  final UserRequest request = UserRequest();

  @override
  Future<List<UserNovelHistoryModel>> getData(int page, int pageSize) async {
    if (page > 1) {
      return [];
    }
    return await request.novelHistory();
  }
}
