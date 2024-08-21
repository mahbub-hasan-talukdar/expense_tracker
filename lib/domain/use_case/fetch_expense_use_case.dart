import 'package:dartz/dartz.dart';
import 'package:expense_tracker/config/service_locator.dart';
import 'package:expense_tracker/domain/entity/expense_details_entity.dart';
import 'package:expense_tracker/domain/repository/fetch_expense_repository.dart';

class FetchExpenseUseCase {
  Future<Either<String, List<ExpenseDetailsEntity>>> readItems(DateTime date) {
    return sl<FetchExpenseRepository>().readItems(date);
  }
}
