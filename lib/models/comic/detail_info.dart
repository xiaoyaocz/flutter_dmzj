import 'dart:convert';

import 'package:flutter_dmzj/models/comic/detail_model.dart';
import 'package:flutter_dmzj/models/comic/detail_v1_model.dart';
import 'package:get/get.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicDetailInfo {
  ComicDetailInfo({
    this.id = 0,
    this.title = "",
    this.direction = 0,
    this.isLong = false,
    this.cover = "",
    this.description = "",
    this.lastUpdatetime = 0,
    this.lastUpdatechapterName = "",
    this.firstLetter = "",
    this.comicPy = "",
    this.hotNum = 0,
    this.hitNum = 0,
    this.lastUpdateChapterId = 0,
    required this.types,
    required this.status,
    required this.authors,
    this.subscribeNum = 0,
    required this.volumes,
    this.isHide = false,
    this.isVip = false,
  });

  factory ComicDetailInfo.empty() => ComicDetailInfo(
        types: [],
        status: [],
        authors: [],
        volumes: [],
      );

  factory ComicDetailInfo.fromV4(ComicDetailModel data) => ComicDetailInfo(
        id: data.data.id,
        title: data.data.title,
        direction: data.data.direction ?? 0,
        isLong: data.data.islong == 1,
        cover: data.data.cover ?? "",
        description: data.data.description ?? "",
        lastUpdateChapterId: data.data.lastUpdateChapterId ?? 0,
        lastUpdatechapterName: data.data.lastUpdateChapterName ?? "",
        lastUpdatetime: data.data.lastUpdatetime ?? 0,
        hitNum: 0,
        hotNum: 0,
        subscribeNum: 0,
        firstLetter: data.data.firstLetter ?? "",
        comicPy: data.data.comicPy ?? "",
        isVip: false,
        types: (data.data.types ?? [])
            .map(
              (e) => ComicDetailTag(
                tagId: e.tagId.toInt(),
                tagName: e.tagName,
              ),
            )
            .toList(),
        status: (data.data.status ?? [])
            .map(
              (e) => ComicDetailTag(
                tagId: e.tagId.toInt(),
                tagName: e.tagName,
              ),
            )
            .toList(),
        authors: (data.data.authors ?? [])
            .map(
              (e) => ComicDetailTag(
                tagId: e.tagId,
                tagName: e.tagName,
              ),
            )
            .toList(),
        volumes: (data.data.chapters ?? [])
            .map(
              (e) => ComicDetailVolume(
                title: e.title!,
                chapters: RxList<ComicDetailChapterItem>(
                  (e.data ?? [])
                      .map(
                        (x) => ComicDetailChapterItem(
                          chapterId: x.chapterId.toInt(),
                          chapterTitle: x.chapterTitle,
                          updateTime: x.updatetime ?? 0,
                          fileSize: 0,
                          chapterOrder: x.chapterOrder,
                          isVip: false,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      );
  factory ComicDetailInfo.fromV1(ComicDetailV1Model model,
      {bool isHide = false}) {
    var lastChapterId = 0;
    List<ComicDetailVolume> volumes = [];
    List<ComicDetailChapterItem> serialItems = [];
    List<ComicDetailChapterItem> aloneItems = [];
    for (var item in model.list) {
      serialItems.add(
        ComicDetailChapterItem(
          chapterId: int.tryParse(item.id) ?? 0,
          chapterTitle: item.chapterName,
          updateTime: int.tryParse(item.updatetime) ?? 0,
          fileSize: int.tryParse(item.filesize) ?? 0,
          chapterOrder: int.tryParse(item.chapterOrder) ?? 0,
        ),
      );
    }
    for (var item in model.alone) {
      aloneItems.add(
        ComicDetailChapterItem(
          chapterId: int.tryParse(item.id) ?? 0,
          chapterTitle: item.chapterName,
          updateTime: int.tryParse(item.updatetime) ?? 0,
          fileSize: int.tryParse(item.filesize) ?? 0,
          chapterOrder: int.tryParse(item.chapterOrder) ?? 0,
        ),
      );
    }
    if (serialItems.isNotEmpty) {
      lastChapterId = serialItems.last.chapterId;
    }
    volumes.add(
      ComicDetailVolume(
          title: isHide ? "神隐" : "连载",
          chapters: RxList<ComicDetailChapterItem>(serialItems)),
    );
    if (aloneItems.isNotEmpty) {
      volumes.add(
        ComicDetailVolume(
            title: isHide ? "神隐-单行本" : "单行本",
            chapters: RxList<ComicDetailChapterItem>(aloneItems)),
      );
    }
    return ComicDetailInfo(
      id: int.tryParse(model.info.id) ?? 0,
      title: model.info.title,
      direction: int.tryParse(model.info.direction) ?? 0,
      isLong: (int.tryParse(model.info.islong) ?? 0) == 1,
      cover: model.info.cover,
      description: model.info.description,
      lastUpdateChapterId: lastChapterId,
      lastUpdatechapterName: model.info.lastUpdateChapterName,
      lastUpdatetime: int.tryParse(model.info.lastUpdatetime) ?? 0,
      hitNum: 0,
      hotNum: 0,
      subscribeNum: 0,
      firstLetter: model.info.firstLetter,
      comicPy: "",
      isHide: isHide,
      types: model.info.types
          .split("/")
          .map(
            (e) => ComicDetailTag(
              tagId: 0,
              tagName: e,
            ),
          )
          .toList(),
      status: [
        ComicDetailTag(
          tagId: 0,
          tagName: model.info.status,
        )
      ],
      authors: model.info.authors
          .split("/")
          .map(
            (e) => ComicDetailTag(
              tagId: 0,
              tagName: e,
            ),
          )
          .toList(),
      volumes: volumes,
    );
  }

  int id;
  String title;
  int direction;
  bool isLong;
  String cover;
  String description;
  int lastUpdatetime;
  String lastUpdatechapterName;
  String firstLetter;
  String comicPy;
  int hotNum;
  int hitNum;
  int lastUpdateChapterId;
  List<ComicDetailTag> types = [];
  List<ComicDetailTag> status = [];
  List<ComicDetailTag> authors = [];
  int subscribeNum;
  List<ComicDetailVolume> volumes = [];

  bool isVip;

  /// 是否神隐
  bool isHide;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class ComicDetailTag {
  ComicDetailTag({
    required this.tagId,
    required this.tagName,
  });

  int tagId;
  String tagName;
}

class ComicDetailVolume {
  ComicDetailVolume({
    required this.title,
    required this.chapters,
  }) {
    sort();
  }

  String title;
  RxList<ComicDetailChapterItem> chapters;
  //0倒序,1正序
  var sortType = 0.obs;
  var showAll = false.obs;
  bool get showMoreButton => chapters.length > 15;

  void sort() {
    if (sortType.value == 0) {
      chapters.sort((a, b) => b.chapterOrder.compareTo(a.chapterOrder));
    } else {
      chapters.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
    }
  }
}

class ComicDetailChapterItem {
  ComicDetailChapterItem({
    required this.chapterId,
    required this.chapterTitle,
    required this.updateTime,
    required this.fileSize,
    required this.chapterOrder,
    this.isVip = false,
  });

  int chapterId;
  String chapterTitle;
  int updateTime;
  int fileSize;
  int chapterOrder;

  bool isVip;
}
