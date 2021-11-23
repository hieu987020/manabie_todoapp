import 'package:flutter/material.dart';
import 'package:manabie_todoapp/model/todo.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
      ),
      body: GestureDetector(
        onTap: () {
          viewAll();
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

late ObjectBox objectbox;
Future<void> viewAll() async {
  await ObjectBox.view();
}
