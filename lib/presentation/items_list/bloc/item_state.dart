import 'package:equatable/equatable.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';

class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialFetchInit extends ItemState {}

class InitialFetchFailed extends ItemState {
  final String errorMessage;
  InitialFetchFailed({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class InitialFetchSuccess extends ItemState {
  final List<ItemEntity>? list;

  InitialFetchSuccess({required this.list});

  @override
  List<Object?> get props => [list];
}
