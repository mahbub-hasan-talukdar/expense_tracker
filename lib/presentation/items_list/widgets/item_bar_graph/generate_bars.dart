import '../../../../domain/entity/item_entity.dart';
import '../../bloc/item_state.dart';
import 'item_bar.dart';
import 'item_bar_graph.dart';

import 'package:flutter/material.dart';

class GenerateBars {
  SizedBox myBarChart(List<ItemEntity>? itemList) {
    return SizedBox(
      height: 200,
      child: ItemBarGraph(
        itemBars: generateBars(itemList),
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
