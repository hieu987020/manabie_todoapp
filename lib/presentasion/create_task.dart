import 'package:flutter/material.dart';
import 'package:manabie_todoapp/data/helper.dart';
import 'package:manabie_todoapp/data/todo.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.objectbox}) : super(key: key);
  final ObjectBox objectbox;
  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  void create() {
    widget.objectbox.todoBox
        .put(Todo(name: 'Todo 100', detail: 'do homework 100'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: GestureDetector(
        onTap: () {
          create();
        },
        child: Center(
          child: Container(
            width: 100,
            height: 50,
            child: Text("Click Here"),
          ),
        ),
      ),
    );
  }
}
