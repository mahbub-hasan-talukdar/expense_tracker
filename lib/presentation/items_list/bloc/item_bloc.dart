import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/service_locator.dart';
import '../../../domain/entity/item_entity.dart';
import '../../../domain/use_case/generate_report_use_case.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(InitialFetchInit()) {
    on<InitialFetchEvent>(_initialFetch);
  }

  FutureOr<void> _initialFetch(InitialFetchEvent event, Emitter emit) async {
    (List<ItemEntity>?, String?) response =
        await sl<GenerateReportUseCase>().getDailyReport();
    if (response.$1 != null) {
      emit(InitialFetchSuccess(
        list: response.$1,
      ));
    } else {
      emit(InitialFetchFailed(errorMessage: response.$2 ?? ''));
    }
  }
}
