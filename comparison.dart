import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:softec_app/state_management/cubit.dart';

class ComparisonResultsTab extends StatefulWidget {
  const ComparisonResultsTab({super.key});

  @override
  State<ComparisonResultsTab> createState() => _ComparisonResultsTabState();
}

class _ComparisonResultsTabState extends State<ComparisonResultsTab> {
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
              '💸 Expenses Bar Chart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 350, child: BarChart(_buildGoalsChart())),
          ],
        ),
      ),
    ),
        ],
      ),
    );
  }

  BarChartData _buildGoalsChart() {
    List<BarChartGroupData> bars = [];
    dynamic history = state.historyRecords[3]; // Goals data

    if (history != null) {
      int x = 0;
      history.forEach((category, values) {
        bars.add(BarChartGroupData(
          x: x,
          barRods: [BarChartRodData(
            toY: values.length.toDouble(),
            color: Colors.blue,
            width: 35,
          )],
          showingTooltipIndicators: [0],
        ));
        x++;
      });
    }

    return BarChartData(
      maxY: 10,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          // tooltipBgColor: Colors.blue.withOpacity(0.8),
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
              if (value == 0) return const Text('Goals →');
              return const Text('Goal');
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