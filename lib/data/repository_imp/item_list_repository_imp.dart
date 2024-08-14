import 'package:expense_tracker/data/item_list_data_source/item_list_data_source.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/domain/repository/item_list_repository.dart';

class ItemListRepositoryImp implements ItemListRepository {
  @override
  Future<(List<ItemEntity>?, String?)> readItems() async {
    ItemListDataSource itemListDataSource = ItemListDataSource();
    return await itemListDataSource.readItems();
  }
}
