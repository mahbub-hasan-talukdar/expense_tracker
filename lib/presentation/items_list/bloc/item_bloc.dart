import 'dart:async';

import 'package:expense_tracker/config/service_locator.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/domain/use_case/item_list_use_case.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_event.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBloc extends Bloc<InitialFetchEvent, InitialFetchState> {
  ItemBloc() : super(InitialFetchState()) {
    on<InitialFetchEvent>(_initialFetch);
  }

  FutureOr<void> _initialFetch(InitialFetchEvent event, Emitter emit) async {
    (List<ItemEntity>?, String?) response =
        await sl<ItemListUseCase>().readItems();
    if (response.$1 != null) {
      emit(state.copyWith(list: response.$1, errorMessage: null));
    } else {
      emit(state.copyWith(list: null, errorMessage: response.$2));
    }
  }
}
