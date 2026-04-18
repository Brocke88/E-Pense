import 'package:flutter/material.dart';
import 'package:softec_app/analysis/charts.dart';
import 'package:softec_app/analysis/graphs.dart';
import 'package:softec_app/analysis/comparison.dart';

class AnalysisBars extends StatefulWidget {
  const AnalysisBars({super.key});

  @override
  State<AnalysisBars> createState() => _AnalysisBarsState();
}

class _AnalysisBarsState extends State<AnalysisBars> with SingleTickerProviderStateMixin {
  late TabController newTabController; // ✅ Typed properly

  @override
  void initState() {
    super.initState(); // ✅ super FIRST
    newTabController = TabController(length: 3, vsync: this); // ✅ Proper init
  }

  @override
  void dispose() {
    newTabController.dispose(); // ✅ Memory safety
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
              child: Text('E-Pense', style: TextStyle(color: Colors.white, fontSize: 33)),
            ),
            centerTitle: true,
          ),
          bottom: TabBar(
            controller: newTabController,
            unselectedLabelColor: Colors.white38,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(icon: Icon(Icons.bar_chart, size: 20), text: 'Charts'),
              Tab(icon: Icon(Icons.pie_chart, size: 20), text: 'Graphs'),
              Tab(icon: Icon(Icons.compare, size: 20), text: 'Comparison'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: newTabController, // ✅ Controller linked
        children: const [           // ✅ const for performance
          ChartsTab(),
          GraphsTab(),
          ComparisonResultsTab(),
        ],
      ),
    );
  }
}