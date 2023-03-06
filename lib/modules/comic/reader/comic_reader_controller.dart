import 'dart:math';

import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/chapter_info.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderController extends BaseController {
  final int comicId;
  final String comicTitle;
  final ComicDetailChapterItem chapter;
  final List<ComicDetailChapterItem> chapters;
  final ComicRequest request = ComicRequest();
  ComicReaderController({
    required this.comicId,
    required this.comicTitle,
    required this.chapters,
    required this.chapter,
  }) {
    chapterIndex.value = chapters.indexOf(chapter);
  }
  final PreloadPageController preloadPageController = PreloadPageController();
  var chapterIndex = 0.obs;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  Rx<ComicChapterDetail> detail =
      Rx<ComicChapterDetail>(ComicChapterDetail.empty());

  /// 当处于放大图片时，锁定滑动手势
  var lockSwipe = false.obs;

  /// 阅读方向 0=左右，1=上下，2=右左
  var direction = 1.obs;

  /// 当前页面
  var currentIndex = 0.obs;

  @override
  void onInit() {
    itemPositionsListener.itemPositions.addListener(updateItemPosition);
    loadDetail();
    super.onInit();
  }

  @override
  void onClose() {
    itemPositionsListener.itemPositions.removeListener(updateItemPosition);
    super.onClose();
  }

  void updateItemPosition() {
    var items = itemPositionsListener.itemPositions.value;
    if (items.isEmpty) {
      return;
    }

    var index = items
        .where((ItemPosition position) => position.itemTrailingEdge > 0)
        .reduce((ItemPosition min, ItemPosition position) =>
            position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;

    currentIndex.value = index;
    print(items);
  }

  /// 加载信息
  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      var result = await request.chapterDetail(
        comicId: comicId,
        chapterId: chapters[chapterIndex.value].chapterId,
      );
      currentIndex.value = 0;
      detail.value = result;
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }
}
