import 'package:expense_tracker/data/repository_imp/repository_imp.dart';
import 'package:expense_tracker/domain/repository/repository.dart';
import 'package:expense_tracker/domain/use_case/use_case.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocators() async {
  sl.registerFactory<Repository>(() => RepositoryImp());
  sl.registerFactory<UseCase>(() => UseCase());
  // sl.reset();
}
