import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/modules/comic/detail/comic_detail_related_page.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ComicDetailControler extends BaseController {
  final int comicId;
  ComicDetailControler(this.comicId);

  final ComicRequest request = ComicRequest();

  Rx<ComicDetailInfo> detail = Rx<ComicDetailInfo>(ComicDetailInfo.empty());

  var expandDescription = false.obs;

  @override
  void onInit() {
    loadDetail();
    super.onInit();
  }

  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      var result = await request.comicDetail(comicId: comicId);
      detail.value = result;
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  void comment() {
    AppNavigator.toComment(objId: comicId, type: AppConstant.kTypeComic);
  }

  void share() {
    if (detail.value.id == 0) {
      return;
    }
    Utils.share(
      "http://m.dmzj.com/info/${detail.value.comicPy}.html",
      content: detail.value.title,
    );
  }

  void subscribe() {}

  void download() {}

  void related() async {
    try {
      SmartDialog.showLoading();
      var data = await request.related(id: comicId);
      SmartDialog.dismiss(status: SmartStatus.loading);
      AppNavigator.showBottomSheet(
        ComicDetailRelatedPage(data),
        isScrollControlled: true,
      );
    } catch (e) {
      SmartDialog.showToast(e.toString());
    } finally {
      SmartDialog.dismiss(status: SmartStatus.loading);
    }
  }
}
