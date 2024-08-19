import 'dart:async';

import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/domain/use_case/generate_report_use_case.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/item_summary_bloc/item_summary_event.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/item_summary_bloc/item_summary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utilities/extensions/extensions.dart';

import '../../../../config/service_locator.dart';
import '../../../../domain/entity/item_summary_entity.dart';

class ItemSummaryBloc extends Bloc<ItemSummaryDrawEvent, ItemSummaryState> {
  ItemSummaryBloc() : super(ItemSummaryStateLoading()) {
    on<ItemSummaryDrawEvent>(_drawItemSummaryGraph);
  }

  FutureOr<void> _drawItemSummaryGraph(
    ItemSummaryDrawEvent event,
    Emitter<ItemSummaryState> emit,
  ) async {
    (List<ItemSummaryEntity>?, String?) result =
        await sl<GenerateReportUseCase>().getItemSummaryReport();

    if (result.$2 != null) {
      emit(ItemSummaryStateFailed(errorMessage: result.$2!));
    } else {
      emit(ItemSummaryStateSuccess(itemSummary: result.$1));
    }
  }
}
