import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FetchExpenseDatabaseService {
  Future<Database> openDataBase(String path, String dbName) async {
    return await openDatabase(
      join(path, dbName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items 
          (id INTEGER PRIMARY KEY, 
          name TEXT, 
          price INTEGER, 
          date TEXT)
        ''');
      },
      version: 1,
    );
  }

  // Future<List<Map<String, Object?>>> readData(
  //     Database database, DateTime date) async {
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  //
  //   var res = await database.rawQuery('''
  //   SELECT *
  //   FROM items
  //   WHERE date(date) = ?
  //   ORDER BY name
  // ''', [formattedDate]);
  //   print(res);
  //   return res;
  // }

  Future<List<Map<String, Object?>>> readData(
      Database database, DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    var res = await database.rawQuery('''
    SELECT * 
    FROM items
    WHERE date(date) = ?
    ORDER BY id
  ''', [formattedDate]);
    print(res);
    return res;
  }

}
