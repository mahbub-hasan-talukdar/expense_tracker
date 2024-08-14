import 'package:expense_tracker/domain/entity/item_entity.dart';

abstract class ItemListRepository {
  Future<(List<ItemEntity>?, String?)> readItems();
}
