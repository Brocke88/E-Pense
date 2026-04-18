import 'package:flutter/material.dart';
import 'package:softec_app/results/Causes.dart';

import 'dart:async';
import 'dart:io';

import 'package:softec_app/results/Goal_Outcomes.dart';
import 'package:softec_app/results/resultsComparison.dart';

class results extends StatefulWidget {
  const results({super.key});

  @override
  State<results> createState() => _resultsState();
}

class _resultsState extends State<results> with 
SingleTickerProviderStateMixin{
  late final TabController newTabcontroller;
  @override
  void initState() {
    newTabcontroller = TabController(
      length: 3,vsync: this
    );
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
            controller: newTabcontroller,
            tabs: const [
              Tab(text: 'New Record'),
              Tab(text: 'History'),
              Tab(text: 'Suggestions'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: newTabcontroller,
        children: [
          Goals(),
          Causes(),
          comparisons(),
        ],
      ),
    );
  }
}
