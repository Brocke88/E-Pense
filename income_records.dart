import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'dart:convert';

import 'package:softec_app/state_management/cubit.dart';

class Income_Records extends StatefulWidget {
  const Income_Records({super.key});

  @override
  State<Income_Records> createState() => _Income_RecordsState();
}

class _Income_RecordsState extends State<Income_Records> {
  @override
  Widget build(BuildContext context) {
    final projectStateInstance = BlocProvider.of<project_state>(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: projectStateInstance.historyRecords[0]!.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
              width: 500,
              height: 200,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: Colors.blue,
                // shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6),
                      spreadRadius: 3,
                      color:Color(0xff13095c)
                  ),
                  BoxShadow(
            
                  ),
                ]
              ),child: Center(
                child: Text(projectStateInstance.historyRecords[0]!.elementAt(index).toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:30,
                    // fontWeight: ,
                    // fontFamily: ,
                  ),textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
