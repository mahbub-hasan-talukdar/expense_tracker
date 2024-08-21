import 'package:expense_tracker/domain/entity/expense_details_entity.dart';

class ExpenseDetailsModel extends ExpenseDetailsEntity {
  ExpenseDetailsModel({
    required super.name,
    required super.date,
    required super.price,
  });
  factory ExpenseDetailsModel.fromJson(Map<String, dynamic> data) {
    return ExpenseDetailsModel(
      name: data['name'],
      date: data['date'],
      price: data['price'],
    );
  }
}