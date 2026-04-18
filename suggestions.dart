import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softec_app/presenttionlayer/dashboard/goalSuggestions.dart';
import 'package:softec_app/state_management/cubit.dart';

class suggestions extends StatefulWidget {
  const suggestions({super.key});

  @override
  State<suggestions> createState() => _suggestionsState();
}

late Map<int,Widget> suggestions_Nav;

class _suggestionsState extends State<suggestions> {
  late Map<String,List<String>> suggestions;

  @override
  void initState() {
    suggestions_Nav = {

    };
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final projState_instance = BlocProvider.of<project_state>(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: projState_instance.historyRecords.length,
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              onTap: (){

              },
              child: Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 100,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  // color: Colors.teal.shade600,
                  // shape: BoxShape.circle,
                  color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          spreadRadius: 3,
                          color:Color(0xff13095c)
                      ),
                      BoxShadow(

                      ),
                    ]
                ),
                child: Center(
                  child: Text('Click for your suggestions of goal number $index',
                    style: TextStyle(
                      fontSize: 20,
                      // fontFamily: '',
                      // fontWeight: ,
                      color: Colors.white,
                      // letterSpacing: ,
                      // fontStyle: ,
                    ),
                  ),
                ),
              ),
            );
            }
          ),
    );
  }
}
