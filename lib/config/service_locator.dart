import 'package:expense_tracker/data/repository_imp/fetch_expense_repository_imp.dart';
import 'package:expense_tracker/domain/repository/delete_expense_repository.dart';
import 'package:expense_tracker/domain/repository/fetch_expense_repository.dart';
import 'package:expense_tracker/domain/use_case/fetch_expense_use_case.dart';
import 'package:expense_tracker/data/repository_imp/generate_report_repo_imp.dart';
import 'package:expense_tracker/domain/repository/generate_report_repo.dart';
import 'package:expense_tracker/domain/use_case/generate_report_use_case.dart';
import 'package:get_it/get_it.dart';

import '../data/repository_imp/add_expense_repository_imp.dart';
import '../data/repository_imp/delete_expense_repository_imp.dart';
import '../domain/repository/add_new_expense_repository.dart';
import '../domain/use_case/add_new_expense_use_case.dart';
import '../domain/use_case/delete_expense_use_case.dart';
import '../presentation/item_details/bloc/expense_details_bloc.dart';
import '../presentation/items_list/bloc/item_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocators() async {
  sl.registerFactory<ItemBloc>(() => ItemBloc());

  sl.registerLazySingleton<AddNewExpenseUseCase>(
      () => AddNewExpenseUseCase(sl<AddNewExpenseRepository>()));

  sl.registerLazySingleton<AddNewExpenseRepository>(
      () => AddExpenseRepositoryImp());
  sl.registerFactory<ExpenseDetailsBloc>(() => ExpenseDetailsBloc());
  sl.registerLazySingleton<FetchExpenseRepository>(
      () => FetchExpenseRepositoryImp());
  sl.registerLazySingleton<FetchExpenseUseCase>(() => FetchExpenseUseCase());

  sl.registerLazySingleton<GenerateReportRepo>(() => GenerateReportRepoImp());
  sl.registerLazySingleton<GenerateReportUseCase>(
      () => GenerateReportUseCase(sl<GenerateReportRepo>()));

  sl.registerLazySingleton<DeleteExpenseRepository>(
      () => DeleteExpenseRepositoryImpl());
  sl.registerLazySingleton<DeleteExpenseUseCase>(() => DeleteExpenseUseCase());
}
