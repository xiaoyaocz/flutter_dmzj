// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NovelHistoryAdapter extends TypeAdapter<NovelHistory> {
  @override
  final int typeId = 2;

  @override
  NovelHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NovelHistory(
      novelId: fields[0] as int,
      chapterId: fields[1] as int,
      novelName: fields[2] as String,
      novelCover: fields[3] as String,
      chapterName: fields[4] as String,
      updateTime: fields[9] as DateTime,
      index: fields[5] as int,
      total: fields[6] as int,
      volumeId: fields[7] as int,
      volumeName: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NovelHistory obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.novelId)
      ..writeByte(1)
      ..write(obj.chapterId)
      ..writeByte(2)
      ..write(obj.novelName)
      ..writeByte(3)
      ..write(obj.novelCover)
      ..writeByte(4)
      ..write(obj.chapterName)
      ..writeByte(5)
      ..write(obj.index)
      ..writeByte(6)
      ..write(obj.total)
      ..writeByte(7)
      ..write(obj.volumeId)
      ..writeByte(8)
      ..write(obj.volumeName)
      ..writeByte(9)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NovelHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
