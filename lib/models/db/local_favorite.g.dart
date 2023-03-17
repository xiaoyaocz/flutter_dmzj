// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalFavoriteAdapter extends TypeAdapter<LocalFavorite> {
  @override
  final int typeId = 6;

  @override
  LocalFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalFavorite(
      id: fields[0] as String,
      objId: fields[1] as int,
      title: fields[2] as String,
      cover: fields[3] as String,
      type: fields[4] as int,
      updateTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalFavorite obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.objId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.cover)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalFavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
