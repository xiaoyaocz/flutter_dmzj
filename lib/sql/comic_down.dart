import 'package:sqflite/sqflite.dart';

final String comicDownloadTableName = 'ComicDownload';
final String comicDownloadColumnChapterID = 'ChapterID';
final String comicDownloadColumnChapterName = 'ChapterName';
final String comicDownloadColumnComicID = 'ComicID';
final String comicDownloadColumnComicName = 'ComicName';
final String comicDownloadColumnStatus = 'Status';
final String comicDownloadColumnVolume = 'Volume';
final String comicDownloadColumnPage = 'Page';
final String comicDownloadColumnCount = 'Count';
final String comicDownloadColumnSavePath = 'SavePath';
final String comicDownloadColumnUrls = 'Urls';


class ComicDownloadSqlItem {
	int chapterID;
String chapterName;
int comicID;
String comicName;
int status;
String volume;
int page;
int count;
String savePath;
String urls;

  ComicDownloadSqlItem(this.chapterID,this.chapterName,this.comicID,this.comicName,this.status,this.volume,{this.page,this.count,this.savePath,this.urls});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      comicDownloadColumnChapterID: chapterID,
comicDownloadColumnChapterName: chapterName,
comicDownloadColumnComicID: comicID,
comicDownloadColumnComicName: comicName,
comicDownloadColumnStatus: status,
comicDownloadColumnVolume: volume,
comicDownloadColumnPage: page,
comicDownloadColumnCount: count,
comicDownloadColumnSavePath: savePath,
comicDownloadColumnUrls: urls,

    };
    return map;
  }

  ComicDownloadSqlItem.fromMap(Map<String, dynamic> map) {
    chapterID = map[comicDownloadColumnChapterID];
chapterName = map[comicDownloadColumnChapterName];
comicID = map[comicDownloadColumnComicID];
comicName = map[comicDownloadColumnComicName];
status = map[comicDownloadColumnStatus];
volume = map[comicDownloadColumnVolume];
page = map[comicDownloadColumnPage];
count = map[comicDownloadColumnCount];
savePath = map[comicDownloadColumnSavePath];
urls = map[comicDownloadColumnUrls];

  }


}

class ComicDownloadProvider {
 static Database db;
 static Future<ComicDownloadSqlItem> insert(ComicDownloadSqlItem item) async {
    await db.insert(comicDownloadTableName, item.toMap());
    return item;
  }

  static Future<ComicDownloadSqlItem> getItem(int id) async {
    
    List<Map> maps = await db.query(comicDownloadTableName,
        columns: [comicDownloadColumnChapterID,
comicDownloadColumnChapterName,
comicDownloadColumnComicID,
comicDownloadColumnComicName,
comicDownloadColumnStatus,
comicDownloadColumnVolume,
comicDownloadColumnPage,
comicDownloadColumnCount,
comicDownloadColumnSavePath,
comicDownloadColumnUrls,
],
        where: '$comicDownloadColumnChapterID = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return ComicDownloadSqlItem.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> clear() async {
    return await db.delete(comicDownloadTableName);
  }

  static Future<ComicDownloadSqlItem> updateOrInsert(ComicDownloadSqlItem item) async{
    var data=await getItem(item.chapterID);
    if(data!=null){
      await update(item);
      return item;
    }else{
      return await insert(item);
    }
  }

  static Future<List<ComicDownloadSqlItem>> getItems() async {
    List<ComicDownloadSqlItem> maps = (await db.query(comicDownloadTableName)).map<ComicDownloadSqlItem>((x)=>ComicDownloadSqlItem.fromMap(x)).toList();
    return maps;
  }

  static Future<int> delete(int id) async {
    return await db.delete(comicDownloadTableName, where: '$comicDownloadColumnChapterID = ?', whereArgs: [id]);
  }

  static Future<int> update(ComicDownloadSqlItem item) async {
    return await db.update(comicDownloadTableName, item.toMap(),
        where: '$comicDownloadColumnChapterID = ?', whereArgs: [item.chapterID]);
  }

  static Future close() async => db.close();

}