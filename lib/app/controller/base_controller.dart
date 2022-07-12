import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  /// 加载中，更新页面
  var pageLoadding = false;

  /// 加载中,不会更新页面
  var loadding = false;

  /// 空白页面
  var pageEmpty = false;

  /// 页面错误
  var pageError = false;

  /// 错误信息
  var errorMsg = "";

  /// 显示错误
  /// * [msg] 错误信息
  /// * [showPageError] 显示页面错误
  /// * 只在第一页加载错误时showPageError=true，后续页加载错误时使用Toast弹出通知
  void showError(String msg, {Error? err, bool showPageError = false}) {
    Log.e(msg, err?.stackTrace ?? StackTrace.current);
    if (showPageError) {
      pageError = true;
      errorMsg = msg;
    } else {
      SmartDialog.showToast(msg);
    }
  }

  String exceptionToString(Object exception) {
    return exception.toString().replaceAll("Exception:", "");
  }
}

class BaseDataController<T> extends BaseController {
  T? data;
  Future loadData() async {
    try {
      if (loadding) return;
      loadding = true;
      pageError = false;
      pageLoadding = true;
      update();
      var result = await getData();
      data = result;
    } catch (e) {
      showError(exceptionToString(e), showPageError: true);
    } finally {
      loadding = false;
      pageLoadding = false;
      update();
    }
  }

  Future<T?> getData() async {
    return null;
  }
}

class BasePageController<T> extends BaseController {
  int currentPage = 1;
  int count = 0;
  int maxPage = 0;
  int pageSize = 24;
  var canLoadMore = false.obs;
  var list = <T>[].obs;

  Future refreshData() async {
    currentPage = 1;
    list.value = [];
    await loadPageData();
  }

  Future loadPageData() async {
    try {
      if (loadding) return;
      loadding = true;
      pageLoadding = currentPage == 1;
      var result = await getPageData(currentPage, pageSize);
      //是否可以加载更多
      if (result.isNotEmpty) {
        currentPage++;
        canLoadMore.value = true;
      } else {
        canLoadMore.value = false;
      }
      // 赋值数据
      if (currentPage == 1) {
        list.value = result;
      } else {
        list.addAll(result);
      }
    } catch (e) {
      showError(exceptionToString(e), showPageError: currentPage == 1);
    } finally {
      loadding = false;
      pageLoadding = false;
    }
  }

  Future<List<T>> getPageData(int page, int pageSize) async {
    return [];
  }
}
