import 'dart:async';
import 'dart:core';
import 'package:expense_tracker/config/service_locator.dart';
import 'package:expense_tracker/domain/entity/expense_details_entity.dart';
import 'package:expense_tracker/domain/use_case/add_new_expense_use_case.dart';
import 'package:expense_tracker/domain/use_case/fetch_expense_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'expense_details_event.dart';
import 'expense_details_state.dart';

class ExpenseDetailsBloc
    extends Bloc<ExpenseDetailsEvent, ExpenseDetailsState> {
  ExpenseDetailsBloc() : super(const ExpenseDetailsState()) {
    on<AddNewExpense>(_addNewExpense);
    on<FetchExpenseEvent>(_fetchExpense);
  }

  void _addNewExpense(
      AddNewExpense event, Emitter<ExpenseDetailsState> emit) async {
    await sl<AddNewExpenseUseCase>().addNewExpense(
      description: event.description,
      price: event.price,
    );
  }

  Future<void> _fetchExpense(
      FetchExpenseEvent event, Emitter<ExpenseDetailsState> emit) async {
    final result = await sl<FetchExpenseUseCase>().readItems(event.date);

    result.fold(
          (error) => emit(FetchExpenseError(errorMessage: error)),
          (expenses) => emit(FetchExpenseSuccess(list: expenses)),
    );
  }
}
