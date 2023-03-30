// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_download_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComicDownloadInfoAdapter extends TypeAdapter<ComicDownloadInfo> {
  @override
  final int typeId = 3;

  @override
  ComicDownloadInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComicDownloadInfo(
      addTime: fields[13] as DateTime,
      chapterId: fields[4] as int,
      chapterSort: fields[7] as int,
      comicCover: fields[3] as String,
      comicId: fields[1] as int,
      comicName: fields[2] as String,
      files: (fields[9] as List).cast<String>(),
      index: fields[10] as int,
      savePath: fields[8] as String,
      status: fields[12] as DownloadStatus,
      taskId: fields[0] as String,
      total: fields[11] as int,
      volumeName: fields[6] as String,
      urls: (fields[14] as List).cast<String>(),
      chapterName: fields[5] as String,
      isVip: (fields[15] ?? false) as bool,
      isLongComic: (fields[16] ?? false) as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ComicDownloadInfo obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.comicId)
      ..writeByte(2)
      ..write(obj.comicName)
      ..writeByte(3)
      ..write(obj.comicCover)
      ..writeByte(4)
      ..write(obj.chapterId)
      ..writeByte(5)
      ..write(obj.chapterName)
      ..writeByte(6)
      ..write(obj.volumeName)
      ..writeByte(7)
      ..write(obj.chapterSort)
      ..writeByte(8)
      ..write(obj.savePath)
      ..writeByte(9)
      ..write(obj.files)
      ..writeByte(10)
      ..write(obj.index)
      ..writeByte(11)
      ..write(obj.total)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.addTime)
      ..writeByte(14)
      ..write(obj.urls)
      ..writeByte(15)
      ..write(obj.isVip)
      ..writeByte(16)
      ..write(obj.isLongComic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicDownloadInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
