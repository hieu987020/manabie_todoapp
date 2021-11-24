import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:manabie_todoapp/data/helper.dart';
import 'package:manabie_todoapp/data/todo.dart';
import 'package:manabie_todoapp/objectbox.g.dart';
import 'package:manabie_todoapp/presentasion/create_task.dart';
import 'package:manabie_todoapp/presentasion/home_page.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomePage(key: key),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Create Task") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateTask(
                            objectbox: objectbox,
                          )),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Create Task', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: CustomeItem(
              imageURL: "assets/images/all.png",
              color: Colors.grey,
            ),
            activeIcon: CustomeItem(
              imageURL: "assets/images/all.png",
              color: Colors.blue,
            ),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: CustomeItem(
              imageURL: "assets/images/complete.png",
              color: Colors.grey,
            ),
            activeIcon: CustomeItem(
              imageURL: "assets/images/complete.png",
              color: Colors.blue,
            ),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: CustomeItem(
              imageURL: "assets/images/incomplete.png",
              color: Colors.grey,
            ),
            activeIcon: CustomeItem(
              imageURL: "assets/images/incomplete.png",
              color: Colors.blue,
            ),
            label: 'Incomplete',
          ),
        ],
      ),
      body: TodoPage(selectedIndex: _selectedIndex),
    );
  }
}

class CustomeItem extends StatelessWidget {
  final String imageURL;
  final Color color;

  CustomeItem({
    Key? key,
    required this.imageURL,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Image.asset(
        imageURL,
        color: color,
        fit: BoxFit.fill,
      ),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key, required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  bool _complete = false;
  List<Todo>? todos;
  final TodoProvider provider = new TodoProvider();

  void changePage() {
    if (widget.selectedIndex == 0) {
      todos = objectbox.todoBox.getAll();
    } else if (widget.selectedIndex == 1) {
      final queryNullText =
          objectbox.todoBox.query(Todo_.status.contains('Complete')).build();
      todos = queryNullText.find();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedIndex == 0) {
      todos = objectbox.todoBox.getAll();
      todos?.forEach((element) {
        log(element.name);
        log(element.detail ?? 'nothing');
        log(element.status);
      });
    } else if (widget.selectedIndex == 1) {
      final queryNullText =
          objectbox.todoBox.query(Todo_.status.contains('Complete')).build();
      todos = queryNullText.find();
      todos?.forEach((element) {
        log(element.name);
        log(element.detail ?? 'nothing');
        log(element.status);
      });
    } else {
      final queryNullText =
          objectbox.todoBox.query(Todo_.status.contains('Incomplete')).build();
      todos = queryNullText.find();
      todos?.forEach((element) {
        log(element.name);
        log(element.detail ?? 'nothing');
        log(element.status);
      });
    }
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: todos?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.0,
                      color: todos?.elementAt(index).status == 'Complete'
                          ? Colors.green
                          : Colors.yellow,
                      width: double.infinity,
                      child: CheckboxListTile(
                        value: todos?.elementAt(index).status == 'Complete'
                            ? true
                            : false,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _complete = value;
                            }
                          });
                        },
                        title: Text(
                          todos?.elementAt(index).name ?? 'nothing',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(
                          todos?.elementAt(index).detail ?? 'nothing',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
