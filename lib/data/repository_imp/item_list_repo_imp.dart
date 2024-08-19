import 'package:expense_tracker/data/data_source/item_list_data_source.dart';

import '../../domain/repository/item_list_repo.dart';

class ItemListRepoImp implements ItemListRepo {
  @override
  Future<void> deleteExpensesByDate(String date) async {
    await ItemListDataSource().deleteExpensesByDate(date);
  }
}
