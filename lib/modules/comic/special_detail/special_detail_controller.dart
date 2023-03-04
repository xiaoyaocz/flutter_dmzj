import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/special_detail_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:get/get.dart';

class SpecialDetailController extends BaseController {
  final int id;
  SpecialDetailController(this.id);

  final ComicRequest request = ComicRequest();

  Rx<ComicSpecialDetailModel?> detail = Rx<ComicSpecialDetailModel?>(null);

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      var result = await request.specialDetail(id: id);
      detail.value = result;
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  void subscribeAll() {
    if (detail.value == null) {
      return;
    }
    //TODO 订阅全部
  }

  void share() {
    if (detail.value == null) {
      return;
    }
    Utils.share(
      "http://m.dmzj.com/zhuanti/${detail.value!.pageUrl}",
      content: detail.value?.title ?? "",
    );
  }

  void comment() {
    if (detail.value == null) {
      return;
    }
    AppNavigator.toComment(objId: id, type: AppConstant.kTypeSpecial);
  }
}
