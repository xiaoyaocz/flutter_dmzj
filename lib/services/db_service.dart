import 'package:flutter_dmzj/models/db/comic_history.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DBService extends GetxService {
  static DBService get instance => Get.find<DBService>();
  late Box newsLikeBox;
  late Box<ComicHistory> comicHistoryBox;
  Future init() async {
    newsLikeBox = await Hive.openBox("NewsLike");
    comicHistoryBox = await Hive.openBox("ComicHistory");
  }

  void addComicHistory(ComicHistory history) {
    comicHistoryBox.put(history.comicId, history);
  }

  ComicHistory? getComicHistory(int comicId) {
    return comicHistoryBox.get(comicId);
  }

  List<ComicHistory> getComicHistoryList() {
    return comicHistoryBox.values.where((x) => x.chapterId != 0).toList();
  }
}
