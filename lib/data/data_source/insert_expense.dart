import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class InsertExpense {
  Future<String?> insertNewExpense(
    String description,
    int price,
    DateTime date,
  ) async {
    String path = await getDatabasesPath();
    // const String path = '/Users/bs00849/Desktop/Dev/db';
    const String dbName = 'items.db';
    Database database;
    try {
      database = await DatabaseService().openDataBase(path, dbName);
    } on Exception catch (e) {
      print('error on open database');
      return e.toString();
    }
    try {
      await DatabaseService().insertData(
        description,
        price,
        database,
        date,
      );
    } on Exception catch (e) {
      print('error on insert data');
      return e.toString();
    }
    return null;
  }
}
