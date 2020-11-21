import 'package:sqflite/sqflite.dart';

final String testTableName = 'Test';
final String testColumnId = 'Id';
final String testColumnName = 'Name';
final String testColumnDesc = 'Desc';

class TestSqlItem {
  String id;
  String name;
  String desc;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      testColumnId: id,
      testColumnName: name,
      testColumnDesc: desc,
    };
    return map;
  }

  TestSqlItem.fromMap(Map<String, dynamic> map) {
    id = map[testColumnId];
    name = map[testColumnName];
    desc = map[testColumnDesc];
  }
}

class TestProvider {
  static Database db;
  static Future<TestSqlItem> insert(TestSqlItem item) async {
    await db.insert(testTableName, item.toMap());
    return item;
  }

  static Future<TestSqlItem> getItem(String id) async {
    List<Map> maps = await db.query(testTableName,
        columns: [
          testColumnId,
          testColumnName,
          testColumnDesc,
        ],
        where: '$testColumnId = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return TestSqlItem.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> clear() async {
    return await db.delete(testTableName);
  }

  static Future<List<TestSqlItem>> getItems() async {
    List<TestSqlItem> maps = (await db.query(testTableName))
        .map<TestSqlItem>((x) => TestSqlItem.fromMap(x))
        .toList();
    return maps;
  }

  static Future<int> delete(String id) async {
    return await db
        .delete(testTableName, where: '$testColumnId = ?', whereArgs: [id]);
  }

  static Future<int> update(TestSqlItem item) async {
    return await db.update(testTableName, item.toMap(),
        where: '$testColumnId = ?', whereArgs: [item.id]);
  }

  static Future close() async => db.close();
}
