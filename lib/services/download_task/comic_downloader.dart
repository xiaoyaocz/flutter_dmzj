import 'package:dio/dio.dart';
import 'package:flutter_dmzj/models/db/comic_download_info.dart';

class ComicDownloader {
  final ComicDownloadInfo info;
  final Function(ComicDownloadInfo) onUpdateInfo;
  ComicDownloader(this.info, {required this.onUpdateInfo});

  void start() {}
  void pause() {}
  void pauseCellular() {}
}
