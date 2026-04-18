import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softec_app/state_management/cubit.dart';

List<Widget> goalSuggestions = List.generate(10, (int index){
  BuildContext? context;
  final newContext = BlocProvider.of<project_state>(context!);
  return ListView.builder(
    itemCount: newContext.historyRecords[4]!.length,
      itemBuilder: (context,int index) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white38
            ],
                stops: [0.83, 1.0]
            )
        ),
        child: Text(newContext.historyRecords[4].toString(),
          style: TextStyle(
            color: Colors.black38,
            fontSize:30,
            // fontWeight: ,
            // fontFamily: ,
          ),textAlign: TextAlign.center,
        ),
      );
    });
});