import '../../../../domain/entity/item_entity.dart';
import '../../bloc/item_state.dart';
import 'item_bar.dart';
import 'item_bar_graph.dart';

import 'package:flutter/material.dart';

class GenerateBars {
  SizedBox myBarChart(InitialFetchSuccess state) {
    return SizedBox(
      height: 200,
      width: (state.list == null) ? 0 : state.list!.length * 60.0,
      child: ItemBarGraph(
        itemBars: generateBars(state.list),
      ),
    );
  }

  generateBars(List<ItemEntity>? list) {
    List<ItemBar> itemBars = [];
    if (list == null) return itemBars;
    for (int i = 0; i < list.length; i++) {
      itemBars.add(
        ItemBar(
          x: i,
          y: list[i].price.toDouble(),
          date: list[i].date,
        ),
      );
    }
    return itemBars;
  }
}
