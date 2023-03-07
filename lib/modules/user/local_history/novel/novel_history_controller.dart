import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/db/novel_history.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:flutter_dmzj/services/db_service.dart';

class LocalNovelHistoryController extends BasePageController<NovelHistory> {
  final UserRequest request = UserRequest();

  @override
  Future<List<NovelHistory>> getData(int page, int pageSize) async {
    if (page > 1) {
      return [];
    }

    return DBService.instance.getNovelHistoryList();
  }
}
