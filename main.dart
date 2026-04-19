import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softec_app/analysis/analysis_Bar.dart';
import 'package:softec_app/analysis/charts.dart';
import 'dart:io';
import 'dart:async';

import 'package:softec_app/results/goals.dart';
import 'package:softec_app/presenttionlayer/dashboard/dashboard.dart';
import 'package:softec_app/state_management/cubit.dart';

void main(){
  runApp(
    BlocProvider(
      create:(_){
        return project_state();
       },
       child:defaultClass()
    )
  );
}

class defaultClass extends StatelessWidget {
  const defaultClass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // themeMode: ThemeMode(
      //
      // ),
      theme: ThemeData(),
      home:Home() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex!,
        children: [
          DashboardScreen(),
          AnalysisBars(),
          results(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex!,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xff13095c),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.center_focus_strong),
            label: 'Results',
          ),
        ],
      ),
    );
  }
}
