import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/item_summary_entity.dart';
import '../../page/dashboard.dart';
import 'single_summary_bar.dart';

class SummaryList extends StatelessWidget {
  const SummaryList({
    super.key,
    required this.items,
  });
  final List<ItemSummaryEntity> items;

  @override
  Widget build(BuildContext context) {
    List<Widget> barList = [];
    double mx = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i].cost > mx) mx = items[i].cost.toDouble();
    }
    barList.add(const SizedBox(width: 20));
    for (int i = items.length - 1; i >= 0; i--) {
      barList.add(SingleSummaryBar(
        singleEntity: items[i],
        mx: mx,
      ));
      barList.add(const SizedBox(width: 20));
    }
    barList.add(const SizedBox(width: 20));
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: barList,
        ),
      ),
    );
  }
}
