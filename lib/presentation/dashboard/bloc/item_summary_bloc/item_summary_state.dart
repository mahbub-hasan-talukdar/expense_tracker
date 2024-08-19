import 'package:equatable/equatable.dart';

import '../../../../domain/entity/item_entity.dart';
import '../../../../domain/entity/item_summary_entity.dart';

class ItemSummaryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemSummaryStateSuccess extends ItemSummaryState {
  final List<ItemSummaryEntity>? itemSummary;
  ItemSummaryStateSuccess({required this.itemSummary});
  @override
  List<Object?> get props => [itemSummary];
}

class ItemSummaryStateLoading extends ItemSummaryState {}

class ItemSummaryStateFailed extends ItemSummaryState {
  final String errorMessage;
  ItemSummaryStateFailed({required this.errorMessage});
}
