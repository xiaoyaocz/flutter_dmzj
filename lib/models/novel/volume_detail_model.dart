import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelVolumeDetailModel {
  NovelVolumeDetailModel({
    required this.volumeId,
    required this.volumeName,
    required this.volumeOrder,
    required this.chapters,
  });

  factory NovelVolumeDetailModel.fromJson(Map<String, dynamic> json) {
    final List<NovelVolumeDetailChapterModel>? chapters =
        json['chapters'] is List ? <NovelVolumeDetailChapterModel>[] : null;
    if (chapters != null) {
      for (final dynamic item in json['chapters']!) {
        if (item != null) {
          chapters.add(NovelVolumeDetailChapterModel.fromJson(
              asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return NovelVolumeDetailModel(
      volumeId: asT<int>(json['volume_id'])!,
      volumeName: asT<String>(json['volume_name'])!,
      volumeOrder: asT<int>(json['volume_order'])!,
      chapters: chapters!,
    );
  }

  int volumeId;
  String volumeName;
  int volumeOrder;
  List<NovelVolumeDetailChapterModel> chapters;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'volume_id': volumeId,
        'volume_name': volumeName,
        'volume_order': volumeOrder,
        'chapters': chapters,
      };
}

class NovelVolumeDetailChapterModel {
  NovelVolumeDetailChapterModel({
    required this.chapterId,
    required this.chapterName,
    required this.chapterOrder,
  });

  factory NovelVolumeDetailChapterModel.fromJson(Map<String, dynamic> json) =>
      NovelVolumeDetailChapterModel(
        chapterId: asT<int>(json['chapter_id'])!,
        chapterName: asT<String>(json['chapter_name'])!,
        chapterOrder: asT<int>(json['chapter_order'])!,
      );

  int chapterId;
  String chapterName;
  int chapterOrder;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chapter_id': chapterId,
        'chapter_name': chapterName,
        'chapter_order': chapterOrder,
      };
}
