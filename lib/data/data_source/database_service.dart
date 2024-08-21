import 'package:intl/intl.dart';
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
  ) async {
    return await database.insert('items', {
      'name': description,
      'price': price,
      'date': DateFormat('d MMM, yyyy').format(DateTime.now()),
    });
  }
}
