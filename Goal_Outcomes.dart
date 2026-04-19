import 'package:flutter/material.dart';
import 'package:softec_app/state_management/cubit.dart';

class Goals extends StatefulWidget {
  const Goals({super.key});

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  final project_state state = project_state(); // ✅ Direct instance - NO BLOC

  @override
  Widget build(BuildContext context) {
    // ✅ Safe data extraction
    dynamic goalsData = state.historyRecords[3];
    if (goalsData == null || goalsData.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No goals data yet!')),
      );
    }

    List<dynamic> goalsList = goalsData.values.toList(); // ✅ Safe conversion
    int itemCount = goalsList.length;

    return Scaffold(
      body: ListView.builder(
        itemCount: itemCount, // ✅ Safe count
        itemBuilder: (context, index) {
          // ✅ Safe income/expense data
          dynamic incomeData = state.historyRecords[1];
          dynamic expenseData = state.historyRecords[2];

          int income = 0, expense = 0;
          if (incomeData != null && incomeData.isNotEmpty) {
            income = incomeData.values.first.length; // ✅ Safe first value
          }
          if (expenseData != null && expenseData.isNotEmpty) {
            expense = expenseData.values.first.length;
          }

          int success = income - expense; // ✅ Safe calculation
          int failure = -success;
          bool isSuccess = success > 0; // ✅ Simple logic

          return Container(
            width: 400,
            height: 200,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSuccess ? Colors.green : Colors.red,
              boxShadow: const [
                BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 8),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Goal #$index ${isSuccess ? "✅ MET" : "❌ FAILED"}',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isSuccess ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isSuccess
                      ? 'Success Margin: +$success'
                      : 'Failure Margin: $failure',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}