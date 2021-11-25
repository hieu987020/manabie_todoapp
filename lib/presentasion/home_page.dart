import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manabie_todoapp/data/helper.dart';
import 'package:manabie_todoapp/data/todo.dart';
import 'package:manabie_todoapp/domain/bloc/bloc.dart';
import 'package:manabie_todoapp/presentasion/create_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.objectbox}) : super(key: key);
  final ObjectBox objectbox;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    String status = '';
    if (index == 1) {
      status = 'Complete';
    } else if (index == 2) {
      status = 'Incomplete';
    }
    BlocProvider.of<TodoBloc>(context)
        .add(TodoFetchEvent(status: status, objectBox: widget.objectbox));

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context)
        .add(TodoFetchEvent(status: '', objectBox: widget.objectbox));
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
                            objectbox: widget.objectbox,
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
                imageURL: "assets/images/all.png", color: Colors.grey),
            activeIcon: CustomeItem(
                imageURL: "assets/images/all.png", color: Colors.blue),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: CustomeItem(
                imageURL: "assets/images/complete.png", color: Colors.grey),
            activeIcon: CustomeItem(
                imageURL: "assets/images/complete.png", color: Colors.blue),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: CustomeItem(
                imageURL: "assets/images/incomplete.png", color: Colors.grey),
            activeIcon: CustomeItem(
                imageURL: "assets/images/incomplete.png", color: Colors.blue),
            label: 'Incomplete',
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoFetchSuccess) {
            return TodoPage(
              selectedIndex: _selectedIndex,
              objectBox: widget.objectbox,
            );
          } else if (state is TodoFetchError) {
            return Center(
              child: Container(
                child: Text("Error"),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

class TodoPage extends StatelessWidget {
  const TodoPage({
    Key? key,
    required this.selectedIndex,
    required this.objectBox,
  }) : super(key: key);
  final int selectedIndex;
  final ObjectBox objectBox;
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<TodoBloc>(context).state;
    List<Todo>? todos;
    if (state is TodoFetchSuccess) {
      todos = state.todos;
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
                          // setState(() {
                          //   if (value != null) {
                          //     _complete = value;
                          //   }
                          // });
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
