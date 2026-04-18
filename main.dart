import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'dart:async';

import 'package:softec_app/dashboard.dart';
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
  @override
  Widget build(BuildContext context) {
    return dashboard_screen();
  }
}
