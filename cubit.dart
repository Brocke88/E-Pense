import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';
import 'dart:io';

class project_state extends Cubit<List<String>> {
  project_state() : super(['']);

  List<String> latestValues = [];

  void getLatestValues(int index,String new_val){
    latestValues[index] = new_val;
    // return latestValues;
  }
}