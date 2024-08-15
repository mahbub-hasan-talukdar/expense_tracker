import 'package:expense_tracker/data/item_list_data_source/database_service.dart';
import 'package:expense_tracker/data/model/item_model.dart';
import 'package:sqflite/sqflite.dart';

class ItemListDataSource {
  Future<(List<ItemModel>?, String?)> readItems() async {
    String path = await getDatabasesPath();
    String dbName = 'items.db';
    Database database;
    try {
      database = await DatabaseService().openDataBase(path, dbName);
    } on Exception catch (e) {
      print('error on open database');
      return (null, e.toString());
    }

    late List<Map<String, dynamic>> results;
    try {
      results = await DatabaseService().readData(database);
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
}
