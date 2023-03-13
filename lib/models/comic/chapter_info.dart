import 'package:flutter_dmzj/models/comic/chapter_detail_web_model.dart';
import 'package:flutter_dmzj/models/db/comic_download_info.dart';
import 'package:flutter_dmzj/models/proto/comic.pb.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class ComicChapterDetail {
  ComicChapterDetail({
    required this.chapterId,
    required this.comicId,
    required this.chapterOrder,
    required this.direction,
    required this.chapterTitle,
    required this.pageUrls,
    required this.picnum,
    required this.commentCount,
    this.isLocal = false,
  });
  factory ComicChapterDetail.empty() => ComicChapterDetail(
        chapterId: 0,
        comicId: 0,
        chapterOrder: 0,
        direction: 0,
        chapterTitle: "",
        pageUrls: [],
        picnum: 0,
        commentCount: 0,
      );
  factory ComicChapterDetail.fromWebApi(ComicChapterDetailWebModel item) =>
      ComicChapterDetail(
        chapterId: item.id,
        comicId: item.comicId,
        chapterOrder: item.chapterOrder,
        direction: item.direction,
        chapterTitle: item.chapterName,
        pageUrls: item.pageUrl,
        picnum: item.picnum,
        commentCount: item.commentCount,
      );

  factory ComicChapterDetail.fromV4(ComicChapterDetailProto item) =>
      ComicChapterDetail(
        chapterId: item.chapterId.toInt(),
        comicId: item.comicId.toInt(),
        chapterOrder: item.chapterOrder,
        direction: item.direction,
        chapterTitle: item.title,
        pageUrls: item.pageUrlHD.isNotEmpty ? item.pageUrlHD : item.pageUrl,
        picnum: item.picnum,
        commentCount: item.commentCount,
      );

  factory ComicChapterDetail.fromDownload(ComicDownloadInfo item) =>
      ComicChapterDetail(
        chapterId: item.chapterId.toInt(),
        comicId: item.comicId.toInt(),
        chapterOrder: item.chapterSort,
        direction: 1,
        chapterTitle: item.chapterName,
        pageUrls: item.files.map((e) => p.join(item.savePath, e)).toList(),
        picnum: item.files.length,
        commentCount: 0,
        isLocal: true,
      );

  int chapterId;
  int comicId;
  int chapterOrder;
  int direction;
  String chapterTitle;
  List<String> pageUrls;
  int picnum;
  int commentCount;
  bool isLocal;
}
