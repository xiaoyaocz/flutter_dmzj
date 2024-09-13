import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelDetailModel {
  NovelDetailModel({
    required this.data,
    required this.readingRecord,
  });

  factory NovelDetailModel.fromJson(Map<String, dynamic> json) =>
      NovelDetailModel(
        data: NovelDetailDataModel.fromJson(
            asT<Map<String, dynamic>>(json['data'])!),
        readingRecord: NovelDetailReadingRecordModel.fromJson(
            asT<Map<String, dynamic>>(json['readingRecord'])!),
      );

  NovelDetailDataModel data;
  NovelDetailReadingRecordModel readingRecord;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data,
        'readingRecord': readingRecord,
      };
}

class NovelDetailDataModel {
  NovelDetailDataModel({
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
    required this.volume,
  });

  factory NovelDetailDataModel.fromJson(Map<String, dynamic> json) {
    final List<String>? types = json['types'] is List ? <String>[] : null;
    if (types != null) {
      for (final dynamic item in json['types']!) {
        if (item != null) {
          types.add(asT<String>(item)!);
        }
      }
    }

    final List<Volume>? volume = json['volume'] is List ? <Volume>[] : null;
    if (volume != null) {
      for (final dynamic item in json['volume']!) {
        if (item != null) {
          volume.add(Volume.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return NovelDetailDataModel(
      novelId: asT<int>(json['novel_id'])!,
      name: asT<String>(json['name'])!,
      zone: asT<String>(json['zone'])!,
      status: asT<String>(json['status'])!,
      lastUpdateVolumeName: asT<String>(json['last_update_volume_name'])!,
      lastUpdateChapterName: asT<String>(json['last_update_chapter_name'])!,
      lastUpdateVolumeId: asT<int>(json['last_update_volume_id'])!,
      lastUpdateChapterId: asT<int>(json['last_update_chapter_id'])!,
      lastUpdateTime: asT<int>(json['last_update_time'])!,
      cover: asT<String>(json['cover'])!,
      hotHits: asT<int?>(json['hot_hits']) ?? 0,
      introduction: asT<String>(json['introduction'])!,
      types: types!,
      authors: asT<String>(json['authors'])!,
      firstLetter: asT<String>(json['first_letter'])!,
      volume: volume!,
    );
  }

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
  List<Volume> volume;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'novel_id': novelId,
        'name': name,
        'zone': zone,
        'status': status,
        'last_update_volume_name': lastUpdateVolumeName,
        'last_update_chapter_name': lastUpdateChapterName,
        'last_update_volume_id': lastUpdateVolumeId,
        'last_update_chapter_id': lastUpdateChapterId,
        'last_update_time': lastUpdateTime,
        'cover': cover,
        'hot_hits': hotHits,
        'introduction': introduction,
        'types': types,
        'authors': authors,
        'first_letter': firstLetter,
        'volume': volume,
      };
}

class Volume {
  Volume({
    required this.volumeId,
    required this.lnovelId,
    required this.volumeName,
    required this.volumeOrder,
    required this.addtime,
    required this.sumChapters,
  });

  factory Volume.fromJson(Map<String, dynamic> json) => Volume(
        volumeId: asT<int>(json['volume_id'])!,
        lnovelId: asT<int>(json['lnovel_id'])!,
        volumeName: asT<String>(json['volume_name'])!,
        volumeOrder: asT<int>(json['volume_order'])!,
        addtime: asT<int>(json['addtime'])!,
        sumChapters: asT<int>(json['sum_chapters'])!,
      );

  int volumeId;
  int lnovelId;
  String volumeName;
  int volumeOrder;
  int addtime;
  int sumChapters;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'volume_id': volumeId,
        'lnovel_id': lnovelId,
        'volume_name': volumeName,
        'volume_order': volumeOrder,
        'addtime': addtime,
        'sum_chapters': sumChapters,
      };
}

class NovelDetailReadingRecordModel {
  NovelDetailReadingRecordModel({
    required this.typeName,
    required this.uid,
    required this.source,
    required this.bizId,
    required this.chapterId,
    required this.viewingTime,
    required this.record,
    required this.volumeId,
    required this.totalNum,
    required this.chapterName,
    required this.volumeName,
  });

  factory NovelDetailReadingRecordModel.fromJson(Map<String, dynamic> json) =>
      NovelDetailReadingRecordModel(
        typeName: asT<String>(json['type_name'])!,
        uid: asT<int>(json['uid'])!,
        source: asT<int>(json['source'])!,
        bizId: asT<int>(json['biz_id'])!,
        chapterId: asT<int>(json['chapter_id'])!,
        viewingTime: asT<int>(json['viewing_time'])!,
        record: asT<int>(json['record'])!,
        volumeId: asT<int>(json['volume_id'])!,
        totalNum: asT<int>(json['total_num'])!,
        chapterName: asT<String>(json['chapter_name'])!,
        volumeName: asT<String>(json['volume_name'])!,
      );

  String typeName;
  int uid;
  int source;
  int bizId;
  int chapterId;
  int viewingTime;
  int record;
  int volumeId;
  int totalNum;
  String chapterName;
  String volumeName;

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
