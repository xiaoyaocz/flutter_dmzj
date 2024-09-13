import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicDetailModel {
  ComicDetailModel({
    required this.data,
    required this.readingRecord,
  });

  factory ComicDetailModel.fromJson(Map<String, dynamic> json) =>
      ComicDetailModel(
        data: ComicDetailDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
        readingRecord: ComicDetailReadingRecordModel.fromJson(
            asT<Map<String, dynamic>>(json['readingRecord'])!),
      );

  ComicDetailDataModel data;
  ComicDetailReadingRecordModel readingRecord;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'readingRecord': readingRecord,
      };
}

class ComicDetailDataModel {
  ComicDetailDataModel({
    required this.id,
    required this.title,
    this.direction,
    this.islong,
    this.cover,
    this.description,
    this.lastUpdatetime,
    this.lastUpdateChapterName,
    this.firstLetter,
    this.comicPy,
    this.lastUpdateChapterId,
    this.types,
    this.status,
    this.authors,
    this.chapters,
    this.dhUrlLinks,
  });

  factory ComicDetailDataModel.fromJson(Map<String, dynamic> json) {
    final List<ComicDetailDataTagModel>? types =
        json['types'] is List ? <ComicDetailDataTagModel>[] : null;
    if (types != null) {
      for (final dynamic item in json['types']!) {
        if (item != null) {
          types.add(ComicDetailDataTagModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<ComicDetailDataTagModel>? status =
        json['status'] is List ? <ComicDetailDataTagModel>[] : null;
    if (status != null) {
      for (final dynamic item in json['status']!) {
        if (item != null) {
          status.add(ComicDetailDataTagModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<ComicDetailDataTagModel>? authors =
        json['authors'] is List ? <ComicDetailDataTagModel>[] : null;
    if (authors != null) {
      for (final dynamic item in json['authors']!) {
        if (item != null) {
          authors.add(ComicDetailDataTagModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<ComicDetailChapterModel>? chapters =
        json['chapters'] is List ? <ComicDetailChapterModel>[] : null;
    if (chapters != null) {
      for (final dynamic item in json['chapters']!) {
        if (item != null) {
          chapters.add(ComicDetailChapterModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<DhUrlLinks>? dhUrlLinks =
        json['dh_url_links'] is List ? <DhUrlLinks>[] : null;
    if (dhUrlLinks != null) {
      for (final dynamic item in json['dh_url_links']!) {
        if (item != null) {
          dhUrlLinks.add(DhUrlLinks.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicDetailDataModel(
      id: asT<int>(json['id'])!,
      title: asT<String>(json['title'])!,
      direction: asT<int?>(json['direction']),
      islong: asT<int?>(json['islong']),
      cover: asT<String?>(json['cover']),
      description: asT<String?>(json['description']),
      lastUpdatetime: asT<int?>(json['last_updatetime']),
      lastUpdateChapterName: asT<String?>(json['last_update_chapter_name']),
      firstLetter: asT<String?>(json['first_letter']),
      comicPy: asT<String?>(json['comic_py']),
      lastUpdateChapterId: asT<int?>(json['last_update_chapter_id']),
      types: types,
      status: status,
      authors: authors,
      chapters: chapters,
      dhUrlLinks: dhUrlLinks,
    );
  }

  int id;
  String title;
  int? direction;
  int? islong;
  String? cover;
  String? description;
  int? lastUpdatetime;
  String? lastUpdateChapterName;
  String? firstLetter;
  String? comicPy;
  int? lastUpdateChapterId;
  List<ComicDetailDataTagModel>? types;
  List<ComicDetailDataTagModel>? status;
  List<ComicDetailDataTagModel>? authors;
  List<ComicDetailChapterModel>? chapters;
  List<DhUrlLinks>? dhUrlLinks;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'direction': direction,
        'islong': islong,
        'cover': cover,
        'description': description,
        'last_updatetime': lastUpdatetime,
        'last_update_chapter_name': lastUpdateChapterName,
        'first_letter': firstLetter,
        'comic_py': comicPy,
        'last_update_chapter_id': lastUpdateChapterId,
        'types': types,
        'status': status,
        'authors': authors,
        'chapters': chapters,
        'dh_url_links': dhUrlLinks,
      };
}

class ComicDetailDataTagModel {
  ComicDetailDataTagModel({
    required this.tagId,
    required this.tagName,
  });

  factory ComicDetailDataTagModel.fromJson(Map<String, dynamic> json) =>
      ComicDetailDataTagModel(
        tagId: asT<int>(json['tag_id'])!,
        tagName: asT<String>(json['tag_name'])!,
      );

  int tagId;
  String tagName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tag_id': tagId,
        'tag_name': tagName,
      };
}

class ComicDetailChapterModel {
  ComicDetailChapterModel({
    this.title,
    this.data,
  });

  factory ComicDetailChapterModel.fromJson(Map<String, dynamic> json) {
    final List<ComicDetailChapterDataModel>? data =
        json['data'] is List ? <ComicDetailChapterDataModel>[] : null;
    if (data != null) {
      for (final dynamic item in json['data']!) {
        if (item != null) {
          data.add(ComicDetailChapterDataModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ComicDetailChapterModel(
      title: asT<String?>(json['title']),
      data: data,
    );
  }

  String? title;
  List<ComicDetailChapterDataModel>? data;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'data': data,
      };
}

class ComicDetailChapterDataModel {
  ComicDetailChapterDataModel({
    required this.chapterId,
    required this.chapterTitle,
    this.updatetime,
    required this.chapterOrder,
  });

  factory ComicDetailChapterDataModel.fromJson(Map<String, dynamic> json) =>
      ComicDetailChapterDataModel(
        chapterId: asT<int>(json['chapter_id'])!,
        chapterTitle: asT<String>(json['chapter_title'])!,
        updatetime: asT<int?>(json['updatetime']),
        chapterOrder: asT<int>(json['chapter_order'])!,
      );

  int chapterId;
  String chapterTitle;
  int? updatetime;
  int chapterOrder;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chapter_id': chapterId,
        'chapter_title': chapterTitle,
        'updatetime': updatetime,
        'chapter_order': chapterOrder,
      };
}

class DhUrlLinks {
  DhUrlLinks({
    this.title,
  });

  factory DhUrlLinks.fromJson(Map<String, dynamic> json) => DhUrlLinks(
        title: asT<String?>(json['title']),
      );

  String? title;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
      };
}

class ComicDetailReadingRecordModel {
  ComicDetailReadingRecordModel({
    this.typeName,
    this.uid,
    this.source,
    this.bizId,
    this.chapterId,
    this.viewingTime,
    this.record,
    this.volumeId,
    this.totalNum,
    this.chapterName,
    this.volumeName,
  });

  factory ComicDetailReadingRecordModel.fromJson(Map<String, dynamic> json) =>
      ComicDetailReadingRecordModel(
        typeName: asT<String?>(json['type_name']),
        uid: asT<int?>(json['uid']),
        source: asT<int?>(json['source']),
        bizId: asT<int?>(json['biz_id']),
        chapterId: asT<int?>(json['chapter_id']),
        viewingTime: asT<int?>(json['viewing_time']),
        record: asT<int?>(json['record']),
        volumeId: asT<int?>(json['volume_id']),
        totalNum: asT<int?>(json['total_num']),
        chapterName: asT<String?>(json['chapter_name']),
        volumeName: asT<String?>(json['volume_name']),
      );

  String? typeName;
  int? uid;
  int? source;
  int? bizId;
  int? chapterId;
  int? viewingTime;
  int? record;
  int? volumeId;
  int? totalNum;
  String? chapterName;
  String? volumeName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type_name': typeName,
        'uid': uid,
        'source': source,
        'biz_id': bizId,
        'chapter_id': chapterId,
        'viewing_time': viewingTime,
        'record': record,
        'volume_id': volumeId,
        'total_num': totalNum,
        'chapter_name': chapterName,
        'volume_name': volumeName,
      };
}
