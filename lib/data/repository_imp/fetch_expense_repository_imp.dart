import 'package:dartz/dartz.dart';
import 'package:expense_tracker/data/data_source/fetch_expense_data_source/fetch_expense_data_source.dart';
import 'package:expense_tracker/domain/entity/expense_details_entity.dart';
import 'package:expense_tracker/domain/repository/fetch_expense_repository.dart';

class FetchExpenseRepositoryImp implements FetchExpenseRepository {
  @override
  Future<Either<String, List<ExpenseDetailsEntity>>> readItems(
      DateTime date) async {
    FetchExpenseDataSource fetchExpenseDataSource = FetchExpenseDataSource();
    final result = await fetchExpenseDataSource.readItems(date);
    return result.fold(
      (error) => Left(error),
      (list) => Right(list),
    );
  }
}
