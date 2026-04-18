import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softec_app/presenttionlayer/dashboard/history.dart';
import 'package:softec_app/state_management/cubit.dart';

class dashboard_screen extends StatefulWidget {
  const dashboard_screen({super.key});

  @override
  State<dashboard_screen> createState() => _dashboard_screenState();
}

class _dashboard_screenState extends State<dashboard_screen> with SingleTickerProviderStateMixin{
  late final TabController newTabController;
  int Selectedindex = 0;
  var controllers = List.generate(5, (int index){
    return TextEditingController();
  });


  @override
  void initState() {
    newTabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var string_cubit = BlocProvider.of<project_state>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130), // Increased to fit title + tabs
        child: AppBar(
          backgroundColor: const Color(0xff13095c),
          flexibleSpace: const FlexibleSpaceBar(
            title: Padding(
              padding: EdgeInsets.only(bottom: 60), // Adjust title position
              child: Text('E-Pense', style: TextStyle(color: Colors.white, fontSize: 33)),
            ),
            centerTitle: true,
          ),
          bottom: TabBar(
            controller: newTabController,
            tabs: const [
              Tab(child: Text('New record',
                style: TextStyle(
                  color: Colors.white,
                  fontSize:15,
                  // fontWeight: ,
                  // fontFamily: ,
                ),textAlign: TextAlign.center,
                ),
              ),
              Tab(child: Text('History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize:15,
                  // fontWeight: ,
                  // fontFamily: ,
                  ),textAlign: TextAlign.center,
                ),
              ),
              Tab(child: Text('suggestions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize:15,
                  // fontWeight: ,
                  // fontFamily: ,
                ),textAlign: TextAlign.center,
              ),
              ),
            ],
          ),
        ),
      ),
      // --- THE CORE FIX: TabBarView ---
      body: TabBarView(
        controller: newTabController,
        children: [
          // TAB 1: NEW RECORD
          _buildNewRecordTab(),

          // TAB 2: STATS (Placeholder)
          history_records(),

          // TAB 3: HISTORY (Placeholder)
          const Center(child: Text("History Logs")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: Selectedindex,
        onTap: (int newindex) {
          setState(() => Selectedindex = newindex);
        },
        selectedItemColor: const Color(0xff13095c),
        unselectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(label: 'Dashboard', icon: Icon(Icons.dashboard_customize_sharp)),
          BottomNavigationBarItem(label: 'Analytics', icon: Icon(Icons.bar_chart)),
          BottomNavigationBarItem(label: 'Results', icon: Icon(Icons.table_chart)),
        ],
      ),
    );
  }

  // Extracted UI for the "New Record" Tab
  Widget _buildNewRecordTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text('Add new income : ', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 70),
              // CRITICAL: TextField MUST be in Expanded/Flexible inside a Row
              SizedBox(
                width: 150,
                child: TextField(
                  controller: controllers[0],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.money),
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black45,
                            width: 1.2
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              const Text('Add new Expense : ', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 64),
              // CRITICAL: TextField MUST be in Expanded/Flexible inside a Row
              SizedBox(
                width: 150,
                child: TextField(
                  controller: controllers[1],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.money),
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black45,
                            width: 1.2
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              const Text('Add new goal : ', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 98),
              // CRITICAL: TextField MUST be in Expanded/Flexible inside a Row
              SizedBox(
                width: 150,
                child: TextField(
                  controller: controllers[2],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.center_focus_strong),
                    hintText: 'Enter purpose',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black45,
                            width: 1.2
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              const Text('Add new Expense : ', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 65),
              // CRITICAL: TextField MUST be in Expanded/Flexible inside a Row
              Expanded(
                child: TextField(
                  controller: controllers[3],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.money),
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black45,
                            width: 1.2
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              const Text('Add new Expense category: ', style: TextStyle(fontSize: 18)),
              // const SizedBox(width: 8),
              // CRITICAL: TextField MUST be in Expanded/Flexible inside a Row
              Expanded(
                child: TextField(
                  controller: controllers[4],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category),
                    hintText: 'Enter type',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black45,
                            width: 1.2
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 2
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height:42),
          TextButton(
              onLongPress: (){

              },
              style: TextButton.styleFrom(
                // foregroundColor: ,
                backgroundColor: Color(0xff13095c),
              ),
              onPressed: (){
                for(int i =0;i < 5; ++i){
                  // Future<SharedPreferences> _newPrefs = SharedPreferences.getInstance();
                  if(controllers[i].text.toString() != null){
                    project_state().getLatestValues(i, controllers[i].text.toString(),
                        controllers[i].text.toString());
                    setState(() {

                    });
                  }
                }
              },
            // onHover: ,
            // onFocusChange: ,
            child: Text('OK',
              style: TextStyle(
                color: Colors.white,
                fontSize:15,
                // fontWeight: ,
                // fontFamily: ,
              ),textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
