import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/db/novel_download_info.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/models/novel/novel_detail_model.dart';

import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/services/download_task/novel_downloader.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

/// 小说下载管理
// TODO 整理代码
class NovelDownloadService extends GetxService {
  static NovelDownloadService get instance => Get.find<NovelDownloadService>();

  AppSettingsService settings = AppSettingsService.instance;

  late Box<NovelDownloadInfo> box;
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
      "NovelDownload",
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
  RxList<NovelDownloader> taskQueues = RxList<NovelDownloader>();

  /// 已下载完成的
  RxList<NovelDownloadedItem> downloaded = RxList<NovelDownloadedItem>();

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
        NovelDownloader(item, onUpdateTask: onUpdateTask),
      );
    }
    updateQueue();
  }

  /// 更新队列
  void updateQueue() {
    //如果下载中任务数小于设定值，添加一个任务
    //如果任务取消或完成，移除队列
    for (var task in List<NovelDownloader>.from(taskQueues)) {
      //下载完成或取消，移除队列
      if (task.status == DownloadStatus.complete ||
          task.status == DownloadStatus.cancel) {
        taskQueues.remove(task);
        updateDownlaoded();
        continue;
      }
    }
    var taskNum = settings.downloadNovelTaskCount.value;
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
            .take(taskNum - count)
            .toList();
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
  List<NovelDownloadInfo> getDownloadingTask() {
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
    var novelMap = groupBy(downlaodedList, (NovelDownloadInfo x) => x.novelId);
    List<NovelDownloadedItem> novelList = [];
    for (var novelId in novelMap.keys) {
      var items = novelMap[novelId]!;
      var novelName = items.first.novelName;
      var novelCover = items.first.novelCover;

      List<NovelDetailVolume> volumes = [];
      var volumeMap = groupBy(items, (NovelDownloadInfo x) => x.volumeID);
      for (var volumeID in volumeMap.keys) {
        var chapters = volumeMap[volumeID]!
            .map(
              (e) => NovelDetailChapter(
                chapterId: e.chapterId,
                chapterName: e.chapterName,
                volumeId: e.volumeID,
                volumeName: e.volumeName,
                volumeOrder: e.volumeOrder,
                chapterOrder: e.chapterSort,
              ),
            )
            .toList();
        chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
        volumes.add(
          NovelDetailVolume(
            volumeName: chapters.first.volumeName,
            volumeId: chapters.first.volumeId,
            volumeOrder: chapters.first.volumeOrder,
            chapters: chapters,
          ),
        );
      }
      volumes.sort((a, b) => a.volumeOrder.compareTo(b.volumeOrder));
      novelList.add(
        NovelDownloadedItem(
          novelName: novelName,
          novelCover: novelCover,
          novelId: novelId,
          chapterCount: items.length,
          volumes: volumes,
        ),
      );
    }
    downloaded.value = novelList;
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

  /// 添加一个任务
  void addTask({
    required int novelId,
    required int chapterId,
    required String chapterName,
    required int chapterSort,
    required int volumeId,
    required int volumeOrder,
    required String volumeName,
    required String novelTitle,
    required String novelCover,
    required bool isVip,
  }) async {
    var taskId = "${novelId}_${volumeId}_$chapterId";
    if (box.containsKey(taskId)) {
      return;
    }
    var info = NovelDownloadInfo(
      addTime: DateTime.now(),
      chapterId: chapterId,
      chapterSort: chapterSort,
      novelCover: novelCover,
      novelId: novelId,
      novelName: novelTitle,
      savePath: p.join(savePath, taskId),
      status: DownloadStatus.wait,
      taskId: taskId,
      volumeName: volumeName,
      chapterName: chapterName,
      isVip: isVip,
      progress: 0,
      fileName: '',
      imageFiles: [],
      isImage: false,
      volumeID: volumeId,
      volumeOrder: volumeOrder,
      imageUrls: [],
    );
    await box.put(
      taskId,
      info,
    );
    taskQueues.add(NovelDownloader(info, onUpdateTask: onUpdateTask));
    updateQueue();
  }

  void onUpdateTask() {
    updateQueue();
  }

  /// 读取保存目录
  Future<String> getSavePath() async {
    var dir = await getApplicationSupportDirectory();

    var novelDir = Directory(p.join(dir.path, "novel"));
    if (!await novelDir.exists()) {
      novelDir = await novelDir.create(recursive: true);
    }
    return novelDir.path;
  }

  ///删除
  void delete(NovelDownloadInfo info) async {
    try {
      var dir = Directory(info.savePath);
      await dir.delete(recursive: true);
    } finally {
      await box.delete(info.taskId);
      updateDownlaoded();
    }
    updateAllIds();
  }

  ///删除
  void deleteChapter(int novelId, int volumeId, int chapterId) async {
    var info = box.get("${novelId}_${volumeId}_$chapterId");
    if (info != null) {
      delete(info);
    }
  }
}

class NovelDownloadedItem {
  final String novelName;
  final int novelId;
  final String novelCover;
  final List<NovelDetailVolume> volumes;
  final int chapterCount;
  NovelDownloadedItem({
    required this.novelName,
    required this.novelCover,
    required this.novelId,
    required this.chapterCount,
    required this.volumes,
  });
}
