// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_download_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovelDownloadInfoAdapter extends TypeAdapter<NovelDownloadInfo> {
  @override
  final int typeId = 5;

  @override
  NovelDownloadInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NovelDownloadInfo(
      addTime: fields[16] as DateTime,
      chapterId: fields[4] as int,
      chapterSort: fields[9] as int,
      novelCover: fields[3] as String,
      novelId: fields[1] as int,
      novelName: fields[2] as String,
      fileName: fields[11] as String,
      imageFiles: (fields[13] as List).cast<String>(),
      savePath: fields[10] as String,
      status: fields[15] as DownloadStatus,
      taskId: fields[0] as String,
      isImage: fields[12] as bool,
      volumeName: fields[7] as String,
      progress: fields[14] as int,
      chapterName: fields[5] as String,
      volumeID: fields[6] as int,
      isVip: fields[17] as bool,
      volumeOrder: fields[8] as int,
      imageUrls: (fields[18] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NovelDownloadInfo obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.novelId)
      ..writeByte(2)
      ..write(obj.novelName)
      ..writeByte(3)
      ..write(obj.novelCover)
      ..writeByte(4)
      ..write(obj.chapterId)
      ..writeByte(5)
      ..write(obj.chapterName)
      ..writeByte(6)
      ..write(obj.volumeID)
      ..writeByte(7)
      ..write(obj.volumeName)
      ..writeByte(8)
      ..write(obj.volumeOrder)
      ..writeByte(9)
      ..write(obj.chapterSort)
      ..writeByte(10)
      ..write(obj.savePath)
      ..writeByte(11)
      ..write(obj.fileName)
      ..writeByte(12)
      ..write(obj.isImage)
      ..writeByte(13)
      ..write(obj.imageFiles)
      ..writeByte(14)
      ..write(obj.progress)
      ..writeByte(15)
      ..write(obj.status)
      ..writeByte(16)
      ..write(obj.addTime)
      ..writeByte(17)
      ..write(obj.isVip)
      ..writeByte(18)
      ..write(obj.imageUrls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelDownloadInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
