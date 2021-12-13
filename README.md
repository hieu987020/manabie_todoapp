# A Flutter project for todo app. Using ObjectBox as local database.
### Example
<img src="https://github.com/hieu987020/todo_objectbox/blob/main/raw/create.gif?raw=true" width="200"/>
<img src="https://github.com/hieu987020/todo_objectbox/blob/main/raw/todo.gif?raw=true" width="200"/>
```dart
import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/objectbox.g.dart';

class TodoProvider {
  TodoProvider(this.objectBox);
  final ObjectBox objectBox;

  List<Todo> fetchTodo(String status) {
    final queryNullText = objectBox.todoBox.query(Todo_.status.contains(status))
      ..order(Todo_.date, flags: Order.descending);
    return queryNullText.build().find();
  }

  Future<List<Todo>> test(String status) async {
    final receivePort = ReceivePort();
    Store? store = await createDataIsolate(receivePort.sendPort);
    final queryNullText = store!
        .box<Todo>()
        .query(Todo_.status.contains(status))
      ..order(Todo_.date, flags: Order.descending);
    return queryNullText.build().find();
  }

  void putTodo(Todo todo) {
    todo.date = DateTime.now();
    objectBox.todoBox.put(todo);
  }
}
```
