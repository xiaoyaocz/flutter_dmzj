import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
part 'comic_download_info.g.dart';

@HiveType(typeId: 3)
class ComicDownloadInfo {
  ComicDownloadInfo({
    required this.addTime,
    required this.chapterId,
    required this.chapterSort,
    required this.comicCover,
    required this.comicId,
    required this.comicName,
    required this.files,
    required this.index,
    required this.savePath,
    required this.status,
    required this.taskId,
    required this.total,
    required this.volumeName,
    required this.urls,
    required this.chapterName,
    required this.isVip,
    required this.isLongComic,
  });

  ///TaskID 任务，由漫画ID_章节ID组成
  @HiveField(0)
  String taskId;

  ///ComicID 漫画ID
  @HiveField(1)
  int comicId;

  ///ComicName 漫画名称
  @HiveField(2)
  String comicName;

  ///ComicCover 漫画封面
  @HiveField(3)
  String comicCover;

  ///ChapterID 章节ID
  @HiveField(4)
  int chapterId;

  @HiveField(5)
  String chapterName;

  ///VoulmeName 分卷名称
  @HiveField(6)
  String volumeName;

  ///ChapterSort 排序
  @HiveField(7)
  int chapterSort;

  ///SavePath 存储路径
  @HiveField(8)
  String savePath;

  ///Files 文件列表
  @HiveField(9)
  List<String> files;

  ///Index 当前下载页数
  @HiveField(10)
  int index;

  ///Total 总计页数
  @HiveField(11)
  int total;

  ///Status 当前状态
  @HiveField(12)
  DownloadStatus status;

  ///AddTime 任务时间
  @HiveField(13)
  DateTime addTime;

  /// 下载图片链接
  @HiveField(14)
  List<String> urls;

  /// 是否VIP章节
  /// * 暂时没啥用，总之先加上
  @HiveField(15)
  bool isVip;

  /// 是否为条漫
  @HiveField(16)
  bool isLongComic;
}
