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

  Future<List<Map<String, Object?>>> readData(Database database) async {
    return await database.rawQuery('''
      SELECT name, SUM(price) as price, date 
      FROM items
      GROUP BY date
      ORDER BY date DESC
    ''');
  }

  Future<int> insertData(Database database) async {
    return await database.insert('items', {
      'name': 'ydsffs',
      'price': 200,
      // 'date': DateFormat('d MMM, yyyy').format(DateTime.now()),
      'date': '08 Aug, 2024'
    });
  }
}
