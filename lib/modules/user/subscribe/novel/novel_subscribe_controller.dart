import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/user/subscribe_novel_model.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:get/get.dart';

class NovelSubscribeController
    extends BasePageController<UserSubscribeNovelModel> {
  NovelSubscribeController() {
    for (var item in List.generate(
        26, (index) => String.fromCharCode(index + 65).toLowerCase())) {
      letters.addAll({item: "${item.toUpperCase()}开头"});
    }
  }
  final UserRequest request = UserRequest();

  var letter = "all".obs;

  Map letters = {
    "all": "全部",
    "number": "数字开头",
  };

  Map<int, String> types = {
    1: "全部订阅",
    2: "未读",
    3: "已读",
    4: "完结",
  };
  var type = 1.obs;

  @override
  Future<List<UserSubscribeNovelModel>> getData(int page, int pageSize) async {
    return await request.novelSubscribes(
      subType: type.value,
      letter: letter.value,
      page: page - 1,
    );
  }
}
