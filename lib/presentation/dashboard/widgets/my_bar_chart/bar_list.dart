import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:flutter/material.dart';

import '../../page/dashboard.dart';
import 'single_bar.dart';

class BarList extends StatelessWidget {
  const BarList({
    super.key,
    required this.items,
    required this.graphType,
  });
  final List<ItemEntity> items;
  final GraphType graphType;

  @override
  Widget build(BuildContext context) {
    List<Widget> barList = [];
    double mx = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i].price > mx) mx = items[i].price.toDouble();
    }
    barList.add(const SizedBox(width: 20));
    for (int i = items.length - 1; i >= 0; i--) {
      barList.add(SingleBar(
        singleEntity: items[i],
        graphType: graphType,
        mx: mx,
      ));
      barList.add(const SizedBox(width: 20));
    }
    barList.add(const SizedBox(width: 20));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: barList,
      ),
    );
  }
}
