import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ComicDetailV1Model {
  ComicDetailV1Model({
    required this.info,
    required this.list,
    required this.alone,
  });

  factory ComicDetailV1Model.fromJson(Map<String, dynamic> json) {
    final List<ComicDetailV1ChapterModel>? list =
        json['list'] is List ? <ComicDetailV1ChapterModel>[] : null;
    if (list != null) {
      for (final dynamic item in json['list']!) {
        if (item != null) {
          list.add(ComicDetailV1ChapterModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    final List<ComicDetailV1ChapterModel>? alone =
        json['alone'] is List ? <ComicDetailV1ChapterModel>[] : null;
    if (alone != null) {
      for (final dynamic item in json['alone']!) {
        if (item != null) {
          alone.add(ComicDetailV1ChapterModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    return ComicDetailV1Model(
      info: ComicDetailV1InfoModel.fromJson(
          asT<Map<String, dynamic>>(json['info'])!),
      list: list!,
      alone: alone!,
    );
  }

  ComicDetailV1InfoModel info;
  List<ComicDetailV1ChapterModel> list;
  List<ComicDetailV1ChapterModel> alone;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'info': info,
        'list': list,
        'alone': alone,
      };
}

class ComicDetailV1InfoModel {
  ComicDetailV1InfoModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.types,
    required this.zone,
    required this.status,
    required this.lastUpdateChapterName,
    required this.lastUpdatetime,
    required this.cover,
    required this.authors,
    required this.description,
    required this.firstLetter,
    required this.direction,
    required this.islong,
    required this.copyright,
  });

  factory ComicDetailV1InfoModel.fromJson(Map<String, dynamic> json) =>
      ComicDetailV1InfoModel(
        id: asT<String>(json['id'])!,
        title: asT<String>(json['title'])!,
        subtitle: asT<String>(json['subtitle'])!,
        types: asT<String>(json['types'])!,
        zone: asT<String>(json['zone'])!,
        status: asT<String>(json['status'])!,
        lastUpdateChapterName: asT<String>(json['last_update_chapter_name'])!,
        lastUpdatetime: asT<String>(json['last_updatetime'])!,
        cover: asT<String>(json['cover'])!,
        authors: asT<String>(json['authors'])!,
        description: asT<String>(json['description'])!,
        firstLetter: asT<String>(json['first_letter'])!,
        direction: asT<String>(json['direction'])!,
        islong: asT<String>(json['islong'])!,
        copyright: asT<String>(json['copyright'])!,
      );

  String id;
  String title;
  String subtitle;
  String types;
  String zone;
  String status;
  String lastUpdateChapterName;
  String lastUpdatetime;
  String cover;
  String authors;
  String description;
  String firstLetter;
  String direction;
  String islong;
  String copyright;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'types': types,
        'zone': zone,
        'status': status,
        'last_update_chapter_name': lastUpdateChapterName,
        'last_updatetime': lastUpdatetime,
        'cover': cover,
        'authors': authors,
        'description': description,
        'first_letter': firstLetter,
        'direction': direction,
        'islong': islong,
        'copyright': copyright,
      };
}

class ComicDetailV1ChapterModel {
  ComicDetailV1ChapterModel({
    required this.id,
    required this.comicId,
    required this.chapterName,
    required this.chapterOrder,
    required this.filesize,
    required this.createtime,
    required this.updatetime,
  });

  factory ComicDetailV1ChapterModel.fromJson(Map<String, dynamic> json) =>
      ComicDetailV1ChapterModel(
        id: asT<String>(json['id'])!,
        comicId: asT<String>(json['comic_id'])!,
        chapterName: asT<String>(json['chapter_name'])!,
        chapterOrder: asT<String>(json['chapter_order'])!,
        filesize: asT<String>(json['filesize'])!,
        createtime: asT<String>(json['createtime'])!,
        updatetime: asT<String>(json['updatetime'])!,
      );

  String id;
  String comicId;
  String chapterName;
  String chapterOrder;
  String filesize;
  String createtime;
  String updatetime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'comic_id': comicId,
        'chapter_name': chapterName,
        'chapter_order': chapterOrder,
        'filesize': filesize,
        'createtime': createtime,
        'updatetime': updatetime,
      };
}
