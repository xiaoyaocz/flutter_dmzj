import 'dart:async';

import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:flutter_dmzj/modules/comic/detail/comic_detail_related_page.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/app_settings_service.dart';
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

  /// 是否已收藏
  /// 收藏是收藏到本地的，订阅是同步到动漫之家服务器的
  var favorited = false.obs;

  /// 阅读记录
  Rx<ComicHistory?> history = Rx<ComicHistory?>(null);

  /// 更新漫画记录
  StreamSubscription<dynamic>? updateComicSubscription;

  @override
  void onInit() {
    updateComicSubscription = EventBus.instance.listen(
      EventBus.kUpdatedComicHistory,
      (id) {
        if (id == comicId) {
          getHistory();
        }
      },
    );
    favorited.value = DBService.instance.hasComicFavorited(comicId: comicId);
    // 从本地读取订阅状态
    subscribeStatus.value =
        UserService.instance.subscribedComicIds.contains(comicId);
    getHistory();
    loadDetail();
    loadSubscribeStatus();
    updateSubscribeRead();
    super.onInit();
  }

  void refreshDetail() {
    getHistory();
    loadDetail();
    loadSubscribeStatus();
  }

  /// 更新订阅的阅读状态
  void updateSubscribeRead() {
    try {
      userRequest.subscribeRead(id: comicId, type: AppConstant.kTypeComic);
    } catch (e) {
      Log.logPrint(e);
    }
  }

  @override
  void onClose() {
    updateComicSubscription?.cancel();
    super.onClose();
  }

  void getHistory() {
    var comicHistory = DBService.instance.getComicHistory(comicId);
    if (comicHistory != null) {
      history.value = comicHistory;
      history.update((val) {});
    }
  }

  void refreshV1() async {
    try {
      var result =
          await request.comicDetail(comicId: comicId, priorityV1: true);
      if (result.volumes.isEmpty) {
        SmartDialog.showToast("没有找到任何章节");
        return;
      }
      if (result.isHide && AppSettingsService.instance.collectHideComic.value) {
        favorite();
      }
      detail.update((val) {
        val!.volumes = result.volumes;
      });
    } catch (e) {
      SmartDialog.showToast("无法获取章节");
    }
  }

  /// 加载信息
  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      var result = await request.comicDetail(comicId: comicId);
      detail.value = result;
      if (result.volumes.isEmpty && !result.isHide) {
        refreshV1();
      }
      if (result.isHide && AppSettingsService.instance.collectHideComic.value) {
        favorite();
      }
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
  void download() {
    AppNavigator.toComicDownloadSelect(comicId);
  }

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
    if (history.value != null && history.value!.chapterId != 0) {
      ComicDetailVolume? volume;
      ComicDetailChapterItem? chapter;
      for (var volumeItem in detail.value.volumes) {
        var chapterItem = volumeItem.chapters.firstWhereOrNull(
          (x) => x.chapterId == history.value!.chapterId,
        );
        if (chapterItem != null) {
          volume = volumeItem;
          chapter = chapterItem;
          break;
        }
      }
      if (volume != null && chapter != null) {
        var chapters = List<ComicDetailChapterItem>.from(volume.chapters);
        //正序
        chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
        AppNavigator.toComicReader(
          comicId: comicId,
          comicTitle: detail.value.title,
          comicCover: detail.value.cover,
          chapters: chapters,
          chapter: chapter,
        );
      } else {
        SmartDialog.showToast("未找到历史记录对应章节，将从头开始阅读");
        readStart();
      }
    } else {
      readStart();
    }
  }

  void readStart() {
    //从头开始
    var volume = detail.value.volumes.first;
    var chapters = List<ComicDetailChapterItem>.from(volume.chapters);
    //正序
    chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
    var chapter = chapters.first;
    AppNavigator.toComicReader(
      comicId: comicId,
      comicCover: detail.value.cover,
      comicTitle: detail.value.title,
      chapters: chapters,
      chapter: chapter,
    );
  }

  void readChapter(ComicDetailVolume volume, ComicDetailChapterItem item) {
    //禁止观看VIP章节
    if (item.isVip) {
      SmartDialog.showToast("请使用动漫之家官方APP观看VIP章节");
      return;
    }
    var chapters = List<ComicDetailChapterItem>.from(volume.chapters);
    //正序
    chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
    AppNavigator.toComicReader(
      comicId: comicId,
      comicCover: detail.value.cover,
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

  void favorite() {
    if (detail.value.id == 0) {
      return;
    }
    DBService.instance.putComicFavorite(
      comicId: comicId,
      title: detail.value.title,
      cover: detail.value.cover,
    );
    favorited.value = true;
    SmartDialog.showToast("已将漫画添加至本地收藏");
  }

  void cancelFavorite() {
    DBService.instance.removeComicFavorite(comicId: comicId);
    favorited.value = false;
    SmartDialog.showToast("已从本地收藏删除漫画");
  }
}
