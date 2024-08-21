import 'package:get_it/get_it.dart';

import '../data/repository_imp/generate_report_repo_imp.dart';
import '../domain/repository/generate_report_repo.dart';
import '../domain/use_case/generate_report_use_case.dart';
import '../data/repository_imp/add_expense_repository_imp.dart';
import '../data/repository_imp/item_list_repository_imp.dart';
import '../domain/repository/add_new_expense_repository.dart';
import '../domain/repository/item_list_repository.dart';
import '../domain/use_case/add_new_expense_use_case.dart';
import '../domain/use_case/item_list_use_case.dart';
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

  sl.registerLazySingleton<GenerateReportRepo>(() => GenerateReportRepoImp());
  sl.registerLazySingleton<GenerateReportUseCase>(
      () => GenerateReportUseCase(sl<GenerateReportRepo>()));
}
