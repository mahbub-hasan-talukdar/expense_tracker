import 'package:sqflite/sqflite.dart';

import 'database_service.dart';

class InsertExpense {
  Future<String?> insertNewExpense(String description, int price) async {
    String path = await getDatabasesPath();
    String dbName = 'items.db';
    Database database;
    try {
      database = await DatabaseService().openDataBase(path, dbName);
    } on Exception catch (e) {
      print('error on open database');
      return e.toString();
    }
    try {
      await DatabaseService().insertData(description, price, database);
    } on Exception catch (e) {
      print('error on insert data');
      return e.toString();
    }
    return null;
  }
}
