class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});
}

class Expense {
  final DateTime date;
  final double amount;
  final Category category;

  Expense({required this.date, required this.amount, required this.category});
}
