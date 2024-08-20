import 'dart:ffi';

import 'package:expense_tracker/domain/entity/item_entity.dart';

import 'package:flutter/material.dart';

import '../../../../domain/entity/item_summary_entity.dart';
import '../../page/dashboard.dart';

class SingleSummaryBar extends StatelessWidget {
  const SingleSummaryBar({
    super.key,
    required this.singleEntity,
    required this.mx,
  });
  final ItemSummaryEntity singleEntity;
  final double mx;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(height: 20),
              SizedBox(
                width: 100,
                child: Text(
                  singleEntity.itemCategory,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Container(
                height: 10,
                width: (screenWidth - 200) * singleEntity.cost / mx,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Color.lerp(
                    Colors.blue,
                    Theme.of(context).colorScheme.primary,
                    singleEntity.cost / mx,
                  ),
                ),
              ),
              Text(
                '${singleEntity.cost}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
