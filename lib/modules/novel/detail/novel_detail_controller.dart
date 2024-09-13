import 'dart:async';

import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/db/novel_history.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';
import 'package:flutter_dmzj/requests/user_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class NovelDetailControler extends BaseController {
  final int novelId;
  NovelDetailControler(this.novelId);

  final NovelRequest request = NovelRequest();
  final UserRequest userRequest = UserRequest();

  Rx<NovelDetailInfo> detail = Rx<NovelDetailInfo>(NovelDetailInfo.empty());

  var expandDescription = false.obs;

  /// 是否已订阅
  var subscribeStatus = false.obs;

  /// 阅读记录
  Rx<NovelHistory?> history = Rx<NovelHistory?>(null);

  /// 更新小说记录
  StreamSubscription<dynamic>? updateNovelSubscription;

  @override
  void onInit() {
    updateNovelSubscription = EventBus.instance.listen(
      EventBus.kUpdatedNovelHistory,
      (id) {
        if (id == novelId) {
          getHistory();
        }
      },
    );
    // 从本地读取订阅状态
    subscribeStatus.value =
        UserService.instance.subscribedNovelIds.contains(novelId);
    getHistory();
    loadDetail();
    loadSubscribeStatus();
    //updateSubscribeRead();
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
      userRequest.subscribeRead(id: novelId, type: AppConstant.kTypeNovel);
    } catch (e) {
      Log.logPrint(e);
    }
  }

  @override
  void onClose() {
    updateNovelSubscription?.cancel();
    super.onClose();
  }

  void getHistory() {
    var novelHistory = DBService.instance.getNovelHistory(novelId);
    if (novelHistory != null) {
      history.value = novelHistory;
      history.update((val) {});
    }
  }

  /// 加载信息
  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      var result = await request.novelDetail(novelId: novelId);

      detail.value = NovelDetailInfo.fromJson(result.data);
      await loadChapter();
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  Future loadChapter() async {
    try {
      var result = await request.novelChapter(novelId: novelId);
      detail.value.volume.value =
          result.map((e) => NovelDetailVolume.fromJson(e)).toList();
    } catch (e) {
      SmartDialog.showToast("无法读取小说章节:$e");
    }
  }

  /// 检查订阅状态
  void loadSubscribeStatus() async {
    try {
      var result = await userRequest.checkSubscribeStatus(
        objId: novelId,
        type: AppConstant.kTypeNovel,
      );
      subscribeStatus.value = result;
      if (subscribeStatus.value) {
        UserService.instance.subscribedNovelIds.add(novelId);
      } else {
        UserService.instance.subscribedNovelIds.remove(novelId);
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  /// 查看评论
  void comment() {
    AppNavigator.toComment(objId: novelId, type: AppConstant.kTypeNovel);
  }

  ///  分享
  void share() {
    Utils.share(
      "http://q.idmzj.com/$novelId/index.shtml",
      content: detail.value.name,
    );
  }

  /// 订阅
  void subscribe() async {
    var result = await (subscribeStatus.value
        ? UserService.instance
            .cancelSubscribe([novelId], AppConstant.kTypeNovel)
        : UserService.instance.addSubscribe([novelId], AppConstant.kTypeNovel));
    if (result) {
      subscribeStatus.value = !subscribeStatus.value;
    }
  }

  /// 下载
  void download() {
    AppNavigator.toNovelDownloadSelect(novelId);
  }

  /// 开始/继续阅读
  void read() {
    if (detail.value.volume.isEmpty) {
      SmartDialog.showToast("没有可阅读的章节");
      return;
    }
    if (detail.value.volume.first.chapters.isEmpty) {
      SmartDialog.showToast("没有可阅读的章节");
      return;
    }
    //查找记录
    if (history.value != null && history.value!.chapterId != 0) {
      NovelDetailChapter? chapter;
      for (var volumeItem in detail.value.volume) {
        var chapterItem = volumeItem.chapters.firstWhereOrNull(
          (x) => x.chapterId == history.value!.chapterId,
        );
        if (chapterItem != null) {
          chapter = chapterItem;
          break;
        }
      }
      if (chapter != null) {
        List<NovelDetailChapter> chapters = [];
        for (var volume in detail.value.volume) {
          chapters.addAll(volume.chapters);
        }

        AppNavigator.toNovelReader(
          novelId: novelId,
          novelCover: detail.value.cover,
          novelTitle: detail.value.name,
          chapter: chapter,
          chapters: chapters,
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
    List<NovelDetailChapter> chapters = [];
    for (var volume in detail.value.volume) {
      chapters.addAll(volume.chapters);
    }
    var chapter = chapters.first;
    AppNavigator.toNovelReader(
      novelId: novelId,
      novelCover: detail.value.cover,
      novelTitle: detail.value.name,
      chapter: chapter,
      chapters: chapters,
    );
  }

  void readChapter(NovelDetailVolume volume, NovelDetailChapter item) {
    List<NovelDetailChapter> chapters = [];
    for (var volume in detail.value.volume) {
      chapters.addAll(volume.chapters);
    }

    AppNavigator.toNovelReader(
      novelId: novelId,
      novelCover: detail.value.cover,
      novelTitle: detail.value.name,
      chapters: chapters,
      chapter: item,
    );
  }

  void toAuthorDetail(String e) {
    AppNavigator.toNovelSearch(keyword: e);
  }

  void toCategoryDetail(String e) {
    AppNavigator.toNovelSearch(keyword: e);
  }
}
