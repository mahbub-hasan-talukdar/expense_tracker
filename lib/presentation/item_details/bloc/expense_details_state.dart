import 'package:equatable/equatable.dart';
import 'package:expense_tracker/domain/entity/expense_details_entity.dart';

class ExpenseDetailsState extends Equatable {
  const ExpenseDetailsState();

  @override
  List<Object?> get props => [];
}

class FetchExpense extends ExpenseDetailsState {}

class FetchExpenseError extends ExpenseDetailsState {
  final String errorMessage;

  const FetchExpenseError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class FetchExpenseSuccess extends ExpenseDetailsState {
  final List<ExpenseDetailsEntity>? list;

  const FetchExpenseSuccess({required this.list});

  @override
  List<Object?> get props => [list];
}
