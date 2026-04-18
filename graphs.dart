import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:softec_app/state_management/cubit.dart';

class GraphsTab extends StatefulWidget {
  const GraphsTab({super.key});

  @override
  State<GraphsTab> createState() => _GraphsTabState();
}

class _GraphsTabState extends State<GraphsTab> {
  final project_state state = project_state();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
      // Replace AnalyticsCard with this:
      Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '💰 Income Bar Chart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 350, child: BarChart(_buildExpensesChart())),
          ],
        ),
      ),
    ),
        ],
      ),
    );
  }

  BarChartData _buildExpensesChart() {
    Map<String, double> data = {};
    [2, 4].forEach((index) {
      dynamic history = state.historyRecords[index];
      if (history != null) {
        history.forEach((cat, vals) {
          data[cat] = (data[cat] ?? 0) + vals.length;
        });
      }
    });

    List<BarChartGroupData> bars = [];
    int x = 0;
    data.forEach((cat, count) {
      bars.add(BarChartGroupData(
        x: x,
        barRods: [BarChartRodData(toY: count, color: Colors.red, width: 35)],
        showingTooltipIndicators: [0],
      ));
      x++;
    });

    return BarChartData(
      maxY: 10,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          // tooltipBgColor: Colors.red.withOpacity(0.8),
          getTooltipItem: (group, groupIndex, rod, rodIndex) => BarTooltipItem(
            '${rod.toY.round()}',
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              if (value == 0) return const Text('Expenses →');
              return const Text('Cat');
            },
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: const FlGridData(show: true),
      borderData: FlBorderData(show: true),
      barGroups: bars,
    );
  }
}