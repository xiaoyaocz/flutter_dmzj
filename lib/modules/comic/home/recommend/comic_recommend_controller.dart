import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/recommend_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ComicRecommendController extends BasePageController<ComicRecommendModel> {
  final ComicRequest request = ComicRequest();

  @override
  Future<List<ComicRecommendModel>> getData(int page, int pageSize) async {
    var ls = await request.recommend();

    ls.insert(
      ls.length > 3 ? 2 : 1,
      ComicRecommendModel(
        categoryId: 50,
        title: "随便看看",
        sort: 6,
        data: [],
      ),
    );
    loadRandom();
    return ls;
  }

  /// 加载随机漫画
  void loadRandom() async {
    try {
      var result = await request.refreshRecommend(50);
      var index = list.indexWhere((x) => x.categoryId == 50);
      if (index != -1) {
        list[index] = result;
      } else {
        list.insert(
          list.length > 3 ? 2 : 1,
          result,
        );
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 刷新国漫
  void refreshGuoman() async {
    try {
      var result = await request.refreshRecommend(52);
      var index = list.indexWhere((x) => x.categoryId == 52);
      if (index != -1) {
        list[index] = result;
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 刷新热门连载
  void refreshHot() async {
    try {
      var result = await request.refreshRecommend(54);
      var index = list.indexWhere((x) => x.categoryId == 54);
      if (index != -1) {
        list[index] = result;
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  void openDetail(ComicRecommendItemModel item) {
    //漫画=1
    if (item.type == 1) {
      AppNavigator.toComment(
        objId: item.objId ?? 0,
        type: AppConstant.kTypeComic,
      );
    } else if (item.type == 5) {
      //专题=5
      AppNavigator.toComment(
        objId: item.objId ?? 0,
        type: AppConstant.kTypeTopic,
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
    } else if (item.type == 13) {
      //社区=13
      //直接跳转至网页
      launchUrlString(
          "http://m.forum.dmzj.com/thread/detail?tid=${item.objId}");
      // AppNavigator.toWebView(
      //   "http://m.forum.dmzj.com/thread/detail?tid=${item.objId}",
      // );
    } else {
      SmartDialog.showToast("未知类型，无法跳转");
    }

    //AppNavigator.toContentPage(RoutePath.kTestSubRoute);
  }

  void toTopic() {}
}
