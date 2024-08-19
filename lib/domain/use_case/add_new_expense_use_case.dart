import 'package:expense_tracker/domain/repository/add_new_expense_repository.dart';

class AddNewExpenseUseCase {
  final AddNewExpenseRepository _addNewExpenseRepo;

  AddNewExpenseUseCase(this._addNewExpenseRepo);

  Future<String?> addNewExpense(
      {required String description,
      required int price,
      required DateTime dateTime}) async {
    return await _addNewExpenseRepo.addNewExpense(description, price, dateTime);
  }
}
