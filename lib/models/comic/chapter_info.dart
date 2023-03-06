import 'package:flutter_dmzj/models/comic/chapter_detail_web_model.dart';
import 'package:flutter_dmzj/models/proto/comic.pb.dart';

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

  int chapterId;
  int comicId;
  int chapterOrder;
  int direction;
  String chapterTitle;
  List<String> pageUrls;
  int picnum;
  int commentCount;
}
