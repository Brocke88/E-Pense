import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softec_app/presenttionlayer/historyRecords/expenses_records.dart';
import 'package:softec_app/presenttionlayer/historyRecords/goals.dart';

import 'package:softec_app/presenttionlayer/historyRecords/income_records.dart';

import 'dart:io';
import 'dart:async';

import 'package:softec_app/presenttionlayer/historyRecords/savings.dart';

List<String> categories = [
  "income","Expenses","goals","savings.dart","categories"
];

class history_records extends StatefulWidget {
  const history_records({super.key});

  @override
  State<history_records> createState() => _history_recordsState();
}

class _history_recordsState extends State<history_records> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: annals(),
    );
  }
}

Map<int, Widget> navigator = {
  0: Income_Records(),
  1: Expenses_Records(),
  2: Goals_Records(),
  3: Income_Records(),
  4: Savings_Records()
};

Widget annals(){
  return Center(
    child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return navigator[0]!;
                  })
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 15,
                top: (index == 0)?15:0
              ),
              width: 300,
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
              child: Text('Tap for ${categories[index]} historical records',
                style: TextStyle(
                  color: Colors.white,
                  fontSize:30,
                  // fontWeight: ,
                  // fontFamily: ,
                ),textAlign: TextAlign.center,
              ),
            ),
            ),
          );
        }
      )
  );
}