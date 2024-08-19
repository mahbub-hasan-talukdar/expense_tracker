import 'package:expense_tracker/data/data_source/database_service.dart';
import 'package:expense_tracker/data/model/item_model.dart';
import 'package:sqflite/sqflite.dart';

class ItemListDataSource {
  // String path = await getDatabasesPath();
  String path = '/Users/bs00849/Desktop/Dev/db';
  String dbName = 'items.db';
  late List<Map<String, dynamic>> results;
  Future<(List<ItemModel>?, String?)> readItems() async {
    Database database;

    try {
      database = await DatabaseService().openDataBase(path, dbName);

      results = await DatabaseService().readData(database, '%Y-%m-%d');
    } on Exception catch (e) {
      print('Error on read data');
      return (null, e.toString());
    }

    List<ItemModel> list = [];
    for (var data in results) {
      list.add(ItemModel.fromJson(data));
    }
    await database.close();
    return (list, null);
  }

  Future<void> deleteExpensesByDate(String date) async {
    Database database;
    try {
      database = await DatabaseService().openDataBase(path, dbName);
      DatabaseService().deleteExpensesByDate(database, date);
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
