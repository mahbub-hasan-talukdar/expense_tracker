import 'package:expense_tracker/domain/entity/item_summary_entity.dart';

class ItemSummaryModel extends ItemSummaryEntity {
  ItemSummaryModel({
    required super.cost,
    required super.itemCategory,
  });
  factory ItemSummaryModel.fromJson(Map<String, dynamic> data) {
    return ItemSummaryModel(
      itemCategory: data['category'],
      cost: data['cost'],
    );
  }
}
