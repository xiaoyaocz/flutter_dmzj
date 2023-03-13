import 'package:hive/hive.dart';
part 'download_status.g.dart';

/// 下载状态
@HiveType(typeId: 4)
enum DownloadStatus {
  /// 等待下载中
  @HiveField(0)
  wait,

  /// 正在读取章节信息
  @HiveField(1)
  loadding,

  /// 下载中
  @HiveField(2)
  downloading,

  /// 使用数据，自动暂停，当网络切换时恢复下载
  @HiveField(3)
  pauseCellular,

  /// 暂停
  @HiveField(4)
  pause,

  /// 已完成
  @HiveField(5)
  complete,

  /// 读取信息时出现错误
  @HiveField(6)
  errorLoad,

  /// 下载出错
  @HiveField(7)
  error,

  /// 已取消
  @HiveField(8)
  cancel,

  /// 等待网络连接
  @HiveField(9)
  waitNetwork,
}
