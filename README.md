# A Flutter project todo app.
State management: Bloc pattern </br>
Database: ObjectBox
### Example
<img src="https://github.com/hieu987020/todo_objectbox/blob/main/raw/create.gif?raw=true" width="200"/>
<img src="https://github.com/hieu987020/todo_objectbox/blob/main/raw/todo.gif?raw=true" width="200"/>

### ObjectBox database

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
### Development
```
[√] Flutter (Channel stable, 2.5.3, on Microsoft Windows [Version 10.0.19043.1348], locale en-US)
[√] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
[√] Chrome - develop for the web
[√] Android Studio (version 4.2)
[√] VS Code (version 1.63.0)
[√] Connected device (3 available)
```
