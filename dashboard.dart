import 'package:flutter/material.dart';
import 'package:softec_app/presenttionlayer/dashboard/history.dart';
import 'package:softec_app/presenttionlayer/dashboard/suggestions.dart';
import 'package:softec_app/state_management/cubit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late final TabController newTabController;
  late List<TextEditingController> controllers;
  final project_state projectState = project_state();

  @override
  void initState() {
    super.initState();
    controllers = List.generate(5, (index) => TextEditingController());
    newTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    for (var controller in controllers) controller.dispose();
    newTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: AppBar(
          backgroundColor: const Color(0xff13095c),
          flexibleSpace: const FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Text('E-Pense', style: TextStyle(color: Colors.white, fontSize: 33)),
            ),
            centerTitle: true,
          ),
          bottom: TabBar(
            controller: newTabController,
            tabs: const [
              Tab(text: 'New Record'),
              Tab(text: 'History'),
              Tab(text: 'Suggestions'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: newTabController,
        children: [
          _buildNewRecordTab(),
          const history_records(),  // ✅ Proper const widgets
          const suggestions(),
        ],
      ),
    );
  }

  Widget _buildNewRecordTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildInputRow('Income', Icons.account_balance_wallet, 0),
          const SizedBox(height: 14),
          _buildInputRow('Expense 1', Icons.payment, 1),
          const SizedBox(height: 14),
          _buildInputRow('Goal', Icons.flag, 2),
          const SizedBox(height: 14),
          _buildInputRow('Saving', Icons.savings, 3),
          const SizedBox(height: 14),
          _buildInputRow('Category', Icons.category, 4),
          const SizedBox(height: 42),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildInputRow(String label, IconData icon, int index) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text('$label: ', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: controllers[index],
            keyboardType: TextInputType.number, // ✅ Numbers only
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xff13095c)),
              hintText: 'Enter $label',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xff13095c), width: 2),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (value) {
              // ✅ Real-time validation
              if (value.isNotEmpty && double.tryParse(value) == null) {
                controllers[index].text = '';
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          await _saveAllData();
        },
        icon: const Icon(Icons.save, color: Colors.white),
        label: const Text(
          'SAVE',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff13095c),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
      ),
    );
  }

  Future<void> _saveAllData() async {
    print('🔥 SAVING TO CUBIT...');
    print('Input values:');
    for (int i = 0; i < 5; i++) {
      print('  Index ${i+1}: "${controllers[i].text}"');
    }

    // ✅ SAVE EACH INPUT TO CUBIT
    for (int i = 0; i < 5; i++) {
      String value = controllers[i].text.trim();
      if (value.isNotEmpty) {
        try {
          // ✅ CRITICAL: Pass correct params to getLatestValues
          await projectState.getLatestValues(
            i + 1,        // index (1-5)
            value,        // category
            value,        // new_val
          );
          print('✅ SAVED Index ${i+1}: "$value"');
        } catch (e) {
          print('❌ ERROR Index ${i+1}: $e');
        }
      }
    }

    // ✅ Clear inputs after save
    for (var controller in controllers) {
      controller.clear();
    }

    // ✅ Refresh UI + Feedback
    if (mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ All data saved to cubit!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }

    // ✅ Verify save
    await Future.delayed(const Duration(milliseconds: 100));
    print('\n📊 CUBIT AFTER SAVE:');
    print('latestValues: ${projectState.latestValues}');
    print('historyRecords keys: ${projectState.historyRecords.keys.toList()}');
    print('historyRecords[1]: ${projectState.historyRecords[1]}');
  }
}