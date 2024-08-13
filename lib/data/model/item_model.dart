import 'package:expense_tracker/domain/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required super.date,
    required super.name,
    required super.price,
  });
  static ItemModel toEntity(Map<String, dynamic> data) {
    return ItemModel(
      date: data['date'],
      name: data['name'],
      price: data['price'],
    );
  }
}
