import 'package:flutter/material.dart';
import 'package:manabie_todoapp/presentasion/create_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

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
                  MaterialPageRoute(builder: (context) => CreateTask()),
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
  const CustomeItem({
    Key key,
    @required this.imageURL,
    @required this.color,
  }) : super(key: key);

  final String imageURL;
  final Color color;

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
  const TodoPage({Key key, @required this.selectedIndex}) : super(key: key);
  final int selectedIndex;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  bool _complete = false;
  @override
  Widget build(BuildContext context) {
    String _title;
    if (widget.selectedIndex == 0) {
      _title = 'All todos';
    } else if (widget.selectedIndex == 1) {
      _title = 'Complete todos';
    } else {
      _title = 'Incomplete todos';
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
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100.0,
                      color: Colors.red,
                      width: double.infinity,
                      child: CheckboxListTile(
                        value: _complete,
                        onChanged: (value) {
                          setState(() {
                            _complete = value;
                          });
                        },
                        title: Text(
                          _title,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(
                          "Hello world and loser",
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
