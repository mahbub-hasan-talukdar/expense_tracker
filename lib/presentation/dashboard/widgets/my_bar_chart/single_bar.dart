import 'package:expense_tracker/domain/entity/item_entity.dart';

import 'package:flutter/material.dart';

import '../../page/dashboard.dart';

class SingleBar extends StatelessWidget {
  const SingleBar({
    super.key,
    required this.singleEntity,
    required this.mx,
    required this.graphType,
  });
  final ItemEntity singleEntity;
  final double mx;
  final GraphType graphType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            '${singleEntity.price}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 10,
            ),
          ),
          Container(
            height: 150 * singleEntity.price / mx,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              color: Color.lerp(
                Theme.of(context).colorScheme.primary,
                Colors.purple,
                singleEntity.price / mx,
              ),
            ),
          ),
          switch (graphType) {
            GraphType.daily => getDayMonthText(singleEntity.date, context),
            GraphType.monthly => getMonthYearText(singleEntity.date, context),
            GraphType.yearly => getYearText(singleEntity.date, context),
          }
        ],
      ),
    );
  }

  RichText getDayMonthText(String date, BuildContext context) {
    String day = date.substring(8, 10);
    String month = _getMonth(int.parse(date.substring(5, 7)));
    return RichText(
      text: TextSpan(
        text: day,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
        children: [
          TextSpan(
            text: '\n$month',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  RichText getMonthYearText(String date, BuildContext context) {
    String month = _getMonth(int.parse(date.substring(5, 7)));
    String year = date.substring(0, 4);
    return RichText(
      text: TextSpan(
        text: month,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
        children: [
          TextSpan(
            text: '\n$year',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  RichText getYearText(String year, BuildContext context) {
    return RichText(
      text: TextSpan(
        text: year.substring(0, 4),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        children: const [
          TextSpan(
            text: '\n ',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  String _getMonth(int index) {
    switch (index) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      default:
        return 'Dec';
    }
  }
}
