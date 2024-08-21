import 'package:equatable/equatable.dart';
import '../../../../domain/entity/item_entity.dart';
import '../../page/dashboard.dart';

class GraphState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialGraph extends GraphState {}

class GraphStateFailed extends GraphState {
  final String errorMessage;
  GraphStateFailed({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class GraphStateSuccess extends GraphState {
  final List<ItemEntity> itemList;
  final GraphType graphType;
  GraphStateSuccess({
    required this.itemList,
    required this.graphType,
  });

  @override
  List<Object?> get props => [itemList, graphType];
}
