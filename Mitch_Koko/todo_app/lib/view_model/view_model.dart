import 'package:hive_ce/hive.dart';

class TodoDataBase {
  List todoList = [];

  final _myBox = Hive.box("My_Box");

  void createInitialData() {
    todoList = [
      ["Make Tutorial", false],
      ["Do Exercise", true],
    ];
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", todoList);
  }
}
