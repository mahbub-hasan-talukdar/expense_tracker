import 'package:expense_tracker/config/service_locator.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/domain/repository/item_list_repository.dart';

class ItemListUseCase {
  Future<(List<ItemEntity>?, String?)> readItems() {
    return sl<ItemListRepository>().readItems();
  }
}
