// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComicHistoryAdapter extends TypeAdapter<ComicHistory> {
  @override
  final int typeId = 1;

  @override
  ComicHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComicHistory(
      comicId: fields[0] as int,
      chapterId: fields[1] as int,
      comicName: fields[2] as String,
      comicCover: fields[3] as String,
      chapterName: fields[4] as String,
      updateTime: fields[6] as DateTime,
      page: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ComicHistory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.comicId)
      ..writeByte(1)
      ..write(obj.chapterId)
      ..writeByte(2)
      ..write(obj.comicName)
      ..writeByte(3)
      ..write(obj.comicCover)
      ..writeByte(4)
      ..write(obj.chapterName)
      ..writeByte(5)
      ..write(obj.page)
      ..writeByte(6)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComicHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
