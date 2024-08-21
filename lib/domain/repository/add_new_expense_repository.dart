abstract class AddNewExpenseRepository {
  Future<String?> addNewExpense(String description, int price, DateTime dateTime);
}
