import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';
import 'dart:io';

class project_state extends Cubit<List<String>> {
  project_state() : super(['']);

  List<String> latestValues = [];
  Map<int, List<String>> historyRecords = {};

  ProjectState() {
  latestValues = List<String>.filled(6, '');  // Pre-allocate indices 0-5
  historyRecords = <int, List<String>>{};          // Empty map
  }

  Future<void> getLatestValues(int index, String category, String new_val) async {
  try {
    // 1. LIST: Convert 1-based → 0-based index
    int listIndex = index - 1;

    if (listIndex < 0 || listIndex >= latestValues.length) {
      print('❌ Invalid list index $listIndex for input $index');
      return;
    }

      // Update latestValues (List)
      latestValues[listIndex] = new_val;

      // 2. MAP: Initialize index if missing
      if (!historyRecords.containsKey(index)) {
        historyRecords[index] = [];  // dynamic = Map
      }

        // Ensure category exists in the map
        Map<String, List<String>> record = {

        };
        if (!record.containsKey(category)) {
        record[category] = <String>[];
      }

      // Add to history
      record[category]!.add(new_val);

      print('✅ SAVED: latestValues[$listIndex]="$new_val" | historyRecords[$index][$category].length=${record[category]!.length}');

      } catch (e) {
      print('❌ Error($index, $category, $new_val): $e');
      rethrow;
    }}
  }
