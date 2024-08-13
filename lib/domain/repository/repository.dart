import 'package:expense_tracker/domain/entity/item_entity.dart';

abstract class Repository {
  Future<(List<ItemEntity>?, String?)> readItems();
}
