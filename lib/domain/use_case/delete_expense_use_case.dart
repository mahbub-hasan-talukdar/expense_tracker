import 'package:expense_tracker/config/service_locator.dart';
import 'package:expense_tracker/domain/repository/delete_expense_repository.dart';

class DeleteExpenseUseCase {
  Future<void> deleteItem(int id) {
    return sl<DeleteExpenseRepository>().deleteItem(id);
  }
}
