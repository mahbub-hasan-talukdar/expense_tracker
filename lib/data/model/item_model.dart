import '../../domain/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  ItemModel({
    required super.date,
    required super.price,
  });
  factory ItemModel.fromJson(Map<String, dynamic> data) {
    return ItemModel(
      date: data['day'],
      price: data['total_price'],
    );
  }
}
