import 'dart:async';

import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_controller.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ComicRecommendController extends BasePageController<ComicRecommendModel> {
  final ComicRequest request = ComicRequest();
  StreamSubscription<dynamic>? subLogin;
  StreamSubscription<dynamic>? subLogout;

  @override
  void onInit() {
    subLogin = UserService.loginedStream.listen((event) {
      loadSubscribe();
    });
    subLogout = UserService.logoutStream.listen((event) {
      list.removeWhere((x) => x.categoryId == 49);
    });
    super.onInit();
  }

  @override
  Future<List<ComicRecommendModel>> getData(int page, int pageSize) async {
    var ls = await request.recommend();

    // ls.insert(
    //   ls.length > 3 ? 2 : 1,
    //   ComicRecommendModel(
    //     categoryId: 50,
    //     title: "随便看看",
    //     sort: 6,
    //     data: [],
    //   ),
    // );
    //loadRandom();
    if (UserService.instance.logined.value) {
      loadSubscribe();
    }
    return ls;
  }

  // /// 加载随机漫画
  // Future<void> loadRandom() async {
  //   try {
  //     var result = await request.refreshRecommend(50);
  //     var index = list.indexWhere((x) => x.categoryId == 50);
  //     if (index != -1) {
  //       list[index].data  = result;
  //     } else {
  //       list.insert(
  //         list.length > 3 ? 2 : 1,
  //         result,
  //       );
  //     }
  //   } catch (e) {
  //     Log.logPrint(e);
  //   }
  // }

  /// 刷新国漫
  Future<void> refreshGuoman() async {
    try {
      var index = list.indexWhere((x) => x.categoryId == 111);
      var result =
          await request.refreshRecommend(111, size: 6, page: list[index].page);

      if (index != -1) {
        list[index].data = result;
        list[index].page++;
        list.refresh();
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 刷新近期必看
  Future<void> refreshRecommend() async {
    try {
      var index = list.indexWhere((x) => x.categoryId == 110);

      var result = await request.refreshRecommend(110, page: list[index].page);

      if (index != -1) {
        list[index].data = result;
        list[index].page++;
        list.refresh();
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 加载订阅
  void loadSubscribe() async {
    try {
      var result = await request.recommendSubscribe();
      var index = list.indexWhere((x) => x.categoryId == 49);
      if (index != -1) {
        list[index] = result;
      } else {
        list.insert(1, result);
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 刷新热门连载
  Future<void> refreshHot() async {
    try {
      var index = list.indexWhere((x) => x.categoryId == 112);
      var result =
          await request.refreshRecommend(112, page: list[index].page, size: 6);

      if (index != -1) {
        list[index].data = result;
        list[index].page++;
        list.refresh();
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  void openDetail(ComicRecommendItemModel item) {
    //漫画=1
    if (item.type == null || item.type == 1) {
      AppNavigator.toComicDetail(
        item.objId ?? item.id ?? 0,
      );
    } else if (item.type == 5) {
      //专题=5
      AppNavigator.toSpecialDetail(
        item.objId ?? 0,
      );
    } else if (item.type == 6) {
      //网页=6
      AppNavigator.toWebView(item.url ?? "");
    } else if (item.type == 7) {
      //新闻=7
      AppNavigator.toNewsDetail(
        url: item.url ?? "",
        newsId: item.objId ?? 0,
        title: item.title,
      );
    } else if (item.type == 8) {
      //作者=8
      AppNavigator.toComicAuthorDetail(item.objId ?? 0);
    } else if (item.type == 13) {
      //社区=13
      //直接跳转至网页
      launchUrlString(
        "http://m.forum.idmzj.com/thread/detail?tid=${item.objId}",
        mode: LaunchMode.externalApplication,
      );
      // AppNavigator.toWebView(
      //   "http://m.forum.dmzj.com/thread/detail?tid=${item.objId}",
      // );
    } else {
      SmartDialog.showToast("未知类型，无法跳转");
    }
  }

  void toSpecial() {
    var homeController = Get.find<ComicHomeController>();
    homeController.tabController.animateTo(4);
  }

  void toMySubscribe() {
    AppNavigator.toUserSubscribe();
  }

  @override
  void onClose() {
    subLogin?.cancel();
    subLogout?.cancel();
    super.onClose();
  }
}
