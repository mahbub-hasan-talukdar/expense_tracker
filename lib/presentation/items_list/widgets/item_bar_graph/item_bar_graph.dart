import 'item_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ItemBarGraph extends StatelessWidget {
  const ItemBarGraph({super.key, required this.itemBars});
  final List<ItemBar> itemBars;

  @override
  Widget build(BuildContext context) {
    double mx = 0;
    for (ItemBar item in itemBars) {
      if (item.y > mx) mx = item.y;
    }
    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(itemBars[value.toInt()].date.substring(0, 6)),
                );
              },
            ),
          ),
        ),
        maxY: 200,
        minY: 0,
        barGroups: itemBars.map((data) => _barData(data, mx, context)).toList(),
      ),
    );
  }

  BarChartGroupData _barData(
    ItemBar data,
    double mx,
    BuildContext context,
  ) {
    return BarChartGroupData(
      x: data.x,
      barRods: [
        BarChartRodData(
          toY: 200 * data.y / mx,
          color: Theme.of(context).colorScheme.primary,
          width: 30,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
      ],
    );
  }
}
