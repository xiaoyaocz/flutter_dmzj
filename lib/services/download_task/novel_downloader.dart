import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_dmzj/app/dialog_utils.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/db/novel_download_info.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/requests/novel_request.dart';
import 'package:flutter_dmzj/services/novel_download_service.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class NovelDownloader {
  late Rx<NovelDownloadInfo> info;
  final Function() onUpdateTask;
  NovelDownloader(NovelDownloadInfo item, {required this.onUpdateTask}) {
    info = Rx<NovelDownloadInfo>(item);
  }
  final NovelRequest request = NovelRequest();
  DownloadStatus get status => info.value.status;
  CancelToken? cancelToken;
  Dio dio = Dio(BaseOptions(
    headers: {
      'Referer': "http://www.dmzj.com/",
    },
  ));
  void start() {
    _startDownload();
  }

  void retry() {
    _startDownload();
  }

  void pause() {
    stopTask();
    updateStatus(DownloadStatus.pause);
  }

  void cancel() async {
    var result = await DialogUtils.showAlertDialog("确定要取消此任务吗?", title: "取消任务");
    if (!result) {
      return;
    }
    cancelToken?.cancel();
    cancelToken = null;
    await _delete();
  }

  void resume() {
    _startDownload();
  }

  void stopTask() {
    cancelToken?.cancel();
    cancelToken = null;
  }

  int retryTime = 0;
  void _startDownload() async {
    updateStatus(DownloadStatus.downloading);
    retryTime = 0;
    await _downloadContent();
    int i = 0;
    for (var url in info.value.imageUrls) {
      try {
        if (status != DownloadStatus.downloading) {
          break;
        }

        retryTime = 0;
        await _downloadImage(url, i);
        i++;
      } catch (e) {
        break;
      }
    }
    if (status == DownloadStatus.downloading) {
      updateStatus(DownloadStatus.complete);
    }
  }

  Future _downloadContent() async {
    try {
      cancelToken = CancelToken();
      var content = await request.novelContent(
        volumeId: info.value.volumeID,
        chapterId: info.value.chapterId,
        cancel: cancelToken,
        cache: false,
      );
      var fileName = await _saveContent(content);
      var subStr =
          content.substring(0, content.length < 200 ? content.length : 200);
      //检查是否是插画
      if (subStr.contains(RegExp('<img.*?>'))) {
        List<String> imgs = [];
        for (var item in RegExp(r'<img.*?src=[' '""](.*?)[' '""].*?>')
            .allMatches(content)) {
          var src = item.group(1);
          if (src != null && src.isNotEmpty) {
            imgs.add(src);
          }
        }
        info.update((val) {
          val!.fileName = fileName;
          val.imageUrls = imgs;
          val.isImage = true;
        });
      } else {
        info.update((val) {
          val!.fileName = fileName;
          val.isImage = false;
        });
      }

      await _saveInfo();
    } catch (e) {
      Log.logPrint(e);
      if (e is DioError) {
        if (e.type == DioErrorType.cancel) rethrow;
        if (status == DownloadStatus.waitNetwork ||
            status == DownloadStatus.pauseCellular) rethrow;
        if (retryTime < 3) {
          retryTime++;
          await Future.delayed(const Duration(seconds: 1));
          return await _downloadContent();
        }
      }
      updateStatus(DownloadStatus.error);
      rethrow;
    }
  }

  Future _downloadImage(String url, int index) async {
    try {
      if (url.contains(".dmzj.com")) {
        url = url.replaceAll(".dmzj.com", ".idmzj.com");
      }
      //检查本地是否有缓存，有缓存直接复制本地的
      Uint8List bytes;
      var localFile = await getCachedImageFile(url);
      if (localFile != null) {
        bytes = await localFile.readAsBytes();
      } else {
        cancelToken = CancelToken();

        var result = await dio.get(
          url,
          options: Options(
            responseType: ResponseType.bytes,
          ),
          cancelToken: cancelToken,
        );
        bytes = result.data;
      }

      var fileName = await _saveImage(bytes, index, p.extension(url));
      info.update((val) {
        val!.imageFiles.add(fileName);
      });
      await _saveInfo();
    } catch (e) {
      Log.logPrint(e);
      if (e is DioError) {
        if (e.type == DioErrorType.cancel) rethrow;
        if (status == DownloadStatus.waitNetwork ||
            status == DownloadStatus.pauseCellular) rethrow;
        if (retryTime < 3) {
          retryTime++;
          await Future.delayed(const Duration(seconds: 1));
          return await _downloadImage(url, index);
        }
      }
      updateStatus(DownloadStatus.error);
      rethrow;
    }
  }

  Future<String> _saveContent(String content) async {
    var dir = info.value.savePath;
    var fileName = "${info.value.taskId}.txt";
    var file = File(p.join(dir, fileName));
    if (!await file.exists()) {
      file = await file.create(recursive: true);
    }
    await file.writeAsString(content);
    return fileName;
  }

  Future<String> _saveImage(
      Uint8List bytes, int index, String extension) async {
    var dir = info.value.savePath;
    var fileName = "${(index + 1).toString().padLeft(3, "0")}$extension";
    var file = File(p.join(dir, fileName));
    if (!await file.exists()) {
      file = await file.create(recursive: true);
    }
    await file.writeAsBytes(bytes);
    return fileName;
  }

  void updateStatus(DownloadStatus e, {bool updateTask = true}) async {
    info.update((val) {
      val!.status = e;
    });
    if (updateTask) {
      onUpdateTask();
    }

    await _saveInfo();
  }

  /// 保存信息
  Future _saveInfo() async {
    await NovelDownloadService.instance.box.put(info.value.taskId, info.value);
  }

  Future _delete() async {
    try {
      var dir = Directory(info.value.savePath);
      await dir.delete(recursive: true);
    } finally {
      await NovelDownloadService.instance.box.delete(info.value.taskId);
      updateStatus(DownloadStatus.cancel);
    }
  }
}
