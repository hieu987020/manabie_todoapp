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

Future<Store?> createDataIsolate(SendPort sendPort) async {
  // Open the ReceivePort to listen for incoming messages
  final port = ReceivePort();

  // Send the port where the main isolate can contact us
  sendPort.send(port.sendPort);
  print("hello");
  Store? store;
  // Listen for messages
  await for (final msg in port) {
    if (store == null) {
      print("hi");
      // first message data is Store's C pointer address
      store = Store.fromReference(getObjectBoxModel(), msg as ByteData);
      return store;
    }
  }
}
