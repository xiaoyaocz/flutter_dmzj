import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:flutter_dmzj/modules/comic/detail/comic_detail_related_page.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ComicDetailControler extends BaseController {
  final int comicId;
  ComicDetailControler(this.comicId);

  final ComicRequest request = ComicRequest();
  final UserRequest userRequest = UserRequest();

  Rx<ComicDetailInfo> detail = Rx<ComicDetailInfo>(ComicDetailInfo.empty());

  var expandDescription = false.obs;

  /// 是否已订阅
  var subscribeStatus = false.obs;

  @override
  void onInit() {
    // 从本地读取订阅状态
    subscribeStatus.value =
        UserService.instance.subscribedComicIds.contains(comicId);
    loadDetail();
    loadSubscribeStatus();
    super.onInit();
  }

  /// 加载信息
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

  /// 检查订阅状态
  void loadSubscribeStatus() async {
    try {
      var result = await userRequest.checkSubscribeStatus(
        objId: comicId,
        type: AppConstant.kTypeComic,
      );
      subscribeStatus.value = result;
      if (subscribeStatus.value) {
        UserService.instance.subscribedComicIds.add(comicId);
      } else {
        UserService.instance.subscribedComicIds.remove(comicId);
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 查看评论
  void comment() {
    AppNavigator.toComment(objId: comicId, type: AppConstant.kTypeComic);
  }

  /// 分享
  void share() {
    if (detail.value.id == 0) {
      return;
    }
    Utils.share(
      "http://m.dmzj.com/info/${detail.value.comicPy}.html",
      content: detail.value.title,
    );
  }

  /// 订阅
  void subscribe() async {
    var result = await (subscribeStatus.value
        ? UserService.instance
            .cancelSubscribe([comicId], AppConstant.kTypeComic)
        : UserService.instance.addSubscribe([comicId], AppConstant.kTypeComic));
    if (result) {
      subscribeStatus.value = !subscribeStatus.value;
    }
  }

  /// 下载
  void download() {}

  /// 开始/继续阅读
  void read() {
    if (detail.value.volumes.isEmpty) {
      SmartDialog.showToast("没有可阅读的章节");
      return;
    }
    if (detail.value.volumes.first.chapters.isEmpty) {
      SmartDialog.showToast("没有可阅读的章节");
      return;
    }
    //查找记录
    var history = DBService.instance.getComicHistory(comicId);
    if (history != null) {
    } else {
      //从头开始
      var volume = detail.value.volumes.first;
      var chapters = List<ComicDetailChapterItem>.from(volume.chapters);
      //正序
      chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
      var chapter = chapters.first;
      AppNavigator.toComicReader(
        comicId: comicId,
        comicTitle: detail.value.title,
        chapters: chapters,
        chapter: chapter,
      );
      // DBService.instance.addComicHistory(
      //   ComicHistory(
      //     comicId: comicId,
      //     chapterId: chapter.chapterId,
      //     comicName: detail.value.title,
      //     comicCover: detail.value.cover,
      //     chapterName: chapter.chapterTitle,
      //     updateTime: DateTime.now(),
      //     page: 0,
      //   ),
      // );
    }
  }

  void readChapter(ComicDetailVolume volume, ComicDetailChapterItem item) {
    var chapters = List<ComicDetailChapterItem>.from(volume.chapters);
    //正序
    chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
    AppNavigator.toComicReader(
      comicId: comicId,
      comicTitle: detail.value.title,
      chapters: chapters,
      chapter: item,
    );
  }

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

  void toAuthorDetail(ComicDetailTag e) {
    if (e.tagId == 0) {
      //神隐漫画没有ID，直接跳转搜索
      AppNavigator.toComicSearch(keyword: e.tagName);
    } else {
      AppNavigator.toComicAuthorDetail(e.tagId);
    }
  }

  void toCategoryDetail(ComicDetailTag e) {
    if (e.tagId == 0) {
      //神隐漫画没有ID，直接跳转搜索
      AppNavigator.toComicSearch(keyword: e.tagName);
    } else {
      AppNavigator.toComicCategoryDetail(e.tagId);
    }
  }
}
