import 'package:expense_tracker/data/repository_imp/item_list_repository_imp.dart';
import 'package:expense_tracker/domain/repository/item_list_repository.dart';
import 'package:expense_tracker/domain/use_case/item_list_use_case.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_bloc.dart';
import 'package:expense_tracker/presentation/items_list/page/item_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> setUpServiceLocators() async {
  sl.registerFactory<ItemListRepository>(() => ItemListRepositoryImp());
  sl.registerFactory<ItemListUseCase>(() => ItemListUseCase());

  sl.registerFactory<ItemBloc>(() => ItemBloc());
}
