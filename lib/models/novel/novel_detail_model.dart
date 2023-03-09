import 'package:flutter_dmzj/models/proto/novel.pb.dart';
import 'package:get/get.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelDetailInfo {
  NovelDetailInfo({
    required this.novelId,
    required this.name,
    required this.zone,
    required this.status,
    required this.lastUpdateVolumeName,
    required this.lastUpdateChapterName,
    required this.lastUpdateVolumeId,
    required this.lastUpdateChapterId,
    required this.lastUpdateTime,
    required this.cover,
    required this.hotHits,
    required this.introduction,
    required this.types,
    required this.authors,
    required this.firstLetter,
    required this.subscribeNum,
  });

  factory NovelDetailInfo.empty() => NovelDetailInfo(
        novelId: 0,
        name: "",
        zone: "",
        status: "",
        lastUpdateVolumeName: "",
        lastUpdateChapterName: "",
        lastUpdateVolumeId: 0,
        lastUpdateChapterId: 0,
        lastUpdateTime: 0,
        cover: "",
        hotHits: 0,
        introduction: "",
        types: [],
        authors: "",
        firstLetter: "",
        subscribeNum: 0,
      );

  factory NovelDetailInfo.fromV4(NovelDetailProto item) => NovelDetailInfo(
        novelId: item.novelId.toInt(),
        name: item.name,
        zone: item.zone,
        status: item.status,
        lastUpdateVolumeName: item.lastUpdateVolumeName,
        lastUpdateChapterName: item.lastUpdateChapterName,
        lastUpdateVolumeId: item.lastUpdateVolumeId.toInt(),
        lastUpdateChapterId: item.lastUpdateChapterId.toInt(),
        lastUpdateTime: item.lastUpdateTime.toInt(),
        cover: item.cover,
        hotHits: item.hotHits.toInt(),
        introduction: item.introduction,
        types: item.types,
        authors: item.authors,
        firstLetter: item.firstLetter,
        subscribeNum: item.subscribeNum.toInt(),
      );

  int novelId;
  String name;
  String zone;
  String status;
  String lastUpdateVolumeName;
  String lastUpdateChapterName;
  int lastUpdateVolumeId;
  int lastUpdateChapterId;
  int lastUpdateTime;
  String cover;
  int hotHits;
  String introduction;
  List<String> types;
  String authors;
  String firstLetter;
  int subscribeNum;
  RxList<NovelDetailVolume> volume = RxList<NovelDetailVolume>();
}

class NovelDetailVolume {
  NovelDetailVolume({
    required this.volumeId,
    required this.volumeName,
    required this.volumeOrder,
    required this.chapters,
  });

  factory NovelDetailVolume.fromV4(NovelVolumeDetailProto item) =>
      NovelDetailVolume(
        volumeId: item.volumeId.toInt(),
        volumeName: item.volumeName,
        volumeOrder: item.volumeOrder,
        chapters: item.chapters
            .map(
              (e) => NovelDetailChapter.fromV4(
                  e, item.volumeId.toInt(), item.volumeName),
            )
            .toList(),
      );

  int volumeId;
  String volumeName;
  int volumeOrder;
  List<NovelDetailChapter> chapters;
}

class NovelDetailChapter {
  NovelDetailChapter({
    required this.chapterId,
    required this.chapterName,
    required this.chapterOrder,
    required this.volumeId,
    required this.volumeName,
  });

  factory NovelDetailChapter.fromV4(
          NovelChapterDetailProto item, int volumeId, String volumeName) =>
      NovelDetailChapter(
        chapterId: item.chapterId.toInt(),
        chapterName: item.chapterName,
        chapterOrder: item.chapterOrder,
        volumeId: volumeId,
        volumeName: volumeName,
      );

  int chapterId;
  String chapterName;
  int chapterOrder;
  int volumeId;
  String volumeName;
}
