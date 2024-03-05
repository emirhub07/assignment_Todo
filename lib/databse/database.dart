import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List todoList = [];

//reference hive box
  final _myBox = Hive.box('mybox');

  ///first time opening app
  void createInitialdata() {
    todoList = [
      ["Work Out", false],
      ["Study", false]
    ];
  }

// load data from databse

  void LoadData() {
    todoList = _myBox.get("TODOLIST");
  }

//update the database
  void updatedatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
