import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/db/comic_download_info.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';

import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/services/download_task/comic_downloader.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class ComicDownloadService extends GetxService {
  static ComicDownloadService get instance => Get.find<ComicDownloadService>();

  AppSettingsService settings = AppSettingsService.instance;

  late Box<ComicDownloadInfo> box;
  String savePath = "";

  /// 连接信息监听
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  /// 当前连接类型
  ConnectivityResult? connectivityType;

  /// 最大数量
  int taskNum = 5;

  /// 当前正在下载的数量
  var currentNum = 0.obs;

  Future init() async {
    taskNum = settings.downloadComicTaskCount.value;
    var dir = await getApplicationSupportDirectory();
    box = await Hive.openBox(
      "ComicDownload",
      path: dir.path,
    );
    savePath = await getSavePath();
    //监听网络状态
    initConnectivity();
    //更新ID
    updateAllIds();
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

      if (connectivityType != ConnectivityResult.none) {
        initTasks();
      }
    } catch (e) {
      Log.logPrint(e);
      initTasks();
    }
  }

  /// 网络变更
  void networkChanged(ConnectivityResult type) {
    if (connectivityType != type && type == ConnectivityResult.wifi) {
      //切换至Wifi
    } else if (connectivityType != type && type == ConnectivityResult.mobile) {
      //切换至流量
    } else if (connectivityType != type && type == ConnectivityResult.none) {
      //网络断开
    }
    connectivityType = type;
  }

  /// 任务列表
  RxList<ComicDownloader> taskQueues = RxList<ComicDownloader>();

  /// 已下载完成的
  ///RxList<ComicDownloadInfo> downloaded = RxList<ComicDownloadInfo>();

  /// 已下载、下载中的ID
  RxSet<String> downloadIds = RxSet<String>();

  /// 开始下载任务，启动定时器
  void initTasks() async {
    var tasks = getDownloadingTask();
    for (var item in tasks) {
      //任务已被取消
      if (item.status == DownloadStatus.cnacel) {
        box.delete(item.taskId);
        continue;
      }
      //只要不是手动暂停的，全部改为等待，添加到下载队列
      if (item.status != DownloadStatus.pause) {
        item.status = DownloadStatus.wait;
      }
      taskQueues.add(
        ComicDownloader(
          item,
          onUpdateInfo: (info) {
            updateQueue();
          },
        ),
      );
    }
    updateQueue();
  }

  /// 更新队列
  void updateQueue() {
    //如果下载中任务数小于设定值，添加一个任务
    //如果任务取消或完成，移除队列
    for (var task in List<ComicDownloader>.from(taskQueues)) {
      //下载完成，移除队列
      if (task.info.status == DownloadStatus.complete) {
        taskQueues.remove(task);
        updateDownlaoded();
        continue;
      }
    }
    var count = taskQueues
        .where((x) =>
            x.info.status == DownloadStatus.downloading ||
            x.info.status == DownloadStatus.loadding)
        .length;

    currentNum.value = count;

    if (count < taskNum) {
      var ls = taskQueues
          .where((x) => x.info.status == DownloadStatus.wait)
          .take(taskNum - count);
      for (var item in ls) {
        item.start();
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
  void updateDownlaoded() {}

  /// 继续
  void resumeAll() {
    //更新状态至等待
  }

  /// 暂停
  void pauseAll() {
    //如果正在下载，则取消任务
    //更新状态至暂停
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
    );
    await box.put(
      taskId,
      info,
    );
    taskQueues.add(ComicDownloader(info, onUpdateInfo: (e) {
      updateQueue();
    }));
    updateQueue();
  }

  /// 读取保存目录
  Future<String> getSavePath() async {
    var dir = await getApplicationSupportDirectory();

    var comicDir = Directory(p.join(dir.path, "comic"));
    if (!await comicDir.exists()) {
      comicDir = await comicDir.create();
    }
    return comicDir.path;
  }
}
