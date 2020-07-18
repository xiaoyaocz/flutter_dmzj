import 'package:sqflite/sqflite.dart';

final String comicHistoryTable = 'comic_history';
//主键
final String comicHistoryColumnComicID = 'comic_id';
final String comicHistoryColumnChapterID = 'chapter_id';
final String comicHistoryColumnPage = 'page';
//1为横向，2为纵向阅读百分比
final String comicHistoryMode = 'mode';

class ComicHistory {
  int comic_id;
  int chapter_id;
  double page;
  int mode;
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      comicHistoryColumnComicID: comic_id,
      comicHistoryColumnChapterID: chapter_id,
      comicHistoryColumnPage: page,
      comicHistoryMode:mode,
    };
    return map;
  }

  ComicHistory(this.comic_id,this.chapter_id,this.page,this.mode);

  ComicHistory.fromMap(Map<String, dynamic> map) {
    comic_id = map[comicHistoryColumnComicID];
    chapter_id = map[comicHistoryColumnChapterID];
    page = map[comicHistoryColumnPage];
    mode= map[comicHistoryMode];
  }
}

 class ComicHistoryProvider {
  static Database db;


  static Future<ComicHistory> insert(ComicHistory item) async {
    await db.insert(comicHistoryTable, item.toMap());
    
    return item;
  }

  static Future<ComicHistory> getItem(int id) async {
    
    List<Map> maps = await db.query(comicHistoryTable,
        columns: [comicHistoryColumnComicID, comicHistoryColumnChapterID, comicHistoryColumnPage,comicHistoryMode],
        where: '$comicHistoryColumnComicID = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return ComicHistory.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> clear() async {
    return await db.delete(comicHistoryTable);
  }

 static Future<List<ComicHistory>> getItems() async {
    List<ComicHistory> maps = (await db.query(comicHistoryTable)).map<ComicHistory>((x)=>ComicHistory.fromMap(x)).toList();
    return maps;
  }


 static Future<int> delete(String id) async {
    return await db.delete(comicHistoryTable, where: '$comicHistoryColumnComicID = ?', whereArgs: [id]);
  }

  static Future<int> update(ComicHistory item) async {
    return await db.update(comicHistoryTable, item.toMap(),
        where: '$comicHistoryColumnComicID = ?', whereArgs: [item.comic_id]);
  }

  static Future close() async => db.close();
}