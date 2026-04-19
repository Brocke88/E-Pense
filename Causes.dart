import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softec_app/state_management/cubit.dart';

class Causes extends StatefulWidget {
  const Causes({super.key});

  @override
  State<Causes> createState() => _CausesState();
}

class _CausesState extends State<Causes> {
  @override
  Widget build(BuildContext context) {
    var projectState = BlocProvider.of<project_state>(context);
    List<int> expenses = List.generate(
        projectState.historyRecords[0]!.length, (int index){
          return int.parse(projectState.historyRecords[0]![index]);
    }), savings = List.generate(
        projectState.historyRecords[0]!.length, (int index){
      return int.parse(projectState.historyRecords[1]![index]);
    });
    return Scaffold(

    );
  }
}
