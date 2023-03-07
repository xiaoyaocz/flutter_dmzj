import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:flutter_dmzj/models/db/novel_history.dart';
import 'package:flutter_dmzj/models/user/comic_history_model.dart';
import 'package:flutter_dmzj/models/user/novel_history_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DBService extends GetxService {
  static DBService get instance => Get.find<DBService>();
  late Box newsLikeBox;
  late Box<ComicHistory> comicHistoryBox;
  late Box<NovelHistory> novelHistoryBox;
  Future init() async {
    newsLikeBox = await Hive.openBox("NewsLike");
    comicHistoryBox = await Hive.openBox("ComicHistory");
    novelHistoryBox = await Hive.openBox("NovelHistory");
  }

  Future putComicHistory(ComicHistory history) async {
    await comicHistoryBox.put(history.comicId, history);
  }

  Future updateComicHistory(ComicHistory history) async {
    var historyItem = getComicHistory(history.comicId);
    if (historyItem != null) {
      historyItem.chapterId = history.chapterId;
      historyItem.chapterName = history.chapterName;
      historyItem.page = history.page;
      historyItem.updateTime = history.updateTime;
      await putComicHistory(historyItem);
    } else {
      await putComicHistory(history);
    }
  }

  ComicHistory? getComicHistory(int comicId) {
    return comicHistoryBox.get(comicId);
  }

  List<ComicHistory> getComicHistoryList() {
    var ls = comicHistoryBox.values.where((x) => x.chapterId != 0).toList();
    ls.sort((a, b) => b.updateTime.compareTo(a.updateTime));
    return ls;
  }

  /// 同步远程的漫画记录
  void syncRemoteComicHistory(List<UserComicHistoryModel> items) {
    try {
      for (var item in items) {
        var remoteTime =
            DateTime.fromMillisecondsSinceEpoch(item.viewingTime * 1000);
        //本地是否存在记录
        var local = comicHistoryBox.get(item.comicId);
        if (local != null && local.chapterId != 0) {
          //与本地记录时间做比对，如果较新则覆盖，否则直接跳过处理
          if (local.updateTime.millisecondsSinceEpoch <
              remoteTime.millisecondsSinceEpoch) {
            putComicHistory(
              ComicHistory(
                comicId: item.comicId,
                chapterId: item.chapterId ?? 0,
                comicName: item.comicName,
                comicCover: item.cover,
                chapterName: item.chapterName ?? "-",
                updateTime: remoteTime,
                page: item.record ?? 0,
              ),
            );
          }
        } else {
          //不存在，直接添加一条
          putComicHistory(
            ComicHistory(
              comicId: item.comicId,
              chapterId: item.chapterId ?? 0,
              comicName: item.comicName,
              comicCover: item.cover,
              chapterName: item.chapterName ?? "-",
              updateTime: remoteTime,
              page: item.record ?? 0,
            ),
          );
        }
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }

  Future putNovelHistory(NovelHistory history) async {
    await novelHistoryBox.put(history.novelId, history);
  }

  Future updateNovelHistory(NovelHistory history) async {
    var historyItem = getNovelHistory(history.novelId);
    if (historyItem != null) {
      historyItem.chapterId = history.chapterId;
      historyItem.chapterName = history.chapterName;
      historyItem.total = history.total;
      historyItem.index = history.index;
      historyItem.volumeId = history.volumeId;
      historyItem.volumeName = history.volumeName;
      historyItem.updateTime = history.updateTime;
      await putNovelHistory(historyItem);
    } else {
      await putNovelHistory(history);
    }
  }

  NovelHistory? getNovelHistory(int novelId) {
    return novelHistoryBox.get(novelId);
  }

  List<NovelHistory> getNovelHistoryList() {
    var ls = novelHistoryBox.values.where((x) => x.chapterId != 0).toList();
    ls.sort((a, b) => b.updateTime.compareTo(a.updateTime));
    return ls;
  }

  /// 同步远程的小说记录
  void syncRemoteNovelHistory(List<UserNovelHistoryModel> items) {
    try {
      for (var item in items) {
        var remoteTime =
            DateTime.fromMillisecondsSinceEpoch(item.viewingTime * 1000);
        //本地是否存在记录
        var local = novelHistoryBox.get(item.lnovelId);
        if (local != null && local.chapterId != 0) {
          //与本地记录时间做比对，如果较新则覆盖，否则直接跳过处理
          if (local.updateTime.millisecondsSinceEpoch <
              remoteTime.millisecondsSinceEpoch) {
            putNovelHistory(
              NovelHistory(
                novelId: item.lnovelId,
                chapterId: item.chapterId ?? 0,
                novelName: item.novelName,
                novelCover: item.cover,
                chapterName: item.chapterName ?? "-",
                updateTime: remoteTime,
                index: item.record,
                volumeId: item.volumeId ?? 0,
                volumeName: item.volumeName ?? "",
                total: item.totalNum,
              ),
            );
          }
        } else {
          //不存在，直接添加一条
          putNovelHistory(
            NovelHistory(
              novelId: item.lnovelId,
              chapterId: item.chapterId ?? 0,
              novelName: item.novelName,
              novelCover: item.cover,
              chapterName: item.chapterName ?? "-",
              updateTime: remoteTime,
              index: item.record,
              volumeId: item.volumeId ?? 0,
              volumeName: item.volumeName ?? "",
              total: item.totalNum,
            ),
          );
        }
      }
    } catch (e) {
      Log.logPrint(e);
    }
  }
}
