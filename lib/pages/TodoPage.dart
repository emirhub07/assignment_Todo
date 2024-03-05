import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:todo/databse/database.dart';
import 'package:todo/util/TodoTile.dart';
import 'package:todo/util/mydialog.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
//reference hive box
  final _myBox = Hive.box('mybox');
//list of tdo task
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    super.initState();
    // if this is first time openin the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialdata();
    } else {
      // already exist data
      db.LoadData();
    }
  }

// text contrller
  final _controller = TextEditingController();

  //check box changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
      db.updatedatabase();
    });
  }

//save new task
//   void saveNewTask() {
//     setState(() {
//       db.todoList.add([_controller.text, false]);
//       Navigator.of(context).pop();
//       _controller.clear();
//     });
//   }

  void saveNewTask() {
    if (_controller.text.isEmpty) {
      // Show a toast if the text is empty
      Fluttertoast.showToast(
        msg: "Task cannot be empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      setState(() {
        db.todoList.add([_controller.text, false]);
        Navigator.of(context).pop();
        _controller.clear();
      });
    }
  }

// create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return Mydialog(
          controller: _controller,
          onCancel: () {
            Navigator.of(context).pop();
          },
          onSave: saveNewTask,
        );
      },
    );
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            "List Your Things To DO.....!",
          ),
          backgroundColor: Colors.grey[500],
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: createNewTask,
          backgroundColor: Colors.grey[400],
          elevation: 0,
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ),
      ),
    );
  }
}
