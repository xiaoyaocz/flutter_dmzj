import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/models/db/comic_download_info.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';

import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/services/download_task/comic_downloader.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

/// 漫画下载管理
// TODO 整理代码
class ComicDownloadService extends GetxService {
  static ComicDownloadService get instance => Get.find<ComicDownloadService>();

  AppSettingsService settings = AppSettingsService.instance;

  late Box<ComicDownloadInfo> box;
  String savePath = "";

  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  /// 当前连接类型
  ConnectivityResult? connectivityType;

  /// 当前正在下载的数量
  var currentNum = 0;

  Future init() async {
    var dir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      "ZaiComicDownload",
      path: dir.path,
    );
    savePath = await getSavePath();
    //监听网络状态
    initConnectivity();
    //更新ID
    updateAllIds();

    updateDownlaoded();
  }

  /// 初始化连接状态
  void initConnectivity() async {
    try {
      var connectivity = Connectivity();
      connectivitySubscription = connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        networkChanged(result);
      });
      connectivityType = await connectivity.checkConnectivity();
      initTasks();
    } catch (e) {
      Log.logPrint(e);
      initTasks();
    }
  }

  /// 网络变更
  void networkChanged(ConnectivityResult type) {
    if (connectivityType != type && type == ConnectivityResult.mobile) {
      //切换至流量
      switchCellular();
    } else if (connectivityType != type && type == ConnectivityResult.none) {
      //网络断开
      switchNoNetwork();
    } else {
      switchToWiFi();
    }
    connectivityType = type;
  }

  /// 切换至流量
  void switchCellular() {
    if (settings.downloadAllowCellular.value) {
      //允许使用流量,当成WiFi处理
      switchToWiFi();
      return;
    }
    //把任务状态改为pauseCellular
    for (var item in taskQueues) {
      if (item.status == DownloadStatus.wait ||
          item.status == DownloadStatus.loadding ||
          item.status == DownloadStatus.downloading ||
          item.status == DownloadStatus.waitNetwork) {
        item.stopTask();
        item.updateStatus(DownloadStatus.pauseCellular, updateTask: false);
      }
    }
    updateQueue();
  }

  /// 无网络
  void switchNoNetwork() {
    //把任务状态改为pauseCellular
    for (var item in taskQueues) {
      if (item.status == DownloadStatus.wait ||
          item.status == DownloadStatus.loadding ||
          item.status == DownloadStatus.downloading ||
          item.status == DownloadStatus.pauseCellular) {
        item.stopTask();
        item.updateStatus(DownloadStatus.waitNetwork, updateTask: false);
      }
    }
    updateQueue();
  }

  void switchToWiFi() {
    for (var item in taskQueues) {
      if (item.status == DownloadStatus.pauseCellular ||
          item.status == DownloadStatus.waitNetwork) {
        item.updateStatus(DownloadStatus.wait, updateTask: false);
      }
    }
    updateQueue();
  }

  /// 任务列表
  RxList<ComicDownloader> taskQueues = RxList<ComicDownloader>();

  /// 已下载完成的
  RxList<ComicDownloadedItem> downloaded = RxList<ComicDownloadedItem>();

  /// 已下载、下载中的ID
  RxSet<String> downloadIds = RxSet<String>();

  /// 开始下载任务
  void initTasks() async {
    var tasks = getDownloadingTask();
    for (var item in tasks) {
      //任务已被取消
      if (item.status == DownloadStatus.cancel) {
        box.delete(item.taskId);
        continue;
      }
      //无网络
      if (connectivityType == ConnectivityResult.none) {
        if (item.status != DownloadStatus.pause) {
          item.status = DownloadStatus.waitNetwork;
        }
      } else if (connectivityType == ConnectivityResult.mobile) {
        //不允许使用数据下载
        if (!settings.downloadAllowCellular.value) {
          if (item.status != DownloadStatus.pause) {
            item.status = DownloadStatus.pauseCellular;
          }
        }
      } else {
        //只要不是手动暂停的，全部改为等待，添加到下载队列
        if (item.status != DownloadStatus.pause) {
          item.status = DownloadStatus.wait;
        }
      }

      taskQueues.add(
        ComicDownloader(item, onUpdateTask: onUpdateTask),
      );
    }
    updateQueue();
  }

  /// 更新队列
  void updateQueue() {
    //如果下载中任务数小于设定值，添加一个任务
    //如果任务取消或完成，移除队列
    for (var task in List<ComicDownloader>.from(taskQueues)) {
      //下载完成或取消，移除队列
      if (task.status == DownloadStatus.complete ||
          task.status == DownloadStatus.cancel) {
        taskQueues.remove(task);
        updateDownlaoded();
        continue;
      }
    }
    var taskNum = settings.downloadComicTaskCount.value;
    var count = taskQueues
        .where((x) =>
            x.status == DownloadStatus.downloading ||
            x.status == DownloadStatus.loadding)
        .length;

    currentNum = count;
    if (taskNum == 0) {
      var ls = taskQueues.where((x) => x.status == DownloadStatus.wait);
      for (var item in ls) {
        item.start();
      }
    } else {
      if (count < taskNum) {
        var ls = taskQueues
            .where((x) => x.status == DownloadStatus.wait)
            .take(taskNum - count);
        for (var item in ls) {
          item.start();
        }
      }
    }
    updateAllIds();
  }

  void updateAllIds() {
    downloadIds.clear();
    downloadIds.addAll(box.keys.map((e) => e.toString()));
  }

  ///读取未完成的任务
  List<ComicDownloadInfo> getDownloadingTask() {
    return box.values
        .toList()
        .where((x) => x.status != DownloadStatus.complete)
        .toList();
  }

  /// 更新下载完成
  void updateDownlaoded() {
    var downlaodedList = box.values
        .toList()
        .where((x) => x.status == DownloadStatus.complete)
        .toList();
    var comicMap = groupBy(downlaodedList, (ComicDownloadInfo x) => x.comicId);
    List<ComicDownloadedItem> comicList = [];
    for (var comicId in comicMap.keys) {
      var items = comicMap[comicId]!;
      var comicName = items.first.comicName;
      var comicCover = items.first.comicCover;
      var isLongComic = items.first.isLongComic;
      List<ComicDetailVolume> volumes = [];
      var volumeMap = groupBy(items, (ComicDownloadInfo x) => x.volumeName);
      for (var volumeName in volumeMap.keys) {
        var chapters = volumeMap[volumeName]!
            .map(
              (e) => ComicDetailChapterItem(
                chapterId: e.chapterId,
                chapterTitle: e.chapterName,
                updateTime: 0,
                fileSize: 0,
                chapterOrder: e.chapterSort,
              ),
            )
            .toList();
        volumes.add(
          ComicDetailVolume(
            title: volumeName,
            chapters: RxList<ComicDetailChapterItem>(chapters),
          ),
        );
      }
      for (var item in volumes) {
        item.sortType.value = 1;
        item.sort();
      }
      comicList.add(
        ComicDownloadedItem(
          comicName: comicName,
          comicCover: comicCover,
          comicId: comicId,
          chapterCount: items.length,
          volumes: volumes,
          isLongComic: isLongComic,
        ),
      );
    }
    downloaded.value = comicList;
  }

  /// 继续
  void resumeAll() {
    //更新状态至等待
    for (var task in taskQueues) {
      if (task.status == DownloadStatus.pause) {
        task.stopTask();
        task.updateStatus(DownloadStatus.wait, updateTask: false);
      }
    }
    updateQueue();
  }

  /// 暂停
  void pauseAll() {
    for (var task in taskQueues) {
      if (task.status != DownloadStatus.pause &&
          task.status != DownloadStatus.error &&
          task.status != DownloadStatus.errorLoad) {
        task.stopTask();
        task.updateStatus(DownloadStatus.pause, updateTask: false);
      }
    }
    updateQueue();
  }

  /// 取消任务
  void cancelTask(ComicDownloader task) {
    // 移除列表
    // 移除数据库
    // 取消任务
    // 删除文件
  }

  /// 添加一个任务
  void addTask({
    required int comicId,
    required int chapterId,
    required String chapterName,
    required int chapterSort,
    required String volumeName,
    required String comicTitle,
    required String comicCover,
    required bool isVip,
    required bool isLongComic,
  }) async {
    var taskId = "${comicId}_$chapterId";
    if (box.containsKey(taskId)) {
      return;
    }
    var info = ComicDownloadInfo(
      addTime: DateTime.now(),
      chapterId: chapterId,
      chapterSort: chapterSort,
      comicCover: comicCover,
      comicId: comicId,
      comicName: comicTitle,
      files: [],
      index: 0,
      savePath: p.join(savePath, taskId),
      status: DownloadStatus.wait,
      taskId: taskId,
      total: 0,
      volumeName: volumeName,
      chapterName: chapterName,
      urls: [],
      isVip: isVip,
      isLongComic: isLongComic,
    );
    await box.put(
      taskId,
      info,
    );
    taskQueues.add(ComicDownloader(info, onUpdateTask: onUpdateTask));
    updateQueue();
  }

  void onUpdateTask() {
    updateQueue();
  }

  /// 读取保存目录
  Future<String> getSavePath() async {
    var dir = await getApplicationSupportDirectory();

    var comicDir = Directory(p.join(dir.path, "comic"));
    if (!await comicDir.exists()) {
      comicDir = await comicDir.create(recursive: true);
    }
    return comicDir.path;
  }

  ///删除
  void delete(ComicDownloadInfo info) async {
    try {
      var dir = Directory(p.join(savePath, info.taskId));
      await dir.delete(recursive: true);
    } catch (e) {
      Log.logPrint(e);
    } finally {
      await box.delete(info.taskId);
      updateDownlaoded();
    }
    updateAllIds();
  }

  ///删除
  void deleteChapter(int comicId, int chapterId) async {
    var info = box.get("${comicId}_$chapterId");
    if (info != null) {
      delete(info);
    }
  }
}

class ComicDownloadedItem {
  final String comicName;
  final int comicId;
  final String comicCover;
  final List<ComicDetailVolume> volumes;
  final int chapterCount;
  final bool isLongComic;
  ComicDownloadedItem({
    required this.comicName,
    required this.comicCover,
    required this.comicId,
    required this.chapterCount,
    required this.volumes,
    required this.isLongComic,
  });
}
