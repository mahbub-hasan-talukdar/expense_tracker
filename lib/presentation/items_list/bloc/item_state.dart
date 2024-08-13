import 'package:equatable/equatable.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';

class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialFetchState extends ItemState {
  final List<ItemEntity>? list;
  final String? errorMessage;
  InitialFetchState({this.list = const [], this.errorMessage});

  InitialFetchState copyWith({
    List<ItemEntity>? list,
    String? errorMessage,
  }) {
    return InitialFetchState(
      list: list ?? this.list,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [list, errorMessage];
}
