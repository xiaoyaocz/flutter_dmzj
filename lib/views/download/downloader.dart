import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_dmzj/helper/api.dart';
import 'package:flutter_dmzj/helper/config_helper.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_dmzj/models/comic/comic_web_chapter_detail.dart';
import 'package:flutter_dmzj/models/download/comic_download_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ComicDownloader {
  static EventBus downloadEvent = EventBus();
  static ComicWebChapterDetail currentData;
  static ComicDetailChapterItem currentDownload;
  static bool downloading;
  static String downloadPath;
  static final Options options =
      Options(headers: {"Referer": "http://www.dmzj.com/"});
  int comicId;
  String coverUrl;
  String comicTitle;
  static int poolCount = 3;
  ComicDownloader(this.comicId);
  static double progress = 0.0;
  EventBus progressBus = EventBus();

  void setPool(int pool) {
    poolCount = pool;
  }

  int getCurrentId() => currentDownload.chapter_id;

  Future<void> startDownload(ComicDetailChapterItem chapter) async {
    currentDownload = chapter;
    progress = 0.0;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    downloadPath = appDocDir.absolute.path + '/downloads';
    print(downloadPath);
    var directory =
        await new Directory("$downloadPath/$comicId").create(recursive: true);
    assert(await directory.exists() == true);
    //输出绝对路径
    print("Path: ${directory.absolute.path}");

    // File downloadRecort = new File(downloadPath + '/info.json');
    // if (!await downloadRecort.exists()) {
    //   //创建文件
    //   downloadRecort = await downloadRecort.create();
    // }
    // var jsonMap = jsonDecode(await downloadRecort.readAsString());
    // ComicDownloadModel model = ComicDownloadModel.fromJson(jsonMap);
    // if (!model.id.contains(comicId)) {
    //   model.id.add(comicId);
    //   model.coverUrl.add(coverUrl);
    //   model.title.add(comicTitle);
    // }

    directory = await new Directory(
            "$downloadPath/$comicId/${currentDownload.chapter_id}")
        .create(recursive: true);
    assert(await directory.exists() == true);
    print("Path: ${directory.absolute.path}");
    await loadPages();
    print('download done');
  }

  Future<int> delete(ComicDetailChapterItem chapter) async {
    print(downloadPath);
    var directory = Directory("$downloadPath/$comicId/${chapter.chapter_id}");
    if (await directory.exists()) {
      await directory.delete(recursive: true);
      return 0;
    }
    return 1;
  }

  Future loadPages() async {
    var api = Api.comicChapterDetail(this.comicId, currentDownload.chapter_id);

    if (ConfigHelper.getComicWebApi()) {
      api = Api.comicWebChapterDetail(this.comicId, currentDownload.chapter_id);
    }
    Uint8List responseBody;
    try {
      var response = await http.get(api);
      responseBody = response.bodyBytes;
    } catch (e) {
      print(e);
      return;
    }

    var responseStr = utf8.decode(responseBody);
    var jsonMap = jsonDecode(responseStr);

    currentData = ComicWebChapterDetail.fromJson(jsonMap);
    print(currentData.page_url);
    await download();
    print('load done');
    progress = 1;
  }

  Future download() async {
    int len = currentData.page_url.length;
    int pool = len ~/ poolCount;
    int index = 0;
    for (int k = 0; k < pool; k++) {
      for (int j = 0; j < poolCount; j++, index++) {
        await Dio()
            .download(currentData.page_url[index],
                "$downloadPath/$comicId/${currentDownload.chapter_id}/$index.jpg",
                options: options)
            .whenComplete(() {
          print(currentData.page_url[index]);
          progress = index / currentData.page_url.length;
          progressBus.fire(progress);
        });
      }
    }
    for (; index < currentData.page_url.length; index++) {
      await Dio()
          .download(currentData.page_url[index],
              "$downloadPath/$comicId/${currentDownload.chapter_id}/$index.jpg",
              options: options)
          .whenComplete(() {
        progress = index / currentData.page_url.length;
        progressBus.fire(progress);
      });
    }
    index = 0;
    progress = 0;
    progressBus.fire(progress);
  }
}
