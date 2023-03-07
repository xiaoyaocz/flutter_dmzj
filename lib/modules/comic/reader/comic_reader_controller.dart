import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/chapter_info.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/comic/view_point_model.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/services/db_service.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:remixicon/remixicon.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ComicReaderController extends BaseController {
  final int comicId;
  final String comicTitle;
  final String comicCover;
  final ComicDetailChapterItem chapter;
  final List<ComicDetailChapterItem> chapters;
  final ComicRequest request = ComicRequest();
  ComicReaderController({
    required this.comicId,
    required this.comicTitle,
    required this.chapters,
    required this.chapter,
    required this.comicCover,
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
  var direction = 0.obs;

  /// 当前页面
  var currentIndex = 0.obs;

  /// 初始化
  var initialIndex = 0;

  /// 是否显示控制器
  var showControls = false.obs;

  /// 观点、吐槽
  RxList<ComicViewPointModel> viewPoints = RxList<ComicViewPointModel>();

  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );

    itemPositionsListener.itemPositions.addListener(updateItemPosition);
    loadDetail();
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    itemPositionsListener.itemPositions.removeListener(updateItemPosition);
    uploadHistory();
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
  }

  /// 加载信息
  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;

      detail.value = ComicChapterDetail.empty();
      var chapterId = chapters[chapterIndex.value].chapterId;
      loadViewPoints();

      var result = await request.chapterDetail(
        comicId: comicId,
        chapterId: chapterId,
      );
      var his = DBService.instance.getComicHistory(comicId);
      if (his != null && his.chapterId == chapterId && his.page != 0) {
        var hisIndex = (his.page - 1) < 0 ? 0 : his.page - 1;
        if (hisIndex >= result.pageUrls.length - 1) {
          hisIndex = 0;
        }
        initialIndex = hisIndex;
      } else {
        initialIndex = 0;
      }
      currentIndex.value = initialIndex;

      detail.value = result;
      Future.delayed(const Duration(milliseconds: 100), () {
        jumpToPage(initialIndex);
      });
      //上传记录
      uploadHistory();
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  /// 加载吐槽、观点
  void loadViewPoints() async {
    try {
      viewPoints.clear();
      var result = await request.viewPoints(
        comicId: comicId,
        chapterId: chapters[chapterIndex.value].chapterId,
      );
      result.sort((a, b) => b.num.compareTo(a.num));
      viewPoints.value = result;
    } catch (e) {
      SmartDialog.showToast("读取吐槽失败");
      Log.logPrint(e.toString());
    }
  }

  /// 设置显示/隐藏控制按钮
  void setShowControls() {
    if (!showControls.value) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values,
      );
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ));
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      showControls.value = !showControls.value;
    });
  }

  /// 显示目录
  void showMenu() async {
    setShowControls();
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      backgroundColor: AppStyle.darkTheme.cardColor,
      builder: (context) => Theme(
        data: AppStyle.darkTheme,
        child: Column(
          children: [
            ListTile(
              title: Text("目录(${chapters.length})"),
              trailing: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.close),
              ),
              contentPadding: AppStyle.edgeInsetsL12,
            ),
            Divider(
              height: 1.0,
              color: Colors.grey.withOpacity(.2),
            ),
            Expanded(
              child: ScrollablePositionedList.separated(
                initialScrollIndex: chapterIndex.value,
                itemCount: chapters.length,
                separatorBuilder: (_, i) => Divider(
                  indent: 12,
                  endIndent: 12,
                  height: 1.0,
                  color: Colors.grey.withOpacity(.2),
                ),
                itemBuilder: (_, i) {
                  var item = chapters[i];
                  return ListTile(
                    selected: i == chapterIndex.value,
                    title: Text(item.chapterTitle),
                    onTap: () {
                      chapterIndex.value = i;
                      loadDetail();
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      routeSettings: const RouteSettings(name: "/modalBottomSheet"),
    );
  }

  /// 下一章
  void nextChapter() {
    if (chapterIndex.value == chapters.length - 1) {
      SmartDialog.showToast("后面没有了");
      return;
    }
    setShowControls();
    chapterIndex.value += 1;
    return loadDetail();
  }

  /// 上一章
  void forwardChapter() {
    if (chapterIndex.value == 0) {
      SmartDialog.showToast("前面没有了");
      return;
    }
    setShowControls();
    chapterIndex.value -= 1;
    return loadDetail();
  }

  /// 下一页
  void nextPage() {
    var value = currentIndex.value;
    var max = detail.value.pageUrls.length;
    if (value >= max - 1) {
      nextChapter();
    } else {
      jumpToPage(value + 1, anime: true);
    }
  }

  /// 上一页
  void forwardPage() {
    var value = currentIndex.value;

    if (value == 0) {
      forwardChapter();
    } else {
      jumpToPage(value - 1, anime: true);
    }
  }

  /// 跳转页数
  void jumpToPage(int page, {bool anime = false}) {
    //竖向
    if (direction.value == 1) {
      itemScrollController.jumpTo(index: page);
    } else {
      anime
          ? preloadPageController.animateToPage(page,
              duration: const Duration(milliseconds: 200), curve: Curves.linear)
          : preloadPageController.jumpToPage(page);
    }
  }

  /// 查看吐槽
  void showComment() {
    setShowControls();
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      backgroundColor: AppStyle.darkTheme.cardColor,
      builder: (context) => Theme(
        data: AppStyle.darkTheme,
        child: Column(
          children: [
            ListTile(
              title: Text("吐槽(${viewPoints.length})"),
              trailing: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.close),
              ),
              contentPadding: AppStyle.edgeInsetsL12,
            ),
            Divider(
              height: 1.0,
              color: Colors.grey.withOpacity(.2),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: viewPoints.length,
                separatorBuilder: (_, i) => Divider(
                  indent: 12,
                  endIndent: 12,
                  height: 1.0,
                  color: Colors.grey.withOpacity(.2),
                ),
                itemBuilder: (_, i) {
                  var item = viewPoints[i];
                  return Padding(
                    padding: AppStyle.edgeInsetsA12.copyWith(top: 4, bottom: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.content,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Remix.thumb_up_line,
                            size: 20,
                          ),
                          label: Text("${item.num}"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      routeSettings: const RouteSettings(name: "/modalBottomSheet"),
    );
  }

  /// 显示设置
  void showSettings() {}

  void uploadHistory() {
    var chapter = chapters[chapterIndex.value];
    UserService.instance.updateComicHistory(
      comicId: comicId,
      chapterId: chapter.chapterId,
      page: currentIndex.value + 1,
      comicName: comicTitle,
      comicCover: comicCover,
      chapterName: chapter.chapterTitle,
    );
  }
}
