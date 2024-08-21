import 'package:dartz/dartz.dart';
import 'package:expense_tracker/domain/entity/expense_details_entity.dart';

abstract class FetchExpenseRepository {
  Future<Either<String, List<ExpenseDetailsEntity>>> readItems(DateTime date);
}
