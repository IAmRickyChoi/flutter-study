import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:habit_tracker/widgets/habit_title.dart';
import 'package:habit_tracker/widgets/montly_summary.dart';
import 'package:habit_tracker/widgets/my_fab.dart';
import 'package:habit_tracker/widgets/my_alert_box.dart';
import 'package:hive_ce/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HabitDatabase db = HabitDatabase();
  final _mybox = Hive.box("Habit_Database");

  @override
  void initState() {
    if (_mybox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateDatabase();

    super.initState();
  }

  void CheckboxTapped(bool? value, int index) {
    setState(() {
      db.todayHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: db.todayHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
    db.updateDatabase();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todayHabitList[index][0] = _newHabitNameController.text;
    });
    Navigator.of(context).pop();
    _newHabitNameController.clear();
    db.updateDatabase();
  }

  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter Habit Name',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todayHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todayHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView(
        children: [
          ///need check
          MontlySummary(
            datasets: db.heatMapDataSet,
            startDate: _mybox.get("START_DATE"),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: db.todayHabitList.length,
            itemBuilder: (context, index) {
              return HabitTitle(
                habitName: db.todayHabitList[index][0],
                habitCompleted: db.todayHabitList[index][1],
                onChanged: (value) => CheckboxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.grey[300],
  //     floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
  //     body: ListView.builder(
  //       itemCount: db.todayHabitList.length,
  //       itemBuilder: (context, index) {
  //         return HabitTitle(
  //           habitName: db.todayHabitList[index][0],
  //           habitCompleted: db.todayHabitList[index][1],
  //           onChanged: (value) => CheckboxTapped(value, index),
  //           settingsTapped: (context) => openHabitSettings(index),
  //           deleteTapped: (context) => deleteHabit(index),
  //         );
  //       },
  //     ),
  //   );
  // }
}
