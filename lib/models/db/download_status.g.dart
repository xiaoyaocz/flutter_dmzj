// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadStatusAdapter extends TypeAdapter<DownloadStatus> {
  @override
  final int typeId = 4;

  @override
  DownloadStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DownloadStatus.wait;
      case 1:
        return DownloadStatus.loadding;
      case 2:
        return DownloadStatus.downloading;
      case 3:
        return DownloadStatus.pauseCellular;
      case 4:
        return DownloadStatus.pause;
      case 5:
        return DownloadStatus.complete;
      case 6:
        return DownloadStatus.errorLoad;
      case 7:
        return DownloadStatus.error;
      case 8:
        return DownloadStatus.cancel;
      case 9:
        return DownloadStatus.waitNetwork;
      default:
        return DownloadStatus.wait;
    }
  }

  @override
  void write(BinaryWriter writer, DownloadStatus obj) {
    switch (obj) {
      case DownloadStatus.wait:
        writer.writeByte(0);
        break;
      case DownloadStatus.loadding:
        writer.writeByte(1);
        break;
      case DownloadStatus.downloading:
        writer.writeByte(2);
        break;
      case DownloadStatus.pauseCellular:
        writer.writeByte(3);
        break;
      case DownloadStatus.pause:
        writer.writeByte(4);
        break;
      case DownloadStatus.complete:
        writer.writeByte(5);
        break;
      case DownloadStatus.errorLoad:
        writer.writeByte(6);
        break;
      case DownloadStatus.error:
        writer.writeByte(7);
        break;
      case DownloadStatus.cancel:
        writer.writeByte(8);
        break;
      case DownloadStatus.waitNetwork:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
