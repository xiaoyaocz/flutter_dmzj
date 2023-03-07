import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:flutter_dmzj/services/db_service.dart';

class LocalComicHistoryController extends BasePageController<ComicHistory> {
  final UserRequest request = UserRequest();

  @override
  Future<List<ComicHistory>> getData(int page, int pageSize) async {
    if (page > 1) {
      return [];
    }

    return DBService.instance.getComicHistoryList();
  }
}
