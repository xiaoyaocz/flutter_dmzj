import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';

import 'package:flutter_dmzj/requests/novel_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class NovelSelectChapterController extends BaseController {
  final int novelId;
  NovelSelectChapterController(this.novelId);
  final NovelRequest request = NovelRequest();

  RxList<NovelDetailVolume> volumes = RxList<NovelDetailVolume>();

  String novelTitle = "";
  String novelCover = "";

  RxMap<int, RxSet<int>> selectIds = RxMap<int, RxSet<int>>();

  @override
  void onInit() {
    loadDetail();

    super.onInit();
  }

  /// 加载信息
  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      var result = await request.novelDetailV4(novelId: novelId);
      novelTitle = result.name;
      novelCover = result.cover;
      var chpaterResult = await request.novelChapterV4(novelId: novelId);
      var ls = chpaterResult.map((e) => NovelDetailVolume.fromV4(e)).toList();
      selectIds.value = {};
      for (var item in ls) {
        selectIds.addAll({
          item.volumeId: RxSet<int>(),
        });
      }
      volumes.value = ls;
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  void selectItem(NovelDetailChapter item) {
    var chapterIds = selectIds[item.volumeId]!;
    if (chapterIds.contains(item.chapterId)) {
      chapterIds.remove(item.chapterId);
    } else {
      chapterIds.add(item.chapterId);
    }
  }

  void selectAll() {
    for (var volume in volumes) {
      for (var chapter in volume.chapters) {
        var chapterIds = selectIds[volume.volumeId]!;
        var id = "${novelId}_${volume.volumeId}_${chapter.chapterId}";
        if (!NovelDownloadService.instance.downloadIds.contains(id)) {
          chapterIds.add(chapter.chapterId);
        }
      }
    }
  }

  void cleanAll() {
    for (var volume in selectIds.values) {
      volume.clear();
    }
  }

  void toDownloadManage() {
    AppNavigator.toNovelDownloadManage(1);
  }

  void startDownload() {
    var chapterIds = <int>[];
    for (var item in selectIds.values) {
      chapterIds.addAll(item);
    }
    if (chapterIds.isEmpty) {
      SmartDialog.showToast("请选择需要下载的章节");
      return;
    }
    for (var id in chapterIds) {
      //搜索章节
      NovelDetailVolume? volume;
      NovelDetailChapter? chapter;
      for (var item in volumes) {
        var chapterItem =
            item.chapters.firstWhereOrNull((y) => y.chapterId == id);
        if (chapterItem != null) {
          volume = item;
          chapter = chapterItem;
          break;
        }
      }
      if (volume == null || chapter == null) {
        continue;
      }
      NovelDownloadService.instance.addTask(
        novelId: novelId,
        chapterId: chapter.chapterId,
        chapterSort: chapter.chapterOrder,
        volumeName: volume.volumeName,
        novelTitle: novelTitle,
        novelCover: novelCover,
        chapterName: chapter.chapterName,
        isVip: false,
        volumeId: volume.volumeId,
        volumeOrder: volume.volumeOrder,
      );
    }
    cleanAll();
    SmartDialog.showToast("已添加到下载列表，下载过程中请保持APP在前台运行");
  }
}
