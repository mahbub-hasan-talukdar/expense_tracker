import 'package:expense_tracker/data/data_source/delete_expense_data_source/delete_expense_data_source.dart';
import 'package:expense_tracker/domain/repository/delete_expense_repository.dart';

class DeleteExpenseRepositoryImpl implements DeleteExpenseRepository {
  @override
  Future<void> deleteItem(int id) async {
    DeleteExpenseDataSource deleteExpenseDataSource = DeleteExpenseDataSource();
    await deleteExpenseDataSource.deleteItem(id);
  }
}