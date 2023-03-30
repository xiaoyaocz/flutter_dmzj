import 'dart:async';

import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ComicDownloadedDetailController extends GetxController {
  final ComicDownloadedItem info;
  ComicDownloadedDetailController(this.info);

  /// 阅读记录
  Rx<ComicHistory?> history = Rx<ComicHistory?>(null);

  /// 更新漫画记录
  StreamSubscription<dynamic>? updateComicSubscription;

  /// 编辑模式
  var editMode = false.obs;

  RxSet<ComicDetailChapterItem> selectItems = RxSet<ComicDetailChapterItem>();

  @override
  void onInit() {
    updateComicSubscription = EventBus.instance.listen(
      EventBus.kUpdatedComicHistory,
      (id) {
        if (id == info.comicId) {
          getHistory();
        }
      },
    );

    getHistory();

    super.onInit();
  }

  @override
  void onClose() {
    updateComicSubscription?.cancel();
    super.onClose();
  }

  void getHistory() {
    var comicHistory = DBService.instance.getComicHistory(info.comicId);
    if (comicHistory != null) {
      history.value = comicHistory;
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
      ComicDetailVolume? volume;
      ComicDetailChapterItem? chapter;
      for (var volumeItem in info.volumes) {
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
          comicId: info.comicId,
          comicTitle: info.comicName,
          comicCover: info.comicCover,
          chapters: chapters,
          chapter: chapter,
          isLongComic: info.isLongComic,
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
    var volume = info.volumes.first;
    var chapters = List<ComicDetailChapterItem>.from(volume.chapters);
    //正序
    chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
    var chapter = chapters.first;
    AppNavigator.toComicReader(
      comicId: info.comicId,
      comicCover: info.comicCover,
      comicTitle: info.comicName,
      chapters: chapters,
      chapter: chapter,
      isLongComic: info.isLongComic,
    );
  }

  void readChapter(ComicDetailVolume volume, ComicDetailChapterItem item) {
    var chapters = List<ComicDetailChapterItem>.from(volume.chapters);
    //正序
    chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
    AppNavigator.toComicReader(
      comicId: info.comicId,
      comicCover: info.comicCover,
      comicTitle: info.comicName,
      chapters: chapters,
      chapter: item,
      isLongComic: info.isLongComic,
    );
  }

  void toDetail() {
    AppNavigator.toComicDetail(info.comicId);
  }

  void toAddDownload() {
    AppNavigator.toComicDownloadSelect(info.comicId);
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
      for (var chapter in volume.chapters) {
        selectItems.add(chapter);
      }
    }
    isSelectAll = true;
  }

  void delete() {
    for (var item in selectItems) {
      ComicDownloadService.instance.deleteChapter(info.comicId, item.chapterId);
    }
    exitEditMode();
    SmartDialog.showToast("删除成功");
    AppNavigator.closePage();
  }

  void selectItem(ComicDetailChapterItem item) {
    if (selectItems.contains(item)) {
      selectItems.remove(item.chapterId);
    } else {
      selectItems.add(item);
    }
  }
}
