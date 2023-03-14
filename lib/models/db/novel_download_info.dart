import 'package:flutter_dmzj/models/db/download_status.dart';
import 'package:hive/hive.dart';
part 'novel_download_info.g.dart';

@HiveType(typeId: 5)
class NovelDownloadInfo {
  NovelDownloadInfo({
    required this.addTime,
    required this.chapterId,
    required this.chapterSort,
    required this.novelCover,
    required this.novelId,
    required this.novelName,
    required this.fileName,
    required this.imageFiles,
    required this.savePath,
    required this.status,
    required this.taskId,
    required this.isImage,
    required this.volumeName,
    required this.progress,
    required this.chapterName,
    required this.volumeID,
    required this.isVip,
    required this.volumeOrder,
    required this.imageUrls,
  });

  ///TaskID 任务，由小说ID_章节ID组成
  @HiveField(0)
  String taskId;

  ///NovelID 小说ID
  @HiveField(1)
  int novelId;

  ///NovelName 小说名称
  @HiveField(2)
  String novelName;

  ///NovelCover 小说封面
  @HiveField(3)
  String novelCover;

  ///ChapterID 章节ID
  @HiveField(4)
  int chapterId;

  ///chapterName 章节名称
  @HiveField(5)
  String chapterName;

  ///VoulmeID 分卷ID
  @HiveField(6)
  int volumeID;

  ///VoulmeName 分卷名称
  @HiveField(7)
  String volumeName;

  ///volumeOrder 分卷排序
  @HiveField(8)
  int volumeOrder;

  ///ChapterSort 排序
  @HiveField(9)
  int chapterSort;

  ///SavePath 存储路径
  @HiveField(10)
  String savePath;

  ///Files 文件列表
  @HiveField(11)
  String fileName;

  ///isImage 是否为插图
  @HiveField(12)
  bool isImage;

  /// 图片保存路径
  @HiveField(13)
  List<String> imageFiles;

  ///下载进度 0-100
  @HiveField(14)
  int progress;

  ///Status 当前状态
  @HiveField(15)
  DownloadStatus status;

  ///AddTime 任务时间
  @HiveField(16)
  DateTime addTime;

  /// 是否VIP章节
  /// * 暂时没啥用，总之先加上
  @HiveField(17)
  bool isVip;

  /// 下载图片链接
  @HiveField(18)
  List<String> imageUrls;
}
