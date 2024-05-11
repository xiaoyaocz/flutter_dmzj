import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_dmzj/app/dialog_utils.dart';
import 'package:flutter_dmzj/app/log.dart';
import 'package:flutter_dmzj/models/db/comic_download_info.dart';
import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class ComicDownloader {
  late Rx<ComicDownloadInfo> info;
  final Function() onUpdateTask;
  ComicDownloader(ComicDownloadInfo item, {required this.onUpdateTask}) {
    info = Rx<ComicDownloadInfo>(item);
  }
  final ComicRequest request = ComicRequest();
  DownloadStatus get status => info.value.status;
  CancelToken? cancelToken;
  Dio dio = Dio(BaseOptions(
    headers: {
      'Referer': "http://www.dmzj.com/",
    },
  ));
  void start() {
    _getPageUrls();
  }

  void retry() {
    _getPageUrls();
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

  void _getPageUrls() async {
    try {
      if (info.value.urls.isNotEmpty) {
        _startDownload();
        return;
      }
      updateStatus(DownloadStatus.loadding);
      var detail = await request.chapterDetail(
        comicId: info.value.comicId,
        chapterId: info.value.chapterId,
        useHD: AppSettingsService.instance.comicReaderHD.value,
      );
      if (detail.pageUrls.isEmpty) {
        updateStatus(DownloadStatus.errorLoad);
        return;
      }
      info.update((val) {
        val!.urls = detail.pageUrls;
        val.total = detail.pageUrls.length;
      });
      await _saveInfo();
      _startDownload();
    } catch (e) {
      updateStatus(DownloadStatus.errorLoad);
    }
  }

  int retryTime = 0;
  void _startDownload() async {
    updateStatus(DownloadStatus.downloading);
    for (var i = info.value.index; i < info.value.total; i++) {
      try {
        if (status != DownloadStatus.downloading) {
          break;
        }
        var url = info.value.urls[i];
        retryTime = 0;
        await _downloadImage(url, i);
      } catch (e) {
        break;
      }
    }
    if (status == DownloadStatus.downloading &&
        (info.value.index == info.value.total - 1)) {
      updateStatus(DownloadStatus.complete);
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
        val!.index = index;
        val.files.add(fileName);
      });
      await _saveInfo();
    } catch (e) {
      Log.logPrint(e);
      if (e is DioException) {
        if (e.type == DioExceptionType.cancel) rethrow;
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
    await ComicDownloadService.instance.box.put(info.value.taskId, info.value);
  }

  Future _delete() async {
    try {
      var dir = Directory(info.value.savePath);
      await dir.delete(recursive: true);
    } finally {
      await ComicDownloadService.instance.box.delete(info.value.taskId);
      updateStatus(DownloadStatus.cancel);
    }
  }
}
