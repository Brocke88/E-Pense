import 'package:flutter/material.dart';
import 'package:softec_app/presenttionlayer/dashboard/history.dart';
import 'package:softec_app/presenttionlayer/dashboard/suggestions.dart';
import 'package:softec_app/state_management/cubit.dart';

class DashboardScreen extends StatefulWidget { // ✅ PascalCase
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController newTabController;
  late List<TextEditingController> controllers; // ✅ Late + typed
  final project_state projectState = project_state(); // ✅ Direct instance

  @override
  void initState() {
    super.initState(); // ✅ super first
    controllers = List.generate(5, (index) => TextEditingController()); // ✅ initState
    newTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    for (var controller in controllers) controller.dispose(); // ✅ Memory safety
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
          const history_records(),
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
          _buildInputRow('saving', Icons.credit_card, 3),
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
        Text('$label: ', style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 20),
        Expanded( // ✅ Flexible layout
          child: TextField(
            controller: controllers[index],
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xff13095c)),
              hintText: 'Enter $label',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xff13095c), width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onLongPress: () {
          for (var controller in controllers) controller.clear();
          if (mounted) setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fields cleared!')),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xff13095c),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () async {
          print('🔥 SAVE PRESSED');
          print('BEFORE: latestValues=${projectState.latestValues}');

          for (int i = 0; i < 5; i++) {
            if (controllers[i].text.isNotEmpty) {
              await projectState.getLatestValues(i + 1, controllers[i].text, controllers[i].text);
              print('✅ Saved ${i+1}: "${controllers[i].text}"');
              controllers[i].clear();
            }
          }

          await Future.delayed(const Duration(milliseconds: 200));

          print('AFTER: latestValues=${projectState.latestValues}');
          print('historyRecords=${projectState.historyRecords}');

          if (mounted) {
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Saved!'), backgroundColor: Colors.green),
            );
          }
        },
        child: const Text(
          'SAVE ALL DATA',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}