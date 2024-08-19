import 'package:dartz/dartz.dart';
import 'package:expense_tracker/data/model/expense_details_model.dart';
import 'package:expense_tracker/data/fetch_expense_data_source/fetch_expense_database_service.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class FetchExpenseDataSource {
  Future<Either<String, List<ExpenseDetailsModel>>> readItems(DateTime date) async {
    String path = await getDatabasesPath();
    String dbName = 'items.db';
    Database database;
    try {
      database = await FetchExpenseDatabaseService().openDataBase(path, dbName);
    } on Exception catch (e) {
      return Left(e.toString());
    }

    //String formattedDate = DateFormat('d MMM, yyyy').format(date);

    late List<Map<String, dynamic>> results;
    try {
      results = await FetchExpenseDatabaseService().readData(database, date);
    } on Exception catch (e) {
      return Left(e.toString());
    }

    List<ExpenseDetailsModel> list = [];
    for (var data in results) {
      list.add(ExpenseDetailsModel.fromJson(data));
    }
    await database.close();
    return Right(list);
  }
}