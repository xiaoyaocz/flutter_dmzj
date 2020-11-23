import 'package:flutter/foundation.dart';
import 'package:flutter_dmzj/models/comic/comic_history_item.dart';
import 'package:sqflite/sqflite.dart';

final String comicHistoryTable = 'comic_history';

//主键
final String comicHistoryColumnUserID = 'uid';
final String comicHistoryColumnType = 'type';
final String comicHistoryColumnComicID = 'comic_id';
final String comicHistoryColumnChapterID = 'chapter_id';
final String comicHistoryColumnRecord = 'record';
//非主键
final String comicHistoryColumnComicName = 'comic_name';
final String comicHistoryColumnCover = 'cover';
final String comicHistoryColumnChapterName = 'chapter_name';
final String comicHistoryColumnViewTime = 'view_time';

class ComicHistoryHelper extends ChangeNotifier {
  static Database db;

  static Future initTable(Database _db) async {
    db = _db;
    await db.execute('''
create table $comicHistoryTable ( 
  $comicHistoryColumnUserID integer primary key not null, 
  $comicHistoryColumnComicID integer not null, 
  $comicHistoryColumnType integer not null,
  $comicHistoryColumnChapterID integer not null,
  $comicHistoryColumnRecord integer not null,
  $comicHistoryColumnComicName Text not null,
  $comicHistoryColumnCover Text not null,
  $comicHistoryColumnChapterName Text not null,
  $comicHistoryColumnViewTime integer not null
  )
''');
  }

  static Future<ComicHistoryItem> insert(ComicHistoryItem item) async {
    await db.insert(comicHistoryTable, item.toJson());

    return item;
  }

  static Future<ComicHistoryItem> getItem(int id) async {
    List<Map> maps = await db.query(comicHistoryTable,
        where: '$comicHistoryColumnComicID = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return ComicHistoryItem.fromJson(maps.first);
    }
    return null;
  }

  static Future<int> clear() async {
    return await db.delete(comicHistoryTable);
  }

  static Future<List<ComicHistoryItem>> getItems() async {
    List<ComicHistoryItem> maps = (await db.query(comicHistoryTable))
        .map<ComicHistoryItem>((x) => ComicHistoryItem.fromJson(x))
        .toList();
    return maps;
  }

  static Future<int> delete(String id) async {
    return await db.delete(comicHistoryTable,
        where: '$comicHistoryColumnComicID = ?', whereArgs: [id]);
  }

  static Future<int> update(ComicHistoryItem item) async {
    return await db.update(comicHistoryTable, item.toJson(),
        where: '$comicHistoryColumnComicID = ?', whereArgs: [item.comic_id]);
  }

  static Future close() async => db.close();
}

class ComicHistoryProvider extends ChangeNotifier {
  int history;

  Future updateHistory(int id) async {
    var his = await ComicHistoryHelper.getItem(id);
    history = his?.chapter_id ?? 0;
  }

  int setHistory(int his) {
    history = his;
    notifyListeners();
  }
}
