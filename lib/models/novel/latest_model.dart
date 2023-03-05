import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class NovelLatestModel {
  NovelLatestModel({
    required this.id,
    required this.status,
    required this.name,
    required this.authors,
    required this.cover,
    required this.types,
    required this.lastUpdateChapterId,
    required this.lastUpdateVolumeId,
    required this.lastUpdateVolumeName,
    required this.lastUpdateChapterName,
    required this.lastUpdateTime,
  });

  factory NovelLatestModel.fromJson(Map<String, dynamic> json) {
    final List<String>? types = json['types'] is List ? <String>[] : null;
    if (types != null) {
      for (final dynamic item in json['types']!) {
        if (item != null) {
          types.add(asT<String>(item)!);
        }
      }
    }
    return NovelLatestModel(
      id: asT<int>(json['id'])!,
      status: asT<String>(json['status'])!,
      name: asT<String>(json['name'])!,
      authors: asT<String>(json['authors'])!,
      cover: asT<String>(json['cover'])!,
      types: types!,
      lastUpdateChapterId: asT<int>(json['last_update_chapter_id'])!,
      lastUpdateVolumeId: asT<int>(json['last_update_volume_id'])!,
      lastUpdateVolumeName: asT<String>(json['last_update_volume_name'])!,
      lastUpdateChapterName: asT<String>(json['last_update_chapter_name'])!,
      lastUpdateTime: asT<int>(json['last_update_time'])!,
    );
  }

  int id;
  String status;
  String name;
  String authors;
  String cover;
  List<String> types;
  int lastUpdateChapterId;
  int lastUpdateVolumeId;
  String lastUpdateVolumeName;
  String lastUpdateChapterName;
  int lastUpdateTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'status': status,
        'name': name,
        'authors': authors,
        'cover': cover,
        'types': types,
        'last_update_chapter_id': lastUpdateChapterId,
        'last_update_volume_id': lastUpdateVolumeId,
        'last_update_volume_name': lastUpdateVolumeName,
        'last_update_chapter_name': lastUpdateChapterName,
        'last_update_time': lastUpdateTime,
      };
}
