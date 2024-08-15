import 'package:expense_tracker/data/item_list_data_source/insert_expense.dart';

import '../../domain/repository/add_new_expense_repository.dart';

class AddExpenseRepositoryImp implements AddNewExpenseRepository {
  @override
  Future<String?> addNewExpense(String description, int price) {
    InsertExpense insertExpense = InsertExpense();
    return insertExpense.insertNewExpense(description, price);
  }
}
