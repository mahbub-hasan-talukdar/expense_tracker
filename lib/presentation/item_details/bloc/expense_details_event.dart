import 'package:equatable/equatable.dart';

class ExpenseDetailsEvent extends Equatable {
  const ExpenseDetailsEvent();

  @override
  List<Object?> get props => [];
}

class AddNewExpense extends ExpenseDetailsEvent {
  final String description;
  final int price;
  final DateTime dateTime;

  const AddNewExpense({
    required this.description,
    required this.price,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [description, price];
}

class DeleteExpense extends ExpenseDetailsEvent {
  final int id;

  const DeleteExpense({required this.id});

  @override
  List<Object?> get props => [id];
}

class FetchExpenseEvent extends ExpenseDetailsEvent {
  final DateTime date;

  const FetchExpenseEvent({required this.date});
}
