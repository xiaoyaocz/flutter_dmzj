import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicChapterDetailWebModel {
  ComicChapterDetailWebModel({
    required this.id,
    required this.comicId,
    required this.chapterName,
    required this.chapterOrder,
    required this.createtime,
    required this.folder,
    required this.pageUrl,
    required this.chapterType,
    required this.chaptertype,
    required this.chapterTrueType,
    required this.chapterNum,
    required this.updatetime,
    required this.sumPages,
    required this.snsTag,
    required this.uid,
    required this.username,
    required this.translatorid,
    required this.translator,
    required this.link,
    required this.message,
    required this.download,
    required this.hidden,
    required this.direction,
    required this.filesize,
    required this.highFileSize,
    required this.picnum,
    required this.hit,
    required this.nextChapId,
    required this.prevChapId,
    required this.commentCount,
  });

  factory ComicChapterDetailWebModel.fromJson(Map<String, dynamic> json) {
    final List<String>? pageUrl = json['page_url'] is List ? <String>[] : null;
    if (pageUrl != null) {
      for (final dynamic item in json['page_url']!) {
        if (item != null) {
          pageUrl.add(asT<String>(item)!);
        }
      }
    }
    return ComicChapterDetailWebModel(
      id: asT<int>(json['id'])!,
      comicId: asT<int>(json['comic_id'])!,
      chapterName: asT<String>(json['chapter_name'])!,
      chapterOrder: asT<int>(json['chapter_order'])!,
      createtime: asT<int>(json['createtime'])!,
      folder: asT<String>(json['folder'])!,
      pageUrl: pageUrl!,
      chapterType: asT<int>(json['chapter_type'])!,
      chaptertype: asT<int>(json['chaptertype'])!,
      chapterTrueType: asT<int>(json['chapter_true_type'])!,
      chapterNum: asT<int>(json['chapter_num']) ?? 0,
      updatetime: asT<int>(json['updatetime'])!,
      sumPages: asT<int>(json['sum_pages'])!,
      snsTag: asT<int>(json['sns_tag'])!,
      uid: asT<int>(json['uid'])!,
      username: asT<String>(json['username'])!,
      translatorid: asT<String>(json['translatorid'])!,
      translator: asT<String>(json['translator'])!,
      link: asT<String>(json['link'])!,
      message: asT<String>(json['message'])!,
      download: asT<String>(json['download'])!,
      hidden: asT<int>(json['hidden'])!,
      direction: asT<int>(json['direction']) ?? 0,
      filesize: asT<int>(json['filesize']) ?? 0,
      highFileSize: asT<int>(json['high_file_size']) ?? 0,
      picnum: asT<int>(json['picnum']) ?? 0,
      hit: asT<int>(json['hit'])!,
      nextChapId: asT<int?>(json['next_chap_id']) ?? 0,
      prevChapId: asT<int?>(json['prev_chap_id']) ?? 0,
      commentCount: asT<int>(json['comment_count'])!,
    );
  }

  int id;
  int comicId;
  String chapterName;
  int chapterOrder;
  int createtime;
  String folder;
  List<String> pageUrl;
  int chapterType;
  int chaptertype;
  int chapterTrueType;
  int chapterNum;
  int updatetime;
  int sumPages;
  int snsTag;
  int uid;
  String username;
  String translatorid;
  String translator;
  String link;
  String message;
  String download;
  int hidden;
  int direction;
  int filesize;
  int highFileSize;
  int picnum;
  int hit;
  int nextChapId;
  int prevChapId;
  int commentCount;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'comic_id': comicId,
        'chapter_name': chapterName,
        'chapter_order': chapterOrder,
        'createtime': createtime,
        'folder': folder,
        'page_url': pageUrl,
        'chapter_type': chapterType,
        'chaptertype': chaptertype,
        'chapter_true_type': chapterTrueType,
        'chapter_num': chapterNum,
        'updatetime': updatetime,
        'sum_pages': sumPages,
        'sns_tag': snsTag,
        'uid': uid,
        'username': username,
        'translatorid': translatorid,
        'translator': translator,
        'link': link,
        'message': message,
        'download': download,
        'hidden': hidden,
        'direction': direction,
        'filesize': filesize,
        'high_file_size': highFileSize,
        'picnum': picnum,
        'hit': hit,
        'next_chap_id': nextChapId,
        'prev_chap_id': prevChapId,
        'comment_count': commentCount,
      };
}
