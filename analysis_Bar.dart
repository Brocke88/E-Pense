import 'package:flutter/material.dart';
import 'package:softec_app/analysis/charts.dart';
import 'package:softec_app/analysis/comparison.dart';

import 'dart:io';
import 'dart:async';

import 'package:softec_app/analysis/graphs.dart';

class AnalysisBars extends StatefulWidget {
  const AnalysisBars({super.key});

  @override
  State<AnalysisBars> createState() => _AnalysisBarsState();
}

class _AnalysisBarsState extends State<AnalysisBars> with
SingleTickerProviderStateMixin{
  late final newTabController;
  @override
  void initState() {
    newTabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
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
            unselectedLabelColor: Colors.white38,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            controller: newTabController,
            tabs: const [
              Tab(text: 'Charts',icon: Icon(
                    Icons.bar_chart,
                    // color: Colors.,
                    size: 15.0,
                  )),
              Tab(text: 'Graphs'),
              Tab(text: 'Comparison'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: newTabController,
        children: [
          GraphsTab(),
          ChartsTab(),
          ComparisonResultsTab()
        ],
      ),
    );
  }
}

