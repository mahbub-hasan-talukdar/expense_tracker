import 'package:expense_tracker/data/repository_imp/fetch_expense_repository_imp.dart';
import 'package:expense_tracker/domain/repository/fetch_expense_repository.dart';
import 'package:expense_tracker/domain/use_case/fetch_expense_use_case.dart';
import 'package:get_it/get_it.dart';

import '../data/repository_imp/add_expense_repository_imp.dart';
import '../data/repository_imp/item_list_repository_imp.dart';
import '../domain/repository/add_new_expense_repository.dart';
import '../domain/repository/item_list_repository.dart';
import '../domain/use_case/add_new_expense_use_case.dart';
import '../domain/use_case/item_list_use_case.dart';
import '../presentation/item_details/bloc/expense_details_bloc.dart';
import '../presentation/items_list/bloc/item_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocators() async {
  sl.registerLazySingleton<ItemListRepository>(() => ItemListRepositoryImp());
  sl.registerLazySingleton<ItemListUseCase>(() => ItemListUseCase());

  sl.registerFactory<ItemBloc>(() => ItemBloc());
  sl.registerLazySingleton<AddNewExpenseUseCase>(
      () => AddNewExpenseUseCase(sl<AddNewExpenseRepository>()));
  sl.registerLazySingleton<AddNewExpenseRepository>(
      () => AddExpenseRepositoryImp());
  sl.registerFactory<ExpenseDetailsBloc>(() => ExpenseDetailsBloc());
  sl.registerLazySingleton<FetchExpenseRepository>(
      () => FetchExpenseRepositoryImp());
  sl.registerLazySingleton<FetchExpenseUseCase>(() => FetchExpenseUseCase());
}
