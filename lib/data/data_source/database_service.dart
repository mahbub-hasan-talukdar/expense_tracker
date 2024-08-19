import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
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

  Future<List<Map<String, Object?>>> readData(
    Database database,
    String reportFormat,
  ) async {
    return await database.rawQuery('''
      SELECT 
        strftime('$reportFormat', date) AS day,
        SUM(price) AS total_price
      FROM 
        items
      GROUP BY 
        strftime('$reportFormat', date);
    ''');
  }

  Future<int> insertData(
    String description,
    int price,
    Database database,
    DateTime date,
  ) async {
    return await database.insert('items', {
      'name': description,
      'price': price,
      'date': date.toIso8601String(),
    });
  }

  Future<void> deleteExpensesByDate(Database db, String date) async {
    String isoDate = convertToIso8601(date);
    // await db.delete(
    //   'items',
    //   where: 'date LIKE ?',
    //   whereArgs: ['$isoDate%'],
    // );
    print(date);
  }

  String convertToIso8601(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return parsedDate.toIso8601String().split('T')[0];
  }

  Future<List<Map<String, Object?>>> getItemSummaryReport(
    Database database,
  ) async {
    var res = await database.rawQuery('''
      SELECT 
        name as category, sum(price) as cost
      FROM
        items
      group by name
    ''');
    return res;
  }
}
