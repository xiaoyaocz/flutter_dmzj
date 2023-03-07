import 'package:hive/hive.dart';
part 'novel_history.g.dart';

@HiveType(typeId: 2)
class NovelHistory {
  NovelHistory({
    required this.novelId,
    required this.chapterId,
    required this.novelName,
    required this.novelCover,
    required this.chapterName,
    required this.updateTime,
    required this.index,
    required this.total,
    required this.volumeId,
    required this.volumeName,
  });

  @HiveField(0)
  int novelId;

  @HiveField(1)
  int chapterId;

  @HiveField(2)
  String novelName;

  @HiveField(3)
  String novelCover;

  @HiveField(4)
  String chapterName;

  @HiveField(5)
  int index;

  @HiveField(6)
  int total;

  @HiveField(7)
  int volumeId;

  @HiveField(8)
  String volumeName;

  @HiveField(9)
  DateTime updateTime;
}
