import 'package:expense_tracker/data/item_list_data_source/insert_expense.dart';

class AddExpenseRepositoryImp implements AddNewExpenseRepository {
  @override
  Future<String?> addNewExpenseRepository(String description, int price) {
    InsertExpense insertExpense = InsertExpense();
    return insertExpense.insertNewExpense(description, price);
  }
}
