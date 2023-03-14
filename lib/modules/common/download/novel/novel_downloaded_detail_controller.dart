import 'dart:async';

import 'package:flutter_dmzj/app/event_bus.dart';

import 'package:flutter_dmzj/models/db/novel_history.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class NovelDownloadedDetailController extends GetxController {
  final NovelDownloadedItem info;
  NovelDownloadedDetailController(this.info);

  /// 阅读记录
  Rx<NovelHistory?> history = Rx<NovelHistory?>(null);

  /// 更新漫画记录
  StreamSubscription<dynamic>? updateNovelSubscription;

  /// 编辑模式
  var editMode = false.obs;

  RxSet<NovelDetailChapter> selectItems = RxSet<NovelDetailChapter>();

  @override
  void onInit() {
    updateNovelSubscription = EventBus.instance.listen(
      EventBus.kUpdatedNovelHistory,
      (id) {
        if (id == info.novelId) {
          getHistory();
        }
      },
    );

    getHistory();

    super.onInit();
  }

  @override
  void onClose() {
    updateNovelSubscription?.cancel();
    super.onClose();
  }

  void getHistory() {
    var novelHistory = DBService.instance.getNovelHistory(info.novelId);
    if (novelHistory != null) {
      history.value = novelHistory;
      history.update((val) {});
    }
  }

  /// 开始/继续阅读
  void read() {
    if (info.volumes.isEmpty) {
      SmartDialog.showToast("没有可阅读的章节");
      return;
    }
    if (info.volumes.first.chapters.isEmpty) {
      SmartDialog.showToast("没有可阅读的章节");
      return;
    }
    //查找记录
    if (history.value != null && history.value!.chapterId != 0) {
      NovelDetailChapter? chapter;
      for (var volumeItem in info.volumes) {
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
        for (var volume in info.volumes) {
          chapters.addAll(volume.chapters);
        }

        AppNavigator.toNovelReader(
          novelId: info.novelId,
          novelCover: info.novelCover,
          novelTitle: info.novelName,
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
    for (var volume in info.volumes) {
      chapters.addAll(volume.chapters);
    }
    var chapter = chapters.first;
    AppNavigator.toNovelReader(
      novelId: info.novelId,
      novelCover: info.novelCover,
      novelTitle: info.novelName,
      chapter: chapter,
      chapters: chapters,
    );
  }

  void readChapter(NovelDetailVolume volume, NovelDetailChapter item) {
    List<NovelDetailChapter> chapters = [];
    for (var volume in info.volumes) {
      chapters.addAll(volume.chapters);
    }

    AppNavigator.toNovelReader(
      novelId: info.novelId,
      novelCover: info.novelCover,
      novelTitle: info.novelName,
      chapters: chapters,
      chapter: item,
    );
  }

  void toDetail() {
    AppNavigator.toNovelDetail(info.novelId);
  }

  void toAddDownload() {
    AppNavigator.toNovelDownloadSelect(info.novelId);
  }

  void setEditMode() {
    selectItems.clear();
    editMode.value = true;
  }

  void exitEditMode() {
    selectItems.clear();
    editMode.value = false;
  }

  var isSelectAll = false;
  void selectAll() {
    if (isSelectAll) {
      selectItems.clear();
      isSelectAll = false;
      return;
    }
    for (var volume in info.volumes) {
      selectItems.addAll(volume.chapters);
    }
    isSelectAll = true;
  }

  void delete() {
    for (var item in selectItems) {
      NovelDownloadService.instance
          .deleteChapter(info.novelId, item.volumeId, item.chapterId);
    }
    exitEditMode();
    SmartDialog.showToast("删除成功");
    AppNavigator.closePage();
  }

  void selectItem(NovelDetailChapter item) {
    if (selectItems.contains(item)) {
      selectItems.remove(item.chapterId);
    } else {
      selectItems.add(item);
    }
  }
}
