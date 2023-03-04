import 'dart:convert';

import 'package:flutter_dmzj/models/comic/detail_v1_model.dart';
import 'package:flutter_dmzj/models/proto/comic.pb.dart';
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
    this.isLong = 0,
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
    required this.chapters,
  });

  factory ComicDetailInfo.empty() => ComicDetailInfo(
        types: [],
        status: [],
        authors: [],
        chapters: [],
      );

  factory ComicDetailInfo.fromV4(ComicDetailProto proto) => ComicDetailInfo(
        id: proto.id.toInt(),
        title: proto.title,
        direction: proto.direction.toInt(),
        isLong: proto.islong,
        cover: proto.cover,
        description: proto.description,
        lastUpdateChapterId: proto.lastUpdateChapterId,
        lastUpdatechapterName: proto.lastUpdateChapterName,
        lastUpdatetime: proto.lastUpdatetime.toInt(),
        hitNum: proto.hitNum.toInt(),
        hotNum: proto.hotNum.toInt(),
        subscribeNum: proto.subscribeNum.toInt(),
        firstLetter: proto.firstLetter,
        comicPy: proto.comicPy,
        types: proto.types
            .map(
              (e) => ComicDetailTag(
                tagId: e.tagId.toInt(),
                tagName: e.tagName,
              ),
            )
            .toList(),
        status: proto.status
            .map(
              (e) => ComicDetailTag(
                tagId: e.tagId.toInt(),
                tagName: e.tagName,
              ),
            )
            .toList(),
        authors: proto.authors
            .map(
              (e) => ComicDetailTag(
                tagId: e.tagId.toInt(),
                tagName: e.tagName,
              ),
            )
            .toList(),
        chapters: proto.chapters
            .map(
              (e) => ComicDetailChapter(
                title: e.title,
                data: RxList<ComicDetailChapterItem>(
                  e.data
                      .map(
                        (x) => ComicDetailChapterItem(
                          chapterId: x.chapterId.toInt(),
                          chapterTitle: x.chapterTitle,
                          updateTime: x.updateTime.toInt(),
                          fileSize: x.fileSize,
                          chapterOrder: x.chapterOrder,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      );
  factory ComicDetailInfo.fromV1(ComicDetailV1Model model) {
    var lastChapterId = 0;
    List<ComicDetailChapter> chapter = [];
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
    chapter.add(
      ComicDetailChapter(
          title: "连载", data: RxList<ComicDetailChapterItem>(serialItems)),
    );
    if (aloneItems.isNotEmpty) {
      chapter.add(
        ComicDetailChapter(
            title: "单行本", data: RxList<ComicDetailChapterItem>(aloneItems)),
      );
    }
    return ComicDetailInfo(
      id: int.tryParse(model.info.id) ?? 0,
      title: model.info.title,
      direction: int.tryParse(model.info.direction) ?? 0,
      isLong: int.tryParse(model.info.islong) ?? 0,
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
      chapters: chapter,
    );
  }

  int id;
  String title;
  int direction;
  int isLong;
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
  List<ComicDetailChapter> chapters = [];

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

class ComicDetailChapter {
  ComicDetailChapter({
    required this.title,
    required this.data,
  }) {
    sort();
  }

  String title;
  RxList<ComicDetailChapterItem> data;
  //0倒序,1正序
  var sortType = 0.obs;
  var showAll = false.obs;
  bool get showMoreButton => data.length > 15;

  void sort() {
    if (sortType.value == 0) {
      data.sort((a, b) => b.chapterOrder.compareTo(a.chapterOrder));
    } else {
      data.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
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
  });

  int chapterId;
  String chapterTitle;
  int updateTime;
  int fileSize;
  int chapterOrder;
}
