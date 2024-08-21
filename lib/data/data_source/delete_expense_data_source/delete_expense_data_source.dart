import 'package:expense_tracker/data/data_source/fetch_expense_data_source/fetch_expense_database_service.dart';
import 'package:sqflite/sqflite.dart';

class DeleteExpenseDataSource {
  Future<void> deleteItem(int id) async {
    String path = await getDatabasesPath();
    String dbName = 'items.db';
    Database database;

    try {
      database = await FetchExpenseDatabaseService().openDataBase(path, dbName);
      await database.delete(
        'items',
        where: 'id = ?',
        whereArgs: [id],
      );
      await database.close();
    } on Exception catch (e) {
      print('Error deleting item: $e');
      rethrow;
    }
  }
}
