import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:softec_app/state_management/cubit.dart'; // Your project_state

class Charts extends StatefulWidget {
  const Charts({super.key});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          backgroundColor: const Color(0xff13095c),
          flexibleSpace: const FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Text(
                'E-Pense',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            centerTitle: true,
          ),
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: 'New Record',
                icon: Icon(Icons.bar_chart, color: Colors.white),
              ),
              Tab(
                text: 'History',
                icon: Icon(Icons.history, color: Colors.white),
              ),
              Tab(
                text: 'Suggestions',
                icon: Icon(Icons.lightbulb, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          NewRecordCharts(),  // Multiple bar charts
          const HistoryTab(),
          const SuggestionsTab(),
        ],
      ),
    );
  }
}

// 🔥 MAIN FIX: Multiple Bar Charts with Headings & Real Data
class NewRecordCharts extends StatelessWidget {
  NewRecordCharts({super.key});

  final project_state state = project_state(); // Your state management

  // Generate bar chart data for each category (1-5)
  BarChartData _buildBarChartData(int index, String title) {
    // Get data from your state
    String latestValue = state.latestValues[index - 1]; // List 0-based
    dynamic history = state.historyRecords[index]; // Map direct access

    // Sample data - replace with your actual logic
    List<double> barValues = [];
    if (history != null) {
      history.forEach((category, values) {
        if (values.isNotEmpty) {
          barValues.add(values.length.toDouble()); // Count of history entries
        }
      });
    }

    // Ensure at least 3 bars for demo
    while (barValues.length < 3) barValues.add(0.0);

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 10,
      barTouchData: BarTouchData(enabled: true),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              ['Cat1', 'Cat2', 'Cat3'][value.toInt()],
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ),
      borderData: FlBorderData(show: true),
      barGroups: [
        for (int i = 0; i < barValues.length; i++)
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: barValues[i],
                color: _getColor(i),
                width: 20,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
            ],
          ),
      ],
    );
  }

  Color _getColor(int index) => [
    const Color(0xff0f9bf5),
    const Color(0xfff8b500),
    const Color(0xffe0440e),
  ][index % 3];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 5 DIFFERENT BAR CHARTS WITH HEADINGS
          _buildChartSection(1, 'Category 1 - Latest Records'),
          _buildChartSection(2, 'Category 2 - Usage History'),
          _buildChartSection(3, 'Category 3 - Performance'),
          _buildChartSection(4, 'Category 4 - Trends'),
          _buildChartSection(5, 'Category 5 - Summary'),
        ],
      ),
    );
  }

  Widget _buildChartSection(int index, String title) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 HEADING FOR EACH CHART
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff13095c),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(_buildBarChartData(index, title)),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder tabs
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('History Charts Coming Soon!'));
  }
}

class SuggestionsTab extends StatelessWidget {
  const SuggestionsTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('AI Suggestions Coming Soon!'));
  }
}